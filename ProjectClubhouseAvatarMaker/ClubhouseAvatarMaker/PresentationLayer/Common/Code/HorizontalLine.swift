//
//  HorizontalLine.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 05.03.2021.
//

import UIKit

public class HorizontalLine: UIView {
    
    public var lineThickness: CGFloat {
        get {
            return lineHeightAnchor.constant
        }
        set {
            lineHeightAnchor.constant = newValue
        }
    }
    
    private var lineHeightAnchor: NSLayoutConstraint!

    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setup()
    }
    
    private func setup() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .black
        lineHeightAnchor = heightAnchor.constraint(equalToConstant: 1)
        lineHeightAnchor?.isActive = true
    }
}
