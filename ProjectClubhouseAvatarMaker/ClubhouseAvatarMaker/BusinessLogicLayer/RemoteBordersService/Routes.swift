//
//  Routes.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
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

enum RequestBuildError: Error {
    case cannotCreateUrl
}

protocol DataRequestExecutable {
    
    var execute: DataRequest { get }
}

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

struct GetBordersResult: Codable {
    let count: Int
    let next: String?
    let previous: String?
    var results: [RemoteBorder]
}

// MARK: - Default
typealias DefaultRequestCompletion<T: Codable> = (Result<T, NetworkServiceError>) -> Void

typealias GetBordersCompletion = (Result<GetBordersResult, NetworkServiceError>) -> Void

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

enum ContentType: String {
    case json = "application/json"
    case formData = "multipart/form-data"
}
