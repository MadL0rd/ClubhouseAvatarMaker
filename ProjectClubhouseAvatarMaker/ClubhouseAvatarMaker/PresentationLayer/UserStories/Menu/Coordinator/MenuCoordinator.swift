//
//  MenuCoordinator.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 05.03.2021.
//

import UIKit

final class MenuCoordinator: DefaultCoordinator {
    
    static func createModule(_ configuration: ((CustomizableMenuViewModel) -> Void)? = nil) -> UIViewController {
        let view = MenuViewController()
        let viewModel = MenuViewModel()
        let coordinator = MenuCoordinator()

        view.viewModel = viewModel
        view.coordinator = coordinator

        coordinator.transition = view
        
        viewModel.purchaseManager = PurchaseManager.shared

        if let configuration = configuration {
            configuration(viewModel)
        }

        return view
    }
}

// MARK: - Interface for view
extension MenuCoordinator: MenuCoordinatorProtocol {

}
