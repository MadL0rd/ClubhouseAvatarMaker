//
//  RequestResults.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Foundation

struct GetSettingsResult: Codable {
    let id: Int
    let settings: SettingsRemote
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case settings = "data"
    }
}

struct GetTokenResult: Codable {
    
    let token: String?
}

typealias GetAccountCodesResult = [SecretCode]

struct GetBordersResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [RemoteBorder]
}

typealias GetBrandedBordersResult = [BordersGroupRemote]

