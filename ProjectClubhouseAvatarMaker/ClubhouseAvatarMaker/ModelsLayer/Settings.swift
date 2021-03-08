//
//  Settings.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import Foundation

struct SettingsRemote: Codable {
    
    let version: String
    
    enum CodingKeys: String, CodingKey {
        case version = "requiredVersion"
    }
}
