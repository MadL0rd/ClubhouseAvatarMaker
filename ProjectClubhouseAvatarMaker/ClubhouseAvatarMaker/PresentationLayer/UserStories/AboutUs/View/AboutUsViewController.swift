//
//  AboutUsViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class AboutUsViewController: UIViewController {

    var viewModel: AboutUsViewModelProtocol!
    var coordinator: AboutUsCoordinatorProtocol!
    
    private var _view: AboutUsView {
        return view as! AboutUsView
    }

    override func loadView() {
        self.view = AboutUsView()
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
