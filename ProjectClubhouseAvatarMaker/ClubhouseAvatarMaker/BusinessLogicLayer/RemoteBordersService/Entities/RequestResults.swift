//
//  RequestResults.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Foundation

struct GetBordersResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [RemoteBorder]
}
