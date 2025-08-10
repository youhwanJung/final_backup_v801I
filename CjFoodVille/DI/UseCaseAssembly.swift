//
//  ViewModelAssembly.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation
import Swinject

class UseCaseAssembly: Assembly {
    func assemble(container: Container) {
        container.register(BiometricUseCase.self) { resolver in
            let repo = resolver.resolve(AuthRepository.self)!
            return BiometricUseCase(authRepository: repo)
        }
        container.register(PostServerUseCase.self) { resolver in
            let repo = resolver.resolve(AuthRepository.self)!
            return PostServerUseCase(authRepository: repo)
        }
        container.register(GetServerUseCase.self) { resolver in
            let repo = resolver.resolve(AuthRepository.self)!
            return GetServerUseCase(authRepository: repo)
        }
    }
}
