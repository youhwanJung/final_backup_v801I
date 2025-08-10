//
//  AuthRepository.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation

protocol AuthRepository {
    func biometric() async throws -> BioResult
    func postServer() async throws -> String
    func getServer() async throws -> String
}
