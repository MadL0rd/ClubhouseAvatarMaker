//
//  Errors.swift
//  Uapp
//
//  Created by Антон Текутов on 25.10.2020.
//

import Foundation

enum ImageAssetsError: Error {
    case assetIsNotImage
    case unknown
    
    var localizedDescription: String {
        switch self {
        case .assetIsNotImage:
            return NSLocalizedString("unknownError", comment: "")
        case .unknown:
            return NSLocalizedString("unknownError", comment: "")
        }
    }
}
