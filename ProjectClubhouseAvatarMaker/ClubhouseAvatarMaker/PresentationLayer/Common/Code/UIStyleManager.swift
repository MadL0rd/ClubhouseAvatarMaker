//
//  UIStyleManager.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import UIKit

class UIStyleManager {
    
    // MARK: - UIView
    
    static func textDefaultInput(_ view: UIView, addHeightConstraint: Bool = true) {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 16
        view.backgroundColor = R.color.lightGray()

        guard addHeightConstraint
        else { return }
        NSLayoutConstraint.activate([
            view.heightAnchor.constraint(equalToConstant: 48)
        ])
    }
    
    // MARK: - UIButton
        
    static func shadow(_ view: UIView) {
        view.layer.shadowColor = R.color.gray()?.cgColor
        view.layer.shadowRadius = 4
        view.layer.shadowOpacity = 0.35
        view.layer.shadowOffset = CGSize(width: 0, height: 4)
    }
    
    static func twoStateButtonDefault(_ button: TwoStateButton) {
        button.activeText = ""
        button.blockedText = ""
        button.activeColor = R.color.main()
        button.blockedColor = R.color.tintColorLight()
        button.duration = 0.3
        button.interactionAbilityChanging = true
        
        button.setTitleColor(R.color.tintColorDark(), for: .normal)
        button.titleLabel?.font = R.font.gilroyBold(size: 13)
        
        button.layer.cornerRadius = 9
    }
    
    static func buttonShadow(_ button: TwoStateButton) {
        button.duration = 0.5
        shadow(button)
        button.layer.shadowOpacity = 0
        button.layer.cornerRadius = 20
        
        let shadowOpacity: Float = 1

        button.activationAnimation = { (_ duration: TimeInterval) -> Void in
            if duration != 0 {
                button.animateLayer(\.shadowOpacity, to: shadowOpacity, duration: duration)
            } else {
                button.layer.shadowOpacity = shadowOpacity
            }
        }
        button.disablingAnimation = { (_ duration: TimeInterval) -> Void in
            if duration != 0 {
                button.animateLayer(\.shadowOpacity, to: 0, duration: duration)
            } else {
                button.layer.shadowOpacity = 0
            }
        }
    }
    
    // MARK: - UINavigationController
    
    static func navigationControllerTransparent(_ controller: UINavigationController) {
        controller.view.backgroundColor = .clear
        controller.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        controller.navigationBar.shadowImage = UIImage()
        controller.navigationBar.isTranslucent = true
    }
    
    // MARK: - UITextField
    
    static func textFieldDefault(textField: UITextField, placeholderText: String) {
        textDefaultInput(textField)
        textField.font = R.font.gilroyBold(size: 14)
        textField.setLeftPaddingPoints(24)
        textField.setRightPaddingPoints(24)

        let attributes = [
            NSAttributedString.Key.foregroundColor: R.color.gray()!,
            NSAttributedString.Key.font: R.font.gilroyRegular(size: 14)!
        ]
        textField.attributedPlaceholder = NSAttributedString(string: placeholderText,
                                                             attributes: attributes)
    }
}
