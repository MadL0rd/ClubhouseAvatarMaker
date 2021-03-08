//
//  CompletionTypealiases.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 07.03.2021.
//

import Alamofire

// MARK: - Default
typealias DefaultRequestCompletion<T: Codable> = (Result<T, NetworkServiceError>) -> Void

typealias GetBordersCompletion = (Result<GetBordersResult, NetworkServiceError>) -> Void
