//
//  SubscriptionView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class SubscriptionView: UIView {
    
    let logo = UIImageView()
    let closeButton = ButtonWithTouchSize()
    let topSubscriptionLabel = UILabel()
    let bottomSubscriptionLabel = UILabel()
    
    let yearButton = TwoLabelsButton()
    let weekButton = TwoLabelsButton()
    
    let linkButtonsStack = UIStackView()
    let termsButton = ButtonWithTouchSize()
    let restoreButton = ButtonWithTouchSize()
    let privacyButton = ButtonWithTouchSize()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }
    
    // MARK: - Public methods
    
    func showPurchaseButtonWithText(button: TwoLabelsButton, text: String) {
        button.bottomLabel.text = text
        
        UIView.animate(withDuration: 0.3, delay: 1) { [ weak self ] in
            button.bottomLabel.alpha = 1
            self?.layoutIfNeeded()
        }
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.main()
        
        addSubview(logo)
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.contentMode = .scaleAspectFill
        logo.image = R.image.subscriptionImage()
        
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(R.image.cross(), for: .normal)
        closeButton.setImage(R.image.cross(), for: .highlighted)
        
        addSubview(topSubscriptionLabel)
        topSubscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        topSubscriptionLabel.font = R.font.sfuiTextBold(size: 24)
        topSubscriptionLabel.textAlignment = .center
        topSubscriptionLabel.text = NSLocalizedString("Buy a subscribtion", comment: "")
        topSubscriptionLabel.textColor = R.color.tintColorMain()
        topSubscriptionLabel.numberOfLines = 0
        
        addSubview(bottomSubscriptionLabel)
        bottomSubscriptionLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomSubscriptionLabel.font = R.font.sfuiTextLight(size: 24)
        bottomSubscriptionLabel.textAlignment = .center
        bottomSubscriptionLabel.text = NSLocalizedString("to customize your own photos", comment: "")
        bottomSubscriptionLabel.textColor = R.color.tintColorMain()
        bottomSubscriptionLabel.numberOfLines = 0
        
        setupSubscriptionButtons()
        setupLinkButtonsStack()
        
        makeConstraints()
    }
    
    private func setupSubscriptionButtons() {
        addSubview(yearButton)
        UIStyleManager.twoLabelsButtonDark(yearButton)
        yearButton.bottomLabel.alpha = 0
        yearButton.topLabel.text = NSLocalizedString("Subscribe yearly", comment: "")
        
        addSubview(weekButton)
        UIStyleManager.twoLabelsButtonLight(weekButton)
        weekButton.bottomLabel.alpha = 0
        weekButton.topLabel.text = NSLocalizedString("Subscribe weekly", comment: "")
    }
    
    private func setupLinkButtonsStack() {
        addSubview(linkButtonsStack)
        linkButtonsStack.translatesAutoresizingMaskIntoConstraints = false
        linkButtonsStack.axis = .horizontal
        linkButtonsStack.spacing = 8
        linkButtonsStack.distribution = .fillProportionally
        
        setupLinkButton(button: termsButton,
                        text: NSLocalizedString("Terms of usage", comment: ""))
        setupLinkButton(button: restoreButton,
                        text: NSLocalizedString("Restore", comment: ""))
        setupLinkButton(button: privacyButton,
                        text: NSLocalizedString("Privacy policy", comment: ""))
    }
    
    private func setupLinkButton(button: ButtonWithTouchSize, text: String) {
        linkButtonsStack.addArrangedSubview(button)
        button.setDefaultAreaPadding()
        
        let attributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.font: R.font.sfuiTextLight(size: 12)!,
            NSAttributedString.Key.foregroundColor: R.color.tintColorDark()!,
            NSAttributedString.Key.underlineStyle: 1
        ]
        let attributeString = NSMutableAttributedString(string: text,
                                                        attributes: attributes)
        button.setAttributedTitle(attributeString, for: .normal)
        button.titleLabel?.numberOfLines = 0
        button.titleLabel?.textAlignment = .center
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalTo: widthAnchor),
            logo.heightAnchor.constraint(equalTo: heightAnchor),
            
            topSubscriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            topSubscriptionLabel.centerYAnchor.constraint(equalTo: centerYAnchor, constant: -40),
            topSubscriptionLabel.widthAnchor.constraint(equalTo: widthAnchor, multiplier: 0.8),
            
            bottomSubscriptionLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            bottomSubscriptionLabel.topAnchor.constraint(equalTo: topSubscriptionLabel.bottomAnchor, constant: 2),
            bottomSubscriptionLabel.widthAnchor.constraint(equalTo: topSubscriptionLabel.widthAnchor),

            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            closeButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            
            linkButtonsStack.centerXAnchor.constraint(equalTo: centerXAnchor),
            linkButtonsStack.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            linkButtonsStack.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -20),
            
            weekButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            weekButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            weekButton.bottomAnchor.constraint(equalTo: linkButtonsStack.topAnchor, constant: -20),
            
            yearButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            yearButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            yearButton.bottomAnchor.constraint(equalTo: weekButton.topAnchor, constant: -16)
        ])
    }
}
