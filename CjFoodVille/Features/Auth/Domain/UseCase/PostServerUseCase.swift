//
//  FetchUserUseCase.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation

class PostServerUseCase {
    private let authRepository: AuthRepository
    
    init(authRepository: AuthRepository) {
        self.authRepository = authRepository
    }
    
    func execute() async throws -> String {
        return try await authRepository.postServer()
    }
}

/**
 preview
 */
extension PostServerUseCase {
    static var preview: PostServerUseCase {
        let mockRepositoryImpl = MockAuthRepositoryImpl()
        return PostServerUseCase(authRepository: mockRepositoryImpl)
    }
}
