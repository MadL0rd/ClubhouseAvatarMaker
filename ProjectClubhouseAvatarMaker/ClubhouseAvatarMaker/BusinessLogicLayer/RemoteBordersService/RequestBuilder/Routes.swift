//
//  Routes.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Alamofire

enum ApiUappRoutes: String, URLConvertible {
    static let endpoint = "http://80.78.247.50/api/"
    
    case borders = "borders/"
    
    func asURL() throws -> URL {
        guard let url = URL(string: ApiUappRoutes.endpoint + self.rawValue)
        else { throw RequestBuildError.cannotCreateUrl }
        return url
    }
    
    static func makeAuthHeadersFromToken(token: String, contentType: ContentType? = nil) -> HTTPHeaders {
        if let contentType = contentType {
            return ["Authorization": "Token \(token)", "Content-Type": contentType.rawValue]
        } else {
            return ["Authorization": "Token \(token)"]
        }
    }
}

enum ContentType: String {
    case json = "application/json"
    case formData = "multipart/form-data"
}
