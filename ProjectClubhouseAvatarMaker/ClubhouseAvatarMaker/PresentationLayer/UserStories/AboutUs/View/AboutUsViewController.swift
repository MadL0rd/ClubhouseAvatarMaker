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
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.barStyle = .default
        navigationController?.navigationBar.tintColor = R.color.tintColorDark()
        navigationController?.navigationBar.topItem?.backButtonTitle = ""
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        
    }
}
