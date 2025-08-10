//
//  CoordinatorAssembly.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation
import Swinject

class CoordinatorAssembly: Assembly {
    func assemble(container: Container) {
        container.register(AppCoordinator.self){ resolver in
            AppCoordinator(resolver: resolver)
        }
        .inObjectScope(.container)
    }
}
