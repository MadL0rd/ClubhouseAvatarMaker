//
//  RemoteBordersService.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import Alamofire

class RemoteBordersService: NetworkService, RemoteBordersServiceProtocol {
    
    static let shared: RemoteBordersServiceProtocol = RemoteBordersService()
    
    private let requestBuilder = BordersRequestBuilder.self
    
    func getBorders(pageNumber: Int, completion: @escaping GetBordersCompletion) {
        let request = requestBuilder.borders(pageNumber: pageNumber)
        makeDefaultRequest(dataRequest: request, completion: completion)
    }
}
