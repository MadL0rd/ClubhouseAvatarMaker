//
//  SubscriptionView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

final class SubscriptionView: UIView {
    
    let closeButton = ButtonWithTouchSize()
    let yearButton = ButtonWithTouchSize()
    let weekButton = ButtonWithTouchSize()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.main()
        
        addSubview(closeButton)
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setImage(R.image.cross(), for: .normal)
        closeButton.setImage(R.image.cross(), for: .highlighted)

        addSubview(yearButton)
        yearButton.translatesAutoresizingMaskIntoConstraints = false
        yearButton.backgroundColor = R.color.black()
        yearButton.layer.cornerRadius = 12
        setupTwoLabelsButton(button: yearButton,
                             topText: NSLocalizedString("Subscribe yearly", comment: ""),
                             bottomText: NSLocalizedString("649 ₽ / year", comment: ""),
                             labelsColor: R.color.main())
        
        addSubview(weekButton)
        weekButton.translatesAutoresizingMaskIntoConstraints = false
        weekButton.backgroundColor = R.color.main()
        weekButton.layer.cornerRadius = 12
        weekButton.layer.borderWidth = 2
        weekButton.layer.borderColor = R.color.black()?.cgColor
        setupTwoLabelsButton(button: weekButton,
                             topText: NSLocalizedString("Subscribe yearly", comment: ""),
                             bottomText: NSLocalizedString("129 ₽ / week", comment: ""),
                             labelsColor: R.color.black())
        
        makeConstraints()
    }
    
    private func setupTwoLabelsButton(button: UIButton, topText: String, bottomText: String, labelsColor: UIColor?) {
        let stack = UIStackView()
        button.addSubview(stack)
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.spacing = 2
        stack.isUserInteractionEnabled = false
        
        let topLabel = UILabel()
        stack.addArrangedSubview(topLabel)
        topLabel.translatesAutoresizingMaskIntoConstraints = false
        topLabel.font = R.font.gilroyBold(size: 16)
        topLabel.textColor = labelsColor
        topLabel.text = topText
        topLabel.textAlignment = .center
        topLabel.isUserInteractionEnabled = false
        
        let bottomLabel = UILabel()
        stack.addArrangedSubview(bottomLabel)
        bottomLabel.translatesAutoresizingMaskIntoConstraints = false
        bottomLabel.font = R.font.gilroyRegular(size: 16)
        bottomLabel.textColor = labelsColor
        bottomLabel.text = bottomText
        bottomLabel.textAlignment = .center
        bottomLabel.isUserInteractionEnabled = false
        
        NSLayoutConstraint.activate([
            button.heightAnchor.constraint(equalTo: stack.heightAnchor, constant: 20),
            
            stack.centerXAnchor.constraint(equalTo: button.centerXAnchor),
            stack.centerYAnchor.constraint(equalTo: button.centerYAnchor),
            stack.widthAnchor.constraint(equalTo: button.widthAnchor, constant: -20)
        ])
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 25),
            closeButton.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 25),
            closeButton.widthAnchor.constraint(equalToConstant: 20),
            closeButton.heightAnchor.constraint(equalToConstant: 20),
            
            weekButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            weekButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            weekButton.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -30),
            
            yearButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            yearButton.widthAnchor.constraint(equalTo: widthAnchor, constant: -50),
            yearButton.bottomAnchor.constraint(equalTo: weekButton.topAnchor, constant: -16)
        ])
    }
}
