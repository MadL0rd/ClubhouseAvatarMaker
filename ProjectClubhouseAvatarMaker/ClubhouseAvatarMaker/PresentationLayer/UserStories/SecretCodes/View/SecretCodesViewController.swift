//
//  SecretCodesViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import UIKit

final class SecretCodesViewController: UIViewController {

    var viewModel: SecretCodesViewModelProtocol!
    var coordinator: SecretCodesCoordinatorProtocol!
    
    private var _view: SecretCodesView {
        return view as! SecretCodesView
    }

    override func loadView() {
        self.view = SecretCodesView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        modalPresentationStyle = .formSheet
        _view.closeButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
    }
    
    // MARK: - UI elements actions
    
    @objc private func backButtonTapped() {
        coordinator.dismiss()
    }
}
