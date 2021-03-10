//
//  RemoteBordersService.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import Alamofire

class RemoteBordersService: NetworkService {
    
    static let shared: RemoteBordersServiceProtocol = RemoteBordersService()
    
    private let requestBuilder = BordersRequestBuilder.self
    
    internal var token: String? {
        didSet {
            saveTokenInStorrage()
        }
    }
    
    override init() {
        let storrage = SecureStorage.shared
        token = storrage.getStringValue(for: .userToken)
    }
    
    private func saveTokenInStorrage() {
        guard let token = token
        else { return }
        
        let storrage = SecureStorage.shared
        try? storrage.set(token, for: .userToken)
    }
    
    private func getToken(completion: @escaping GetTokenCompletion) {
        makeDefaultRequest(dataRequest: requestBuilder.getToken,
                           completion: completion)
    }
}

extension RemoteBordersService: RemoteBordersServiceProtocol {
    
    func getSettings(completion: @escaping GetSettingsCompletion) {
        makeDefaultRequest(dataRequest: requestBuilder.settings,
                           completion: completion)
    }
    
    func getTokenIfNeeded(completion: @escaping GetTokenIfNeededCompletion) {
        getTokenIfNeeded(force: false, completion: completion)
    }
    
    private func getTokenIfNeeded(force: Bool, completion: @escaping GetTokenIfNeededCompletion) {
        if token == nil || force == true {
            getToken { [ weak self ] result in
                guard let self = self
                else { return }
                switch result {
                case .success(let result):
                    self.token = result.token
                    completion(.success(()))
                    
                case .failure(let error):
                    completion(.failure(error))
                    
                }
            }
        } else {
            getAccountCodes { [ weak self ] result in
                switch result {
                case .success:
                    completion(.success(()))
                    
                case .failure:
                    guard force == false
                    else {
                        completion(.failure(.unknown))
                        return
                    }
                    self?.getTokenIfNeeded(force: true, completion: completion)
                    
                }
            }
        }
    }

    func getAccountCodes(completion: @escaping GetAccountCodesCompletion) {
        guard let token = token
        else {
            completion(.failure(.badToken))
            return
        }
        
        makeDefaultRequest(dataRequest: requestBuilder.getUsedCodes(token: token),
                           completion: completion)
    }
    
    func applySecretCode(_ code: String, completion: @escaping ApplySecretCodeCompletion) {
        guard let token = token
        else {
            completion(.failure(.badToken))
            return
        }
        
        makeDefaultRequest(dataRequest: requestBuilder.useCode(token: token, code: code),
                           completion: completion)
    }
    
    func getBorders(pageNumber: Int, completion: @escaping GetBordersCompletion) {
        makeDefaultRequest(dataRequest: requestBuilder.borders(pageNumber: pageNumber),
                           completion: completion)
    }
    
    func getBrandedBorders(completion: @escaping GetBrandedBordersCompletion) {
        guard let token = token
        else {
            completion(.failure(.badToken))
            return
        }
        
        makeDefaultRequest(dataRequest: requestBuilder.bordersBranded(token: token),
                           completion: completion)
    }
}
