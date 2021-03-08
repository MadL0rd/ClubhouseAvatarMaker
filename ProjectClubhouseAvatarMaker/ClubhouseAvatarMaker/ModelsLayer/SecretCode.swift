//
//  SecretCodes.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import Foundation

struct SecretCode: Codable {
    
    let id: Int
    let brand: String
    let code: String
    let description: String
    
    enum CodingKeys: String, CodingKey {
        case id = "id"
        case brand = "brand"
        case code = "name"
        case description = "description"
    }
}
