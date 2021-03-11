//
//  SecretCodesViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

final class SecretCodesViewModel {
    
	var output: SecretCodesOutput?
    
    var remoteBordersService: RemoteBordersServiceProtocol!
    var bordersActualityManager: BordersActualityManagerProtocol!
    var purchaseManager: PurchaseManagerProtocol!

    var codes = [SecretCode]()
}

// MARK: - Configuration
extension SecretCodesViewModel: CustomizableSecretCodesViewModel {

}

// MARK: - Interface for view
extension SecretCodesViewModel: SecretCodesViewModelProtocol {

    func applySecretCode(_ code: String, completion: @escaping(Result<Void, NetworkServiceError>) -> Void) {
        remoteBordersService.applySecretCode(code) { [ weak self ] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                if data.errors == nil {
                    self.bordersActualityManager.needToReloadBorders()
                    self.purchaseManager.forceSetSubscriptionActive()
                    completion(.success(()))
                } else {
                    completion(.failure(.unknown))
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
    
    func loadCodes(completion: @escaping() -> Void) {
        remoteBordersService.getAccountCodes { [ weak self ] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                self.codes = data
                
            case .failure(let error):
                print(error)
            }
            
            completion()
        }
    }
}

