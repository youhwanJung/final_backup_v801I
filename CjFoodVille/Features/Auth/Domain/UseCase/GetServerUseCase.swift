//
//  FetchUserUseCase.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation

class GetServerUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() async throws -> String {
        return try await authRepository.getServer()
    }
}

/**
 preview
 */
extension GetServerUseCase {
    static var preview: GetServerUseCase {
        let mockRepositoryImpl = MockAuthRepositoryImpl()
        return GetServerUseCase(authRepository: mockRepositoryImpl)
    }
}
