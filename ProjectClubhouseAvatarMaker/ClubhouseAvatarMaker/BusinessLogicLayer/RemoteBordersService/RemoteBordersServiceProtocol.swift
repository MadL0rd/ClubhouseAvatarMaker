//
//  RemoteBordersServiceProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Foundation

protocol RemoteBordersServiceProtocol: class {
    
    func getSettings(completion: @escaping GetSettingsCompletion)
    func getTokenIfNeeded(completion: @escaping GetTokenIfNeededCompletion)
    func applySecretCode(_ code: String, completion: @escaping ApplySecretCodeCompletion)
    func getAccountCodes(completion: @escaping GetAccountCodesCompletion)
    func getBorders(pageNumber: Int, completion: @escaping GetBordersCompletion)
    func getBrandedBorders(completion: @escaping GetBrandedBordersCompletion)
}

