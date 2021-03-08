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
}

// MARK: - Configuration

extension LoadingViewModel: CustomizableLoadingViewModel {

}

// MARK: - Interface for view

extension LoadingViewModel: LoadingViewModelProtocol {
    
    func startConfiguration() {
        remoteBordersService.getTokenIfNeeded(completion: { _ in })
        remoteBordersService.getSettings { [ weak self ] result in
            guard let self = self
            else { return }
            
            switch result {
            case .success(let data):
                print(data.settings.version)
                
            case .failure(let error):
                print(error)
            }
        }
    }
}

