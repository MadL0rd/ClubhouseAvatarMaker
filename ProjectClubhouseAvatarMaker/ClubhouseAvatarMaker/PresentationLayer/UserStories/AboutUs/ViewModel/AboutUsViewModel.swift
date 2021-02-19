//
//  AboutUsViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

final class AboutUsViewModel {
	var output: AboutUsOutput?
}

// MARK: - Configuration
extension AboutUsViewModel: CustomizableAboutUsViewModel {

}

// MARK: - Interface for view
extension AboutUsViewModel: AboutUsViewModelProtocol {

}

