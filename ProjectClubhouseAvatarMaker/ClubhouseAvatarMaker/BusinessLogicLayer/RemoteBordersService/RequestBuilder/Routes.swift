//
//  Routes.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Alamofire

enum ApiClRoutes: String, URLConvertible {
    
    static let endpoint = "http://ava.cherrydev.tech/api/"
    
    case settings = "setting_json/1/"
    case getToken = "get_token/"
    case codes = "codes/"
    case borders = "borders/"
    case bordersBranded = "borders_new/"

    func asURL() throws -> URL {
        guard let url = URL(string: ApiClRoutes.endpoint + self.rawValue)
        else { throw RequestBuildError.cannotCreateUrl }
        return url
    }
    
    static func makeAuthHeadersFromToken(token: String, contentType: ContentType? = nil) -> HTTPHeaders {
        if let contentType = contentType {
            return [
                "Authorization": "Token \(token)",
                "Content-Type": contentType.rawValue
            ]
        } else {
            return ["Authorization": "Token \(token)"]
        }
    }
}

enum ContentType: String {
    case json = "application/json"
    case formData = "multipart/form-data"
}
