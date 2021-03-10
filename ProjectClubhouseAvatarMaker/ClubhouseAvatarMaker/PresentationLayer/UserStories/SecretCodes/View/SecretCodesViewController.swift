//
//  SecretCodesViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import UIKit
import JGProgressHUD

final class SecretCodesViewController: UIViewController {
    
    var viewModel: SecretCodesViewModelProtocol!
    var coordinator: SecretCodesCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    
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
        _view.useCodeButton.addTarget(self, action: #selector(applyButtonTapped(sender:)), for: .touchUpInside)
        addTapGestureToHideKeyboard()
    }
    
    // MARK: - UI elements actions
    
    @objc private func backButtonTapped() {
        coordinator.dismiss()
    }
    
    @objc private func applyButtonTapped(sender: UIButton) {
        vibroGeneratorLight.impactOccurred()

        guard let code = _view.codeTextField.text,
              !code.isEmpty
        else {
            _view.codeTextField.shake()
            return
        }
        
        _view.codeTextField.text = ""
        
        sender.tapAnimation()
        view.endEditing(true)
        
        let loadingHUD = AlertManager.getLoadingHUD(on: _view)
        loadingHUD.show(in: _view)
        
        viewModel.applySecretCode(code) { [ weak self ] result in
            loadingHUD.dismiss()
            
            guard let self = self
            else { return }
            
            switch result {
            case .success:
                AlertManager.showSuccessHUD(on: self.view, withText: code)
                
            case .failure:
                AlertManager.showErrorHUD(on: self.view, withText: code)
            }
            
        }
    }
}
