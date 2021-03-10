//
//  CompletionTypealiases.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Alamofire

typealias GetSettingsCompletion = (Result<GetSettingsResult, NetworkServiceError>) -> Void
typealias GetTokenCompletion = (Result<GetTokenResult, NetworkServiceError>) -> Void
typealias GetTokenIfNeededCompletion = (Result<Void, NetworkServiceError>) -> Void
typealias GetAccountCodesCompletion = (Result<[SecretCode], NetworkServiceError>) -> Void
typealias ApplySecretCodeCompletion = (Result<ApplyCodeResult, NetworkServiceError>) -> Void
typealias GetBordersCompletion = (Result<GetBordersResult, NetworkServiceError>) -> Void
typealias GetBrandedBordersCompletion = (Result<GetBrandedBordersResult, NetworkServiceError>) -> Void

