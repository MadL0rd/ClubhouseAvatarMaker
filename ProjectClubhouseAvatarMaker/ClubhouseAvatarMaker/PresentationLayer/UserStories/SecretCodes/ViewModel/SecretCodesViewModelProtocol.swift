//
//  SecretCodesViewModelProtocol.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

protocol SecretCodesViewModelProtocol: AnyObject {
    
    var codes: [SecretCode] { get set }
    
    func applySecretCode(_ code: String, completion: @escaping(Result<Void, NetworkServiceError>) -> Void)
    func loadCodes(completion: @escaping() -> Void)
}
