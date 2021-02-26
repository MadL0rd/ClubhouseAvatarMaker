//
//  EmojiContainer.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit
import ISEmojiView

protocol EmojiContainerDelegate: class {
    func locationDidChanged(emojiContainer: EmojiContainer)
    func emojiDidChanged(emojiContainer: EmojiContainer, emoji: String)
}

class EmojiContainer: UIView {
    
    private let textView = UITextView()
    private var width: NSLayoutConstraint!
    private var labelCenterY: NSLayoutConstraint!
    private var labelCenterX: NSLayoutConstraint!
    var horizontalConstraint: NSLayoutConstraint?
    var verticalConstraint: NSLayoutConstraint?
    let label = UILabel()
    var emoji: String? {
        get {
            return label.text
        }
        set {
            label.text = newValue
        }
    }
    
    weak var delegate: EmojiContainerDelegate?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func makeImage() -> UIImage? {
        guard let superview = superview
        else { return nil }
        
        let sideSize: CGFloat = 2000
        let backgroundView = UIView(frame: CGRect(x: 0, y: 0, width: sideSize, height: sideSize))
        backgroundView.backgroundColor = .clear
        
        let multiplier = frame.width / superview.frame.width
        let emojiSideSize = sideSize * multiplier
        let emojiBackgroundView = UIView(frame: CGRect(x: frame.minX / superview.frame.width * sideSize,
                                                       y: frame.minY / superview.frame.height * sideSize,
                                                       width: emojiSideSize,
                                                       height: emojiSideSize))
        backgroundView.addSubview(emojiBackgroundView)
        emojiBackgroundView.layer.cornerRadius = emojiSideSize / 2
        emojiBackgroundView.backgroundColor = backgroundColor
        emojiBackgroundView.layer.borderWidth = 10
        emojiBackgroundView.layer.borderColor = R.color.gray()?.cgColor
        emojiBackgroundView.clipsToBounds = true
        
        let emoji = label.text
        let label = UILabel(frame: CGRect(x: 0, y: 0, width: emojiSideSize, height: emojiSideSize))
        label.text = emoji
        label.textAlignment = .center
        label.font = R.font.sfuiTextBold(size: emojiSideSize * 0.7)
        emojiBackgroundView.addSubview(label)
        label.center = CGPoint(x: emojiSideSize / 2, y: emojiSideSize * 0.55)

        UIGraphicsBeginImageContext(backgroundView.frame.size)
        backgroundView.layer.render(in: UIGraphicsGetCurrentContext()!)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return UIImage(cgImage: image!.cgImage!)
    }
    
    func setSize(avatarSideSize: CGFloat) {
        let side = avatarSideSize * 0.35
        layer.cornerRadius = side / 2
        width.constant = side
        labelCenterY.constant = side * 0.05
        label.font = R.font.sfuiTextBold(size: side * 0.7)
    }
    
    func applyMoveModificator(topLeftPoint: CGPoint) {
        if horizontalConstraint != nil,
           verticalConstraint != nil {
            horizontalConstraint?.constant = topLeftPoint.x - width.constant / 2
            verticalConstraint?.constant = topLeftPoint.y - width.constant / 2
        } else {
            center = topLeftPoint
        }
        UIView.animate(withDuration: 0.1) { [ weak self ] in
            self?.layoutIfNeeded()
        }
    }
    
    // MARK: - UI elements actions

    @objc private func handlePan(recognizer: UIPanGestureRecognizer) {
        guard let superview = superview
        else { return }
        let touch = recognizer.location(in: superview)
        let superviewCenter = CGPoint(x: superview.center.x - superview.frame.origin.x,
                                      y: superview.center.y - superview.frame.origin.y)
        let touchRelativePoint = CGPoint(x: touch.x - superviewCenter.x, y: touch.y - superviewCenter.y)
        let touchRadius = sqrt(touchRelativePoint.x * touchRelativePoint.x + touchRelativePoint.y * touchRelativePoint.y)
        let maxRadius = (superview.frame.width - width.constant) * 0.7
        if touchRadius >= maxRadius {
            let multiplyer = maxRadius / touchRadius
            let x = touchRelativePoint.x * multiplyer
            let y = touchRelativePoint.y * multiplyer
            applyMoveModificator(topLeftPoint: CGPoint(x: x + superviewCenter.x, y: y + superviewCenter.y))
        } else {
            let x = touchRelativePoint.x
            let y = touchRelativePoint.y
            applyMoveModificator(topLeftPoint: CGPoint(x: x + superviewCenter.x, y: y + superviewCenter.y))
        }
        delegate?.locationDidChanged(emojiContainer: self)
    }
    
    @objc private func handleTap() {
        textView.becomeFirstResponder()
    }
            
    // MARK: - Private setup methods
    
    private func setupView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = R.color.backgroundLight()
        layer.borderWidth = 2
        layer.borderColor = R.color.gray()?.cgColor
        clipsToBounds = true
        
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(textView)
        textView.alpha = 0
        
        let panRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan(recognizer:)))
        isUserInteractionEnabled = true
        addGestureRecognizer(panRecognizer)
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        addGestureRecognizer(tap)
        
        let keyboardSettings = KeyboardSettings(bottomType: .categories)
        keyboardSettings.countOfRecentsEmojis = 20
        keyboardSettings.updateRecentEmojiImmediately = true
        let emojiView = EmojiView(keyboardSettings: keyboardSettings)
        emojiView.translatesAutoresizingMaskIntoConstraints = false
        emojiView.delegate = self
        textView.inputView = emojiView
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        width = widthAnchor.constraint(equalToConstant: 50)
        labelCenterY = label.centerYAnchor.constraint(equalTo: centerYAnchor)
        labelCenterX = label.centerXAnchor.constraint(equalTo: centerXAnchor)
        NSLayoutConstraint.activate([
            width,
            heightAnchor.constraint(equalTo: widthAnchor),
            labelCenterX,
            labelCenterY
        ])
    }
}

// MARK: - EmojiViewDelegate

extension EmojiContainer: EmojiViewDelegate {
    
    func emojiViewDidSelectEmoji(_ emoji: String, emojiView: EmojiView) {
        label.text = emoji
        delegate?.emojiDidChanged(emojiContainer: self, emoji: emoji)
        textView.resignFirstResponder()
    }
    
    func emojiViewDidPressChangeKeyboardButton(_ emojiView: EmojiView) {
        textView.inputView = nil
        textView.keyboardType = .default
        textView.reloadInputViews()
    }
    
    func emojiViewDidPressDeleteBackwardButton(_ emojiView: EmojiView) {
        textView.resignFirstResponder()
    }
    
    func emojiViewDidPressDismissKeyboardButton(_ emojiView: EmojiView) {
        textView.resignFirstResponder()
    }
    
}
