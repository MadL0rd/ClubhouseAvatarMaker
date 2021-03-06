//
//  LoadingViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import Foundation

final class LoadingViewModel {
    
	var output: LoadingOutput?
    
    var remoteBordersService: RemoteBordersServiceProtocol!
    var purchaseManager: PurchaseManagerProtocol!
}

// MARK: - Configuration

extension LoadingViewModel: CustomizableLoadingViewModel {

}

// MARK: - Interface for view

extension LoadingViewModel: LoadingViewModelProtocol {
    
    func checkUpdateIsAvailable(completion: @escaping AppStoreInfoCompletion) {
        AppUpdater.shared.checkUpdateIsAvailable(callback: completion)
    }
    
    func configureRemoteBordersAccount(completion: @escaping() -> Void) {
        remoteBordersService.getTokenIfNeeded { [ weak self ] _ in
            self?.remoteBordersService.getAccountCodes { result in
                switch result {
                case .success(let data):
                    if !data.isEmpty {
                        self?.purchaseManager.forceSetSubscriptionActive()
                    }
                    
                case .failure(let error):
                    print(error)
                }
                
                completion()
            }
        }
    }

}

