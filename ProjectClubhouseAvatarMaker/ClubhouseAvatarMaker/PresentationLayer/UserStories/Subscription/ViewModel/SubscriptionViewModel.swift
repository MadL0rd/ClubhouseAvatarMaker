//
//  SubscriptionViewModel.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

final class SubscriptionViewModel {
	var output: SubscriptionOutput?
}

// MARK: - Configuration
extension SubscriptionViewModel: CustomizableSubscriptionViewModel {

}

// MARK: - Interface for view
extension SubscriptionViewModel: SubscriptionViewModelProtocol {

}

