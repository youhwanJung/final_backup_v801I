//
//  SplashViewModel.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/26/25.
//

import Foundation
import Combine

class AuthViewModel: ObservableObject {
    @Published var biometricResultMessage: String? = nil
    @Published var showBiometricLogicAlert: Bool = false
    @Published var longlongText: String? = nil
    @Published var isLock = true
    
    private let biometricUseCase: BiometricUseCase
    private let postServerUseCase: PostServerUseCase
    private let getServerUseCase: GetServerUseCase
    
    init(
        biometricUseCase: BiometricUseCase,
        postServerUseCase: PostServerUseCase,
        getServerUseCase: GetServerUseCase
    ) {
        self.biometricUseCase = biometricUseCase
        self.postServerUseCase = postServerUseCase
        self.getServerUseCase = getServerUseCase
    }
    
    /*생체 인증 로직*/
    func biometricLogic() async -> Void {
        do {
            let result = try await biometricUseCase.execute()
            await MainActor.run {
                self.biometricResultMessage = result.text
                self.isLock = false
                self.showBiometricLogicAlert = true
            }
        } catch {
            await MainActor.run {
                self.biometricResultMessage = "인증 중 오류 발생: \(error.localizedDescription)"
                self.showBiometricLogicAlert = true
            }
        }
    }
    
    func postServer() async {
        do {
            let result = try await postServerUseCase.execute()
            
            await MainActor.run {
                if let existing = self.longlongText {
                    self.longlongText = existing + "\n" + result
                } else {
                    self.longlongText = result
                }
            }
            
        } catch {
            await MainActor.run {
                self.longlongText = "Error: \(error.localizedDescription)"
            }
        }
    }
    
    func getServer() async {
        do {
            let result = try await getServerUseCase.execute()
            
            await MainActor.run {
                if let existing = self.longlongText {
                    self.longlongText = existing + "\n" + result
                } else {
                    self.longlongText = result
                }
            }
            
        } catch {
            await MainActor.run {
                self.longlongText = "Error: \(error.localizedDescription)"
            }
        }
    }
}
/**
 preview
 */
extension AuthViewModel {
    static var preview: AuthViewModel {
        return AuthViewModel(
            biometricUseCase: BiometricUseCase.preview,
            postServerUseCase: PostServerUseCase.preview,
            getServerUseCase: GetServerUseCase.preview
        )
    }
}
