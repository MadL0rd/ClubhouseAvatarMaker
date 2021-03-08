//
//  SecretCodesViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

final class SecretCodesViewModel {
	var output: SecretCodesOutput?
}

// MARK: - Configuration
extension SecretCodesViewModel: CustomizableSecretCodesViewModel {

}

// MARK: - Interface for view
extension SecretCodesViewModel: SecretCodesViewModelProtocol {

}

