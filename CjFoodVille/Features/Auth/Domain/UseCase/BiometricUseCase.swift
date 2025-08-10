//
//  FetchUserUseCase.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation

class BiometricUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() async throws -> BioResult {
        return try await authRepository.biometric()
    }
}

/**
 preview
 */
extension BiometricUseCase {
    static var preview: BiometricUseCase {
        let mockRepositoryImpl = MockAuthRepositoryImpl()
        return BiometricUseCase(authRepository: mockRepositoryImpl)
    }
}
