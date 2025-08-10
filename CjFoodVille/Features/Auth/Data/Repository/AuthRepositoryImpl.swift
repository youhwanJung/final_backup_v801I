//
//  AuthRepositoryImpl.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation
import LocalAuthentication

class AuthRepositoryImpl: AuthRepository {
    func getServer() async throws -> String {
        let response: [MockUserDto] = try await APIClient.shared.request(
            path: "/users",
            method: "GET",
            responseType: [MockUserDto].self
        )
        let jsonString: String = convertToJSONString(from: response) ?? "{}"
        return jsonString
    }
    
    func postServer() async throws -> String {
        let userDto = UserDto(
            name: "정유환",
            age: 25,
            address: "경기도 시흥시 장곡로 53번길 10",
            selfIntroduction: "안녕하십니까. Mobile 개발자입니다."
        )
        let response: UserDto = try await APIClient.shared.request(
            path: "/users",
            method: "POST",
            body: userDto.toJSON(),
            responseType: UserDto.self
        )
        let jsonString: String = convertToJSONString(from: response) ?? "{}"
        return jsonString
    }
    
    
    func biometric() async throws -> BioResult {
        let context = LAContext() //생체 인증을 처리하는 중앙 객체
        let reason = "인증이 필요합니다."
        /**
         - 생체 인증이 가능한지 확인
         - 실제 생체 인증 실행
         */
        var biometricError: NSError?
        /**
         생체 인증 가능한지 확일때의 메세지를 받을 수 있는 변수
         */
        /**
         gured
         - 조건을 검사해서 조건이 false일때, 특정코드를 실행하는 구문.
         - 지금은 context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &biometricError)
         함수(이함수는 생체인식을 사용할수있는지를 반환한다) 를 판단해서 false면 리턴한다.
         */
        guard context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &biometricError) else {
            if let error = biometricError as? LAError {
                switch error.code {
                case .biometryNotAvailable:
                    return BioResult(result: false, text: "생체 인식 기능 없음")
                case .biometryNotEnrolled:
                    return BioResult(result: false, text: "생체 정보가 등록되어 있지 않음")
                case .biometryLockout:
                    return BioResult(result: false, text: "생체 인증 잠김 (너무 많은 실패)")
                default:
                    return BioResult(result: false, text: "알 수 없는 오류: \(error.localizedDescription)")
                }
            }
            return BioResult(result: false, text: "생체 인증 불가")
        }
        /**
         withCheckedThrowingContinuation : 옛날 스타일 콜백 함수들을 수 async/awiat Fukin 최신으로 바꿔주는 함수
         1. 옛날 Swift API들은 어떤 일이 끝나면 completion이라는 콜백함수를 호출하는데. 지금은 async/await 가 생겼기 때문에 withCheckedThrowingContinuation 를 사용하여 리턴해준다.
         2. 지금 같은경우 context.evaluatePolicy 같이 비동기 콜백함수를 썼을 때 사용하게 되는데 continuation 이라는 친구가 resume이 올때가지 기다렸다가
         3. resume이 오면 await가 끝남을 인식하고 리턴해준다.
         */
        return try await withCheckedThrowingContinuation { continuation in
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason) { success, error in
                if success {
                    continuation.resume(returning: BioResult(result: true, text: "생체 인증 성공"))
                } else {
                    if let error = error as? LAError {
                        switch error.code {
                        case .authenticationFailed:
                            continuation.resume(returning: BioResult(result: false, text: "사용자 인증 실패"))
                        case .userCancel:
                            continuation.resume(returning: BioResult(result: false, text: "사용자가 취소함"))
                        case .userFallback:
                            continuation.resume(returning: BioResult(result: false, text: "비밀번호 입력 선택"))
                        case .biometryNotAvailable:
                            continuation.resume(returning: BioResult(result: false, text: "생체 인식 기능 없음"))
                        case .biometryNotEnrolled:
                            continuation.resume(returning: BioResult(result: false, text: "생체 정보가 등록되어 있지 않음"))
                        case .biometryLockout:
                            continuation.resume(returning: BioResult(result: false, text: "생체 인증 잠김 (너무 많은 실패)"))
                        default:
                            continuation.resume(returning: BioResult(result: false, text: "알 수 없는 오류: \(error.localizedDescription)"))
                        }
                    } else {
                        continuation.resume(returning: BioResult(result: false, text: "인증 실패: 알 수 없는 오류"))
                    }
                }
            }
        }
    }
    
    func convertToJSONString<T: Codable>(from object: T) -> String? {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted
        do {
            let data = try encoder.encode(object)
            return String(data: data, encoding: .utf8)
        } catch {
            print("JSON 인코딩 실패: \(error)")
            return nil
        }
    }
}
