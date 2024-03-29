//
//  SubscriptionViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit
import JGProgressHUD

final class SubscriptionViewController: UIViewController {

    var viewModel: SubscriptionViewModelProtocol!
    var coordinator: SubscriptionCoordinatorProtocol!
    
    private let vibroGeneratorLight = UIImpactFeedbackGenerator(style: .light)
    weak var timer: Timer?
    
    private var _view: SubscriptionView {
        return view as! SubscriptionView
    }

    override func loadView() {
        self.view = SubscriptionView()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    deinit {
        timer?.invalidate()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        modalPresentationStyle = .formSheet
        
        _view.closeButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        _view.yearButton.addTarget(self, action: #selector(subscriptionButtonDidTapped(sender:)), for: .touchUpInside)
        _view.weekButton.addTarget(self, action: #selector(subscriptionButtonDidTapped(sender:)), for: .touchUpInside)
        
        _view.restoreButton.addTarget(self, action: #selector(linkButtonDidTapped(sender:)), for: .touchUpInside)
        _view.termsButton.addTarget(self, action: #selector(linkButtonDidTapped(sender:)), for: .touchUpInside)
        _view.privacyButton.addTarget(self, action: #selector(linkButtonDidTapped(sender:)), for: .touchUpInside)
        
        viewModel.loadYearlySubscriptionPricelabel { [ weak self ] text in
            guard let self = self
            else { return }
            self._view.showPurchaseButtonWithText(button: self._view.yearButton, text: text)
            self.startAttentionAnimation()
        }
        
        viewModel.loadWeeklySubscriptionPricelabel { [ weak self ] text in
            guard let self = self
            else { return }
            self._view.showPurchaseButtonWithText(button: self._view.weekButton, text: text)
        }
    }
    
    // MARK: - UI elements actions
    
    @objc private func backButtonTapped(sender: UIButton) {
        vibroGeneratorLight.impactOccurred()
        coordinator.dismiss()
    }
    
    @objc private func subscriptionButtonDidTapped(sender: UIButton) {
        var subscriptionType = SubscriptionsId.yearly
        if sender == _view.weekButton {
            subscriptionType = .weekly
        }
        
        vibroGeneratorLight.impactOccurred()
        sender.tapAnimation()
        
        let loadingHUD = AlertManager.getLoadingHUD(on: _view)
        loadingHUD.show(in: _view)
        
        viewModel.purchaseSubscription(subscriptionType) { [ weak self ] success in
            guard let self = self
            else { return }
            loadingHUD.dismiss()
            if success {
                AlertManager.showSuccessHUD(on: self.view)
                self.viewModel.output?.subscriptionStatusDidChanged()
                self.coordinator.dismiss()
            } else {
                AlertManager.showErrorHUD(on: self.view)
            }
        }
    }
    
    private func startAttentionAnimation() {
        _view.yearButton.flash()
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.7) { [ weak self ] in
            guard let self = self
            else { return }
            self.attentionScaleAnimation()
            self.timer = Timer.scheduledTimer(timeInterval: 5,
                                              target: self,
                                              selector: #selector(self.attentionScaleAnimation),
                                              userInfo: nil,
                                              repeats: true)
        }
    }
    
    @objc func attentionScaleAnimation() {
        _view.yearButton.attentionScaleAnimation()
    }
    
    @objc private func linkButtonDidTapped(sender: UIButton) {
        sender.tapAnimation()
        vibroGeneratorLight.impactOccurred()
        
        switch sender {
        case _view.termsButton:
            coordinator.openUrl(viewModel.termsOfUsageUrl)
        
        case _view.privacyButton:
            coordinator.openUrl(viewModel.privacyPolicyUrl)
            
        case _view.restoreButton:
            let loadingHUD = AlertManager.getLoadingHUD(on: _view)
            loadingHUD.show(in: _view)
            viewModel.restorePurchases { [ weak self ] result in
                guard let self = self
                else { return }
                loadingHUD.dismiss()
                switch result {
                case .failed:
                    AlertManager.showErrorHUD(on: self.view, withText: result.localized)
                    
                case .success:
                    AlertManager.showSuccessHUD(on: self.view, withText: result.localized)
                    self.viewModel.output?.subscriptionStatusDidChanged()
                    DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
                        self.coordinator.dismiss()
                    }
                    
                case .nothingToRestore:
                    AlertManager.showErrorHUD(on: self.view, withText: result.localized)
                    
                }
            }
            
        default:
            return
        }
    }
}
