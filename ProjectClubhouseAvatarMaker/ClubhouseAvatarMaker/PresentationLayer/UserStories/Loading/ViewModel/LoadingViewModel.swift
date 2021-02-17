//
//  LoadingViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import Foundation

final class LoadingViewModel {
	var output: LoadingOutput?
}

// MARK: - Configuration

extension LoadingViewModel: CustomizableLoadingViewModel {

}

// MARK: - Interface for view

extension LoadingViewModel: LoadingViewModelProtocol {
    
    func startConfiguration() {
        
    }
}

