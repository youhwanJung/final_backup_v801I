//
//  MockModel.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/30/25.
//

import Foundation

struct MockUser: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: MockAddress
    let phone: String
    let website: String
    let company: MockCompany
}

struct MockAddress: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: MockGeo
}

struct MockGeo: Codable {
    let lat: Double
    let lng: Double
}

struct MockCompany: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}
