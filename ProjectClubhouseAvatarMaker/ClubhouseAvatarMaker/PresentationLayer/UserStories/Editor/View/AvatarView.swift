//
//  AvatarView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 17.02.2021.
//

import UIKit

class AvatarView: UIView {
    
    let photo = UIImageView(image: R.image.defaultPhoto())
    let borderView = UIImageView()
    var border: Border?
    let emojiView = EmojiContainer()
    
    var borderTintColor: UIColor? {
        get {
            borderView.tintColor
        }
        set {
            borderView.tintColor = newValue
        }
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
    
    func setBorder(_ border: Border, animated: Bool = true) {
        self.border = border
        let image = border.image?.withRenderingMode(border.colorable ? .alwaysTemplate : .alwaysOriginal)
        if animated {
            UIView.transition(with: borderView,
                              duration: 0.3,
                              options: .transitionCrossDissolve) { [ weak self ] in
                self?.borderView.image = image
            }
        } else {
            borderView.image = image
        }
    }
    
    func setCornerRadiusByWidth(_ width: CGFloat) {
        layer.cornerRadius = width * 212 / 500
    }
    
    func setPhoto(_ image: UIImage?) {
        UIView.transition(with: photo,
                          duration: 0.3,
                          options: .transitionCrossDissolve) { [ weak self ] in
            self?.photo.image = image
        }
    }
    
    private func moveEmoji(newCenter: CGPoint) {
        emojiView.center = newCenter
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        layer.borderColor = R.color.lightGray()?.cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        clipsToBounds = true
        
        borderTintColor = R.color.tintColorDark()
        
        addImageView(photo)
        addImageView(borderView)
        
        addSubview(emojiView)
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.label.text = "🔥"

        makeConstraints()
    }
    
    private func addImageView(_ imageView: UIImageView) {
        addSubview(imageView)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.contentMode = .scaleAspectFit
    }
    
    private func makeConstraints() {
        emojiView.horizontalConstraint = emojiView.leftAnchor.constraint(equalTo: leftAnchor, constant: 15)
        emojiView.verticalConstraint = emojiView.topAnchor.constraint(equalTo: topAnchor, constant: 15)
        NSLayoutConstraint.activate([
            photo.centerYAnchor.constraint(equalTo: centerYAnchor),
            photo.centerXAnchor.constraint(equalTo: centerXAnchor),
            photo.widthAnchor.constraint(equalTo: widthAnchor),
            photo.heightAnchor.constraint(equalTo: heightAnchor),
            
            borderView.centerYAnchor.constraint(equalTo: centerYAnchor),
            borderView.centerXAnchor.constraint(equalTo: centerXAnchor),
            borderView.widthAnchor.constraint(equalTo: widthAnchor),
            borderView.heightAnchor.constraint(equalTo: heightAnchor),
            
            emojiView.horizontalConstraint!,
            emojiView.verticalConstraint!
        ])
    }
}
