//
//  RemoteBordersService.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import Alamofire

protocol RemoteBordersServiceProtocol: class {
    
    func getBorders(pageNumber: Int, completion: @escaping GetBordersCompletion)
}

class RemoteBordersService: RemoteBordersServiceProtocol {
    
    static let shared: RemoteBordersServiceProtocol = RemoteBordersService()
    
    private let requestBuilder = BordersRequestBuilder.self
    
    internal func makeDefaultRequest<T: Codable>(dataRequest: DataRequestExecutable, completion: @escaping DefaultRequestCompletion<T>) {
        dataRequest.execute
            .response { response in
                switch response.result {
                case .success:
                    guard let data = response.data,
                          let parcedData: T = DataParser.parse(data: data)
                    else { completion(.failure(.cannotParceData)); return }
                    completion(.success(parcedData))
                    
                case .failure:
                    if let code = response.error?.responseCode,
                       let error = NetworkServiceError(rawValue: code) {
                        completion(.failure(error))
                    }
                    else {
                        completion(.failure(.unknown))
                        return
                    }
                }
            }
    }
    
    func getBorders(pageNumber: Int, completion: @escaping GetBordersCompletion) {
        let request = requestBuilder.borders(pageNumber: pageNumber)
        makeDefaultRequest(dataRequest: request, completion: completion)
    }
}
