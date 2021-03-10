//
//  BordersRequestBuilder.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Alamofire

enum BordersRequestBuilder {
    
    case settings
    case getToken
    case getUsedCodes(token: String)
    case useCode(token: String, code: String)
    case bordersBranded(token: String)
    case borders(pageNumber: Int)
}

extension BordersRequestBuilder: DataRequestExecutable {
    
    var execute: DataRequest {
        switch self {
        case .settings:
            return AF.request(ApiClRoutes.settings, method: .get)
            
        case .getToken:
            return AF.request(ApiClRoutes.getToken, method: .get)
            
        case .getUsedCodes(token: let token):
            let header = ApiClRoutes.makeAuthHeadersFromToken(token: token)
            return AF.request(ApiClRoutes.codes, method: .get, headers: header)
            
        case .useCode(token: let token, code: let code):
            let header = ApiClRoutes.makeAuthHeadersFromToken(token: token, contentType: .json)
            let parameters: [String: Any] = ["code": code]
            return AF.request(ApiClRoutes.codes,
                              method: .post,
                              parameters: parameters,
                              encoding: CustomPatchEncoding(),
                              headers: header)
            
        case .bordersBranded(token: let token):
            let header = ApiClRoutes.makeAuthHeadersFromToken(token: token)
            return AF.request(ApiClRoutes.bordersBranded, method: .get, headers: header)
            
        case .borders(pageNumber: let pageNumber):
            let parameters: [String: Any] = ["page": pageNumber]
            return AF.request(ApiClRoutes.borders, parameters: parameters)
            
        }
    }
}
