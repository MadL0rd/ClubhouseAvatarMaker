//
//  MenuView.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 05.03.2021.
//

import UIKit

final class MenuView: UIView {

    let tableView = UITableView()
    let footer = UIView(frame: CGRect(x: 0, y: 0, width: 200, height: 100))
    let footerLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        setupView()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        setupView()
    }

    // MARK: - Private methods
    
    private func setupView() {
        backgroundColor = R.color.main()
        
        addSubview(tableView)
        tableView.separatorColor = R.color.main()
        tableView.backgroundColor = R.color.main()
        tableView.sectionIndexColor = R.color.main()?.withAlphaComponent(0.2)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableFooterView = footer
        tableView.contentInset = UIEdgeInsets(top: 30, left: 0, bottom: 0, right: 0)
        tableView.showsVerticalScrollIndicator = false
        
        setupFooter()
        
        makeConstraints()
    }
    
    private func setupFooter() {
        footer.addSubview(footerLabel)
        footerLabel.translatesAutoresizingMaskIntoConstraints = false
        footerLabel.font = R.font.sfuiTextLight(size: 14)
        footerLabel.textAlignment = .center
        footerLabel.numberOfLines = 0
        footerLabel.textColor = R.color.tintColorDark()
        footerLabel.alpha = 0.7
        footerLabel.text = NSLocalizedString("This app is not affiliated with Alpha Exploration Co. or Clubhouse official app", comment: "")
    }

    private func makeConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: -20),
            tableView.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 20),
            
            footerLabel.topAnchor.constraint(equalTo: footer.topAnchor, constant: 20),
            footerLabel.centerXAnchor.constraint(equalTo: footer.centerXAnchor),
            footerLabel.widthAnchor.constraint(equalTo: tableView.widthAnchor, multiplier: 0.9)
        ])
    }
}
