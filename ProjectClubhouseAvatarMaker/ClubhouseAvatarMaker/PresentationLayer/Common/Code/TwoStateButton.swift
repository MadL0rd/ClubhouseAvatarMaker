//
//  TwoStateButton.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

class TwoStateButton: ButtonWithTouchSize {
    
    var activeColor: UIColor!
    var blockedColor: UIColor!
    var duration: TimeInterval!
    
    var activationAnimation: ((_ duration: TimeInterval) -> Void)!
    var disablingAnimation: ((_ duration: TimeInterval) -> Void)!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupButton()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupButton()
    }
    
    var activeText: String! {
        didSet {
            if !viewState && textChanging {
               return
            }
            setTitle(activeText, for: .normal)
        }
    }
    var blockedText: String! {
        didSet {
            if !viewState && textChanging {
                setTitle(blockedText, for: .normal)
            }
        }
    }
    
    private(set) var viewState = true //active - true, blocker - false
    
    var textChanging = false
    var interactionAbilityChanging: Bool! {
        didSet {
            if !interactionAbilityChanging {
                isUserInteractionEnabled = true
            }
            if interactionAbilityChanging && viewState {
                setBlocked()
            }
        }
    }
    
    private func setupButton() {
        
        activationAnimation = defaultActivationAnimation
        disablingAnimation = defaultDisablingAnimation(duration:)
        
        translatesAutoresizingMaskIntoConstraints = false
        UIStyleManager.twoStateButtonDefault(self)
        setActive(animated: false)
    }
    
    func toggle() {
        if viewState {
            setBlocked()
        } else {
            setActive()
        }
    }
    
    func setActive(animated: Bool = true) {
        viewState = true
        if textChanging {
            setTitle(activeText, for: .normal)
        }
        isUserInteractionEnabled = true
        if animated {
            activationAnimation?(duration)
        } else {
            activationAnimation?(0)
        }
    }
    
    func setBlocked(animated: Bool = true) {
        viewState = false
        if textChanging {
            setTitle(blockedText, for: .normal)
        }
        if interactionAbilityChanging {
            isUserInteractionEnabled = false
        }
        if animated {
            disablingAnimation?(duration)
        } else {
            disablingAnimation?(0)
        }
    }
    
    private func defaultActivationAnimation(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [ weak self ] in
            guard let self = self
                else { return }
            self.backgroundColor = self.activeColor
        }
    }
    
    private func defaultDisablingAnimation(duration: TimeInterval) {
        UIView.animate(withDuration: duration) { [ weak self ] in
            guard let self = self
                else { return }
            self.backgroundColor = self.blockedColor
        }
    }
}
