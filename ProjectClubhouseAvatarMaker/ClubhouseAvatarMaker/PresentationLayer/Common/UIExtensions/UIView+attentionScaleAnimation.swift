//
//  UIView+attentionScaleAnimation.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 22.02.2021.
//

import UIKit

extension UIView {
    
    func attentionScaleAnimation(_ completionBlock: (() -> Void)? = nil) {
        
        UIView.animate(withDuration: 0.3) {[weak self] in
            self?.transform = .init(scaleX: 1.08, y: 1.08)
        }
        
        UIView.animate(withDuration: 0.3,
                       delay: 0.3) {  [ weak self ] in
            self?.isUserInteractionEnabled = true
            self?.transform = .init(scaleX: 1, y: 1)
            completionBlock?()
        }
    }
}
