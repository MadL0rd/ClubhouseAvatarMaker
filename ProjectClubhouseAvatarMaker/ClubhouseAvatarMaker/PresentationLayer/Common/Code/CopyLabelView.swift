//
//  CopyLabelView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 22.02.2021.
//

import UIKit

class CopyLabelView: UIView {
    
    var touchAreaPadding = UIEdgeInsets(top: 15, left: 15, bottom: 15, right: 15)
    
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        let rect = bounds.inset(by: touchAreaPadding.inverted())
        return rect.contains(point)
    }
    
    let label = UILabel()
    let copyButton = CopyButton()
    var copyText = ""
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupView()
    }
    
    // MARK: - Public methods
    
    func setText(labelText: String, copyText: String) {
        label.text = labelText
        self.copyText = copyText
    }
    
    // MARK: - UI elements actions
    
    @objc private func componentDidTaped() {
        tapAnimation()
        copyButton.copyText()
    }
    
    // MARK: - Private setup methods
    
    private func setupView() {
        addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.sfuiTextLight(size: 16)
        label.textColor = R.color.tintColorDark()
        
        addSubview(copyButton)
        copyButton.translatesAutoresizingMaskIntoConstraints = false
        copyButton.getTextClosure = { [ weak self ] in
            return self?.copyText
        }
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(componentDidTaped))
        addGestureRecognizer(tap)
        isUserInteractionEnabled = true
        
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: label.topAnchor),
            leftAnchor.constraint(equalTo: label.leftAnchor),
            rightAnchor.constraint(equalTo: copyButton.rightAnchor),
            bottomAnchor.constraint(equalTo: label.bottomAnchor),
            
            copyButton.leftAnchor.constraint(equalTo: label.rightAnchor, constant: 20),
            copyButton.centerYAnchor.constraint(equalTo: label.centerYAnchor),
            copyButton.widthAnchor.constraint(equalToConstant: 32),
            copyButton.heightAnchor.constraint(equalToConstant: 32)
        ])
    }
}
