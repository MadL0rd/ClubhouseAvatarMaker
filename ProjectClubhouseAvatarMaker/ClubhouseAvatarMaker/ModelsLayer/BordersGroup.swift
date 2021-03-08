//
//  BordersGroup.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import Foundation

protocol BordersGroupProtocol {
    
    var title: String? { get }
    var borders: [BorderProtocol] { get }
    
    mutating func appendBorders(_ contentsOf: [BorderProtocol])
}

struct BordersGroupRemote: BordersGroupProtocol, Codable {
    
    let title: String?
    var remotesBorders: [RemoteBorder]
    
    var borders: [BorderProtocol] {
        return remotesBorders
    }
    
    mutating func appendBorders(_ contentsOf: [BorderProtocol]) {
        guard let borders = contentsOf as? [RemoteBorder]
        else { return }
        remotesBorders.append(contentsOf: borders)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "brand"
        case remotesBorders = "borders"
    }
}

struct BordersGroupLocal: BordersGroupProtocol {
    
    let title: String?
    var borders: [BorderProtocol]
    
    mutating func appendBorders(_ contentsOf: [BorderProtocol]) {
        borders.append(contentsOf: contentsOf)
    }
    
    enum CodingKeys: String, CodingKey {
        case title = "brand"
        case borders = "borders"
    }
}

