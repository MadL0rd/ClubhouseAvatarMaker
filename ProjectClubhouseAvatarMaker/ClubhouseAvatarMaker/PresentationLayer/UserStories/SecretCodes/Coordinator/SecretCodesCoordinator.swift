//
//  SecretCodesCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import UIKit

final class SecretCodesCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableSecretCodesViewModel) -> Void)? = nil) -> UIViewController {
        let view = SecretCodesViewController()
        let viewModel = SecretCodesViewModel()
        let coordinator = SecretCodesCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view
        
        viewModel.remoteBordersService = RemoteBordersService.shared
        viewModel.bordersActualityManager = BordersActualityManager.shared
        viewModel.purchaseManager = PurchaseManager.shared

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension SecretCodesCoordinator: SecretCodesCoordinatorProtocol {

}
