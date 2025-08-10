//
//  ViewModelAssembly.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation
import Swinject

class ViewModelAssembly: Assembly {
    func assemble(container: Container) {
        /**
         SplashViewModel Inject
         */
        container.register(SplashViewModel.self) { _ in
            return SplashViewModel()
        }
        /**
         AuthViewModel Inject
         */
        container.register(AuthViewModel.self) { resolver in
            let biometricUseCase = resolver.resolve(BiometricUseCase.self)!
            let postServerUseCase = resolver.resolve(PostServerUseCase.self)!
            let getServerUseCase = resolver.resolve(GetServerUseCase.self)!
            return AuthViewModel(
                biometricUseCase: biometricUseCase,
                postServerUseCase: postServerUseCase,
                getServerUseCase: getServerUseCase
            )
        }
        
        container.register(BarcodeScannerViewModel.self) { _ in
            return BarcodeScannerViewModel()
        }
    }
}
