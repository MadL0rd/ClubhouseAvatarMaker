//
//  LimitatableTextView.swift
//  ClubhouseAvatarMaker
//
//  Created by Anton Tekutov on 17.02.21.
//

import UIKit

protocol SizeUpdateDelegate: class {
    
    func viewSizeWasUpdated(_ view: UIView)
}

class LimitatableTextView: UIControl {
    
    private var textViewHeightConstraint: NSLayoutConstraint!
    var textViewMaxHeight: CGFloat = UIConstants.screenBounds.height * 0.32
    var textViewMinHeight: CGFloat = 70
    
    weak var sizeUpdateDelegate: SizeUpdateDelegate?
    
    override var backgroundColor: UIColor? {
        get {
            textEditor.backgroundColor
        }
        set {
            textEditor.backgroundColor = newValue
        }
    }
    
    let textEditor = UITextView()
    let countLabel = UILabel()
    let placeholder = UILabel()
    
    var maxLength: Int?
    
    var text: String {
        get { textEditor.text }
        set {
            textEditor.text = newValue
            newValue.isEmpty ? showPlaceholder() : hidePlaceholder()
            refreshCount()
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) { [ weak self ] in
                guard let self = self
                else { return }
                self.textViewDidChange(self.textEditor)
            }
        }
    }
    
    var scrollMoveManager: ScrollMovingUpManagerForUIControl?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func refreshCount() {
        refreshCount(textEditor.text.count)
    }
    
    // MARK: - Private methods
    
    private func refreshCount(_ count: Int) {
        guard let maxLength = maxLength
        else { return }
        let count = maxLength - count
        var text = "\(NSLocalizedString("осталось", comment: "")) \(count) "
        let one = NSLocalizedString("символ", comment: "")
        let less5 = NSLocalizedString("символа", comment: "")
        let other = NSLocalizedString("символов", comment: "")
        switch count % 10 {
        case 1:
            text += count % 100 != 11 ? one : other
        case 2...4:
            text += less5
        default:
            text += other
        }
        
        countLabel.text = text
    }
    
    private func showPlaceholder() {
        placeholder.isHidden = false
        placeholder.isUserInteractionEnabled = false
        UIView.animate(withDuration: 0.5) { [ weak self ] in
            self?.placeholder.alpha = 1
        }
    }
    
    private func hidePlaceholder() {
        placeholder.isHidden = true
        placeholder.alpha = 0
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        
        backgroundColor = .clear
        
        addSubview(textEditor)
        textEditor.translatesAutoresizingMaskIntoConstraints = false
        textEditor.backgroundColor = R.color.lightGray()
        textEditor.layer.cornerRadius = 16
        textEditor.delegate = self
        textEditor.textContainerInset = UIEdgeInsets(top: 18, left: 18, bottom: 18, right: 18)
        textEditor.font = R.font.gilroyRegular(size: 14)
        
        addSubview(countLabel)
        countLabel.translatesAutoresizingMaskIntoConstraints = false
        countLabel.font = R.font.gilroyBold(size: 10)
        countLabel.textColor = R.color.gray()
        countLabel.alpha = 0.5
        
        addSubview(placeholder)
        placeholder.translatesAutoresizingMaskIntoConstraints = false
        placeholder.textColor = R.color.tintColorDark()
        placeholder.font = R.font.gilroyRegular(size: 14)
        
        placeholder.text = ""
        
        scrollMoveManager = ScrollMovingUpManagerForUIControl(control: self)
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        textViewHeightConstraint = textEditor.heightAnchor.constraint(equalToConstant: textViewMinHeight)
        NSLayoutConstraint.activate([
            textEditor.topAnchor.constraint(equalTo: topAnchor),
            textEditor.leftAnchor.constraint(equalTo: leftAnchor),
            textEditor.rightAnchor.constraint(equalTo: rightAnchor),
            textEditor.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -20),
            
            countLabel.bottomAnchor.constraint(equalTo: bottomAnchor),
            countLabel.rightAnchor.constraint(equalTo: rightAnchor),
            
            placeholder.topAnchor.constraint(equalTo: topAnchor, constant: 20),
            placeholder.leftAnchor.constraint(equalTo: leftAnchor, constant: 26),
            placeholder.bottomAnchor.constraint(lessThanOrEqualTo: bottomAnchor, constant: -20),
            placeholder.rightAnchor.constraint(equalTo: rightAnchor, constant: -26),
            textViewHeightConstraint
        ])
    }
}

// MARK: - UITextViewDelegate

extension LimitatableTextView: UITextViewDelegate {
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        newText.isEmpty ? showPlaceholder() : hidePlaceholder()
        guard let maxLength = maxLength
        else { return true }
        let result = newText.count <= maxLength
        if result {
            refreshCount(newText.count)
        }
        return result
    }
    
    func textViewDidChange(_ textView: UITextView) {
        var height = min(textView.contentSize.height, textViewMaxHeight)
        height = max(height, textViewMinHeight)
        textViewHeightConstraint.constant = height
        sizeUpdateDelegate?.viewSizeWasUpdated(self)
        textView.showsVerticalScrollIndicator = height == textViewMaxHeight
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        sendActions(for: .editingDidBegin)
    }

    func textViewDidEndEditing(_ textView: UITextView) {
        sendActions(for: .editingDidEnd)
    }
}
