//
//  AppUpdater.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 09.03.2021.
//

import UIKit
import Alamofire

typealias AppStoreInfoRequestCompletion = (Result<AppStoreInfoRequestResult, NetworkServiceError>) -> Void
typealias AppStoreInfoCompletion = (Result<AppInfo, NetworkServiceError>) -> Void

struct AppStoreInfoRequestResult: Codable {
    let resultCount: Int
    let results: [AppInfo]
}

struct AppInfo: Codable {
    var version: String
    var trackViewUrl: String
}

protocol AppUpdaterProtocol: AnyObject {
    func checkUpdateIsAvailable(callback: @escaping AppStoreInfoCompletion)
}

class AppUpdater: NetworkService, AppUpdaterProtocol {
    
    static let shared: AppUpdaterProtocol = AppUpdater()
    
    func checkUpdateIsAvailable(callback: @escaping AppStoreInfoCompletion) {
        guard let appUrl = URL(string: "https://itunes.apple.com/lookup?bundleId=\(Bundle.main.bundleId)")
        else {
            callback(.failure(.badRoute))
            return
        }
        
        let request = AF.request(appUrl)
        let responseHandler: AppStoreInfoRequestCompletion = { result in
            switch result {
            case .success(let data):
                guard let data = data.results.first
                else {
                    callback(.failure(.cannotParceData))
                    return
                }
                
                callback(.success(data))
                
            case .failure(let error):
                callback(.failure(error))
            }
        }
        
        makeDefaultRequest(dataRequest: request, completion: responseHandler)
    }
}
