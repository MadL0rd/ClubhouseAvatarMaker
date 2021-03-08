//
//  BordersRequestBuilder.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Alamofire

enum BordersRequestBuilder {
    case borders(pageNumber: Int)
}

extension BordersRequestBuilder: DataRequestExecutable {
    
    var execute: DataRequest {
        switch self {
        case .borders(pageNumber: let pageNumber):
            let parameters: [String: Any] = ["page": pageNumber]
            return AF.request(ApiUappRoutes.borders, parameters: parameters)
        }
    }
}
