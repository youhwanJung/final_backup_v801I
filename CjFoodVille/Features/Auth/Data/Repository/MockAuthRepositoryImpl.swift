//
//  AuthRepositoryImpl.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation

/**
 preview
 */
class MockAuthRepositoryImpl: AuthRepository {
    func getServer() async throws -> String {
        return "Mock Get String"
    }
    
    func postServer() async throws -> String {
        return "Mock Post String"
    }
    
    func biometric() async throws -> BioResult {
        return BioResult(result: true, text: "Preview biometric Logic Success!")
    }
}
