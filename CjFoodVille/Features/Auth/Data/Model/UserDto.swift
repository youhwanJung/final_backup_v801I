//
//  UserDto.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/28/25.
//

import Foundation

struct UserDto: Codable {
    let name: String
    let age: Int
    let address: String
    let selfIntroduction: String
    
    func toDomain() -> User {
        return User(
            name: name,
            age: age,
            address: address,
            selfIntroduction: selfIntroduction
        )
    }
    
    func toJSON() throws -> Data {
        return try JSONEncoder().encode(self)
    }
}
