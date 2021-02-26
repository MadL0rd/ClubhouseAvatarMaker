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
    let yearButton = ButtonWithTouchSize()
    let yearPriceLabel = UILabel()
    let weekButton = ButtonWithTouchSize()
    let weekPriceLabel = UILabel()
    
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
    
    func showPurchaseButtonWithText(button: UIButton, text: String) {
        var label: UILabel!
        switch button {
        case yearButton:
            label = yearPriceLabel
        case weekButton:
            label = weekPriceLabel
        default:
            return
        }
        
        label.text = text
        
        UIView.animate(withDuration: 0.3, delay: 1) { [ weak self ] in
            label.alpha = 1
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

        setupSubscriptionButtons()
        setupLinkButtonsStack()
        
        makeConstraints()
    }
    
    private func setupSubscriptionButtons() {
        addSubview(yearButton)
        yearButton.translatesAutoresizingMaskIntoConstraints = false
        yearButton.backgroundColor = R.color.black()
        yearButton.layer.cornerRadius = 12
        setupTwoLabelsButton(button: yearButton,
                             topText: NSLocalizedString("Subscribe yearly", comment: ""),
                             bottomLabel: yearPriceLabel,
                             labelsColor: R.color.main())
        
        addSubview(weekButton)
        weekButton.translatesAutoresizingMaskIntoConstraints = false
        weekButton.backgroundColor = R.color.main()
        weekButton.layer.cornerRadius = 12
        weekButton.layer.borderWidth = 2
        weekButton.layer.borderColor = R.color.black()?.cgColor
        setupTwoLabelsButton(button: weekButton,
                             topText: NSLocalizedString("Subscribe weekly", comment: ""),
                             bottomLabel: weekPriceLabel,
                             labelsColor: R.color.black())
        
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
                        text: NSLocalizedString("Privacy Policy", comment: ""))
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
    }
    
    private func setupTwoLabelsButton(button: UIButton, topText: String, bottomLabel: UILabel, labelsColor: UIColor?) {
        let stack = UIStackView()
        button.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 5
        stack.isUserInteractionEnabled = false
        
        let topLabel = UILabel()
        stack.addArrangedSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = R.font.sfuiTextBold(size: 18)
        topLabel.textColor = labelsColor
        topLabel.text = topText
        topLabel.textAlignment = .center
        topLabel.isUserInteractionEnabled = false
        
        stack.addArrangedSubview(bottomLabel)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.font = R.font.sfuiTextLight(size: 16)
        bottomLabel.textColor = labelsColor
        bottomLabel.textAlignment = .center
        bottomLabel.isUserInteractionEnabled = false
        bottomLabel.alpha = 0
        bottomLabel.numberOfLines = 2
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalTo: stack.heightAnchor, constant: 30),
            
            stack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: button.widthAnchor, constant: -20)
        ])
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            logo.centerYAnchor.constraint(equalTo: centerYAnchor),
            logo.centerXAnchor.constraint(equalTo: centerXAnchor),
            logo.widthAnchor.constraint(equalTo: widthAnchor),
            logo.heightAnchor.constraint(equalTo: heightAnchor),
            
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
