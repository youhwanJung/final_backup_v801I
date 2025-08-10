//
//  MockUserDto.swift
//  CjFoodVille
//
//  Created by 정유환 on 7/30/25.
//

import Foundation

struct  MockUserDto: Codable {
    let id: Int
    let name: String
    let username: String
    let email: String
    let address: MockAddressDto
    let phone: String
    let website: String
    let company: MockCompanyDto
}

struct MockAddressDto: Codable {
    let street: String
    let suite: String
    let city: String
    let zipcode: String
    let geo: MockGeoDto
}

struct MockGeoDto: Codable {
    let lat: String
    let lng: String
}

struct MockCompanyDto: Codable {
    let name: String
    let catchPhrase: String
    let bs: String
}

extension MockUserDto {
    func toDomain() -> MockUser {
        return MockUser(
            id: id,
            name: name,
            username: username,
            email: email,
            address: address.toDomain(),
            phone: phone,
            website: website,
            company: company.toDomain()
        )
    }
}

extension MockAddressDto {
    func toDomain() -> MockAddress {
        return MockAddress(
            street: street,
            suite: suite,
            city: city,
            zipcode: zipcode,
            geo: geo.toDomain()
        )
    }
}

extension MockGeoDto {
    func toDomain() -> MockGeo {
        return MockGeo(
            lat: Double(lat) ?? 0.0,
            lng: Double(lng) ?? 0.0
        )
    }
}

extension MockCompanyDto {
    func toDomain() -> MockCompany {
        return MockCompany(
            name: name,
            catchPhrase: catchPhrase,
            bs: bs
        )
    }
}

