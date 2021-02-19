//
//  ColorCollectionViewCell.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

class ColorCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "ColorCollectionViewCell"
    static let colorCellSideSize: CGFloat = 30
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }

    // MARK: - Private setup methods
    
    private func setupView() {
        layer.cornerRadius = ColorCollectionViewCell.colorCellSideSize / 2
    }
}
