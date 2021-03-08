//
//  CollectionHeaderView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 08.03.2021.
//

import UIKit

class CollectionHeaderView: UICollectionReusableView {
    
    static let identifier: String = "CollectionHeaderView"
    
    let label = UILabel()
    
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
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.sfuiTextBold(size: 17)
        label.textColor = R.color.tintColorDark()
        label.numberOfLines = 2
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: centerYAnchor, constant: 5),
            label.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            label.rightAnchor.constraint(equalTo: rightAnchor, constant: -20)
        ])
    }
}
