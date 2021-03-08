//
//  Errors.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Alamofire

enum NetworkServiceError: Int, Error {
    case cannotParceData
    case unknown
    case badToken = 201
    case badRoute = 404
    case badRequestDataFormat = 500
    
    var localizedDescription: String {
        switch self {
        case .cannotParceData:
            return NSLocalizedString("cannotParceData", comment: "")
        case .unknown:
            return NSLocalizedString("unknown", comment: "")
        case .badToken:
            return NSLocalizedString("badToken", comment: "")
        case .badRoute:
            return NSLocalizedString("badRoute", comment: "")
        case .badRequestDataFormat:
            return NSLocalizedString("badRequestDataFormat", comment: "")
        }
    }
}

enum RequestBuildError: Error {
    case cannotCreateUrl
}
