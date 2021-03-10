//
//  PhotoCollectionViewCell.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell {
    
    static let identifier: String = "PhotoCollectionViewCell"
    static let defaultName = NSLocalizedString("Speaker", comment: "")
    static let avatarWidth: CGFloat = 77
    static let indicatorsWidth: CGFloat = 27
    
    let avatar = AvatarView()
    let muteView = UIImageView(image: R.image.mute())
    let newUserView = UIImageView(image: R.image.newUser())
    let colorableIconImageView = UIImageView(image: R.image.colorableIcon())
    let nameLabel = UILabel()
    var avatarWidth: CGFloat {
        return PhotoCollectionViewCell.avatarWidth
    }
    var indicatorsWidth: CGFloat {
        return PhotoCollectionViewCell.indicatorsWidth
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func manageColorableIconVisibility(visible: Bool) {
        colorableIconImageView.isHidden = !visible
        nameLabel.transform = .init(translationX: visible ? 8 : 0, y: 0)
    }
    
    func setBorder(_ border: BorderProtocol) {
        manageColorableIconVisibility(visible: border.colorable)
        if let title = border.title,
           !title.isEmpty {
            nameLabel.text = title
        } else {
            nameLabel.text = PhotoCollectionViewCell.defaultName
        }
    }

    // MARK: - Private setup methods
    
    private func setupView() {
        contentView.addSubview(avatar)
        avatar.translatesAutoresizingMaskIntoConstraints = false
        avatar.setCornerRadiusByWidth(avatarWidth)
        avatar.emojiView.setSize(avatarSideSize: avatarWidth)
        avatar.emojiView.layer.borderWidth = 0
        avatar.emojiView.isUserInteractionEnabled = false
        addIndicatorImageView(muteView)
        addIndicatorImageView(newUserView)
        addIndicatorImageView(colorableIconImageView)
        colorableIconImageView.isHidden = true
        
        addSubview(nameLabel)
        nameLabel.textColor = R.color.tintColorDark()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = R.font.sfuiTextBold(size: 13)
        nameLabel.text = PhotoCollectionViewCell.defaultName
        nameLabel.numberOfLines = 2
        
        makeConstraints()
    }
    
    private func addIndicatorImageView(_ imageView: UIImageView) {
        contentView.addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
        
        imageView.layer.shadowColor = R.color.gray()?.cgColor
        imageView.layer.shadowOpacity = 0.35
        imageView.layer.shadowOffset = CGSize(width: 0, height: 1)
        imageView.layer.shadowRadius = 1
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            avatar.topAnchor.constraint(equalTo: contentView.topAnchor),
            avatar.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            avatar.widthAnchor.constraint(equalToConstant: avatarWidth),
            avatar.heightAnchor.constraint(equalToConstant: avatarWidth),
            
            muteView.heightAnchor.constraint(equalToConstant: indicatorsWidth),
            muteView.widthAnchor.constraint(equalToConstant: indicatorsWidth),
            muteView.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 4),
            muteView.rightAnchor.constraint(equalTo: avatar.rightAnchor, constant: 4),

            newUserView.heightAnchor.constraint(equalToConstant: indicatorsWidth),
            newUserView.widthAnchor.constraint(equalToConstant: indicatorsWidth),
            newUserView.bottomAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 4),
            newUserView.leftAnchor.constraint(equalTo: avatar.leftAnchor, constant: 2),
            
            colorableIconImageView.heightAnchor.constraint(equalToConstant: 13),
            colorableIconImageView.widthAnchor.constraint(equalToConstant: 13),
            colorableIconImageView.centerYAnchor.constraint(equalTo: nameLabel.centerYAnchor, constant: -2),
            colorableIconImageView.rightAnchor.constraint(equalTo: nameLabel.leftAnchor, constant: 3),
            
            nameLabel.centerYAnchor.constraint(equalTo: avatar.bottomAnchor, constant: 18),
            nameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
            nameLabel.widthAnchor.constraint(lessThanOrEqualTo: contentView.widthAnchor, constant: -10)
        ])
    }
}
