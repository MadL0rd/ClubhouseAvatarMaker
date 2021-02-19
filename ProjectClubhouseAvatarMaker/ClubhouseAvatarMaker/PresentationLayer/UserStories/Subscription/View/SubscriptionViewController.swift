//
//  SubscriptionViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class SubscriptionViewController: UIViewController {

    var viewModel: SubscriptionViewModelProtocol!
    var coordinator: SubscriptionCoordinatorProtocol!
    
    private var _view: SubscriptionView {
        return view as! SubscriptionView
    }

    override func loadView() {
        self.view = SubscriptionView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        navigationController?.navigationBar.tintColor = R.color.tintColorDark()
        let dismissButton = UIBarButtonItem(image: R.image.arrowLeft(),
                                            style: .done,
                                            target: self,
                                            action: #selector(backButtonTapped))
        navigationItem.leftBarButtonItem = dismissButton
    }
    
    // MARK: - UI elements actions
    
    @objc private func backButtonTapped() {
        coordinator.dismiss()
    }
}
