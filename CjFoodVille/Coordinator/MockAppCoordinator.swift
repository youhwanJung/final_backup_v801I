//
//  MockAppCoordinator.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/29/25.
//

import Foundation

/**
 preview
 */
class MockAppCoordinator: AppCoordinator {
    init() {
        super.init(resolver: DummyResolver())
    }
    
    override func goToDetail() {
        print("preview - goToDetail")
    }
}
