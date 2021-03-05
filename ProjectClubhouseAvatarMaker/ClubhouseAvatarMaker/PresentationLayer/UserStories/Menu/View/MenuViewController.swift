//
//  MenuViewController.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 05.03.2021.
//

import UIKit
import JGProgressHUD

struct MenuRow {
    let image: UIImage?
    let title: String
    let action: () -> Void
}
struct MenuModule {
    let title: String
    var rows = [MenuRow]()
}

final class MenuViewController: UIViewController {

    var viewModel: MenuViewModelProtocol!
    var coordinator: MenuCoordinatorProtocol!
    
    let cellIdentifire = "SettingsTableViewCell"
    let cellCornerRadious: CGFloat = 20

    var menu = [MenuModule]()
    
    private var _view: MenuView {
        return view as! MenuView
    }

    override func loadView() {
        self.view = MenuView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        configureSelf()
    }

    private func configureSelf() {
        generateBaseMenuModule()
        generateAboutUsMenuModule()
        generateInfoMenuModule()
        
        _view.tableView.dataSource = self
        _view.tableView.delegate = self
        _view.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellIdentifire)
        
        navigationController?.navigationBar.tintColor = R.color.tintColorDark()
        navigationItem.title = NSLocalizedString("Settings", comment: "")
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: R.image.arrowLeft(),
                                                           style: .done,
                                                           target: self,
                                                           action: #selector(backButtonTapped))
    }
    
    private func generateBaseMenuModule() {
        var module = MenuModule(title: "")
        module.rows.append(MenuRow(image: R.image.settingsPremium(),
                                   title: NSLocalizedString("Buy subscribtion", comment: ""),
                                   action: { [ weak self ] in self?.subscribtionCheck() }))
        module.rows.append(MenuRow(image: R.image.settingsSupport(),
                                   title: NSLocalizedString("Support", comment: ""),
                                   action: {[ weak self ] in
                                    guard let url = self?.viewModel.supportUrl
                                    else { return }
                                    UIApplication.shared.open(url)
                                   }))
        module.rows.append(MenuRow(image: R.image.settingsRate(),
                                   title: NSLocalizedString("Rate the app", comment: ""),
                                   action: { [ weak self ] in self?.viewModel.rateApp() }))
        module.rows.append(MenuRow(image: R.image.settingsRestore(),
                                   title: NSLocalizedString("Restore purchase", comment: ""),
                                   action: { [ weak self ] in self?.restore() }))
        menu.append(module)
    }
    
    private func generateAboutUsMenuModule() {
        var module = MenuModule(title: NSLocalizedString("Information about us", comment: ""))
        module.rows.append(MenuRow(image: R.image.aboutButton(),
                                   title: NSLocalizedString("About us", comment: ""),
                                   action: { [ weak self ] in self?.coordinator.openAboutUsScreen() }))
        menu.append(module)
    }
    
    private func generateInfoMenuModule() {
        var module = MenuModule(title: NSLocalizedString("Legal information", comment: ""))
        module.rows.append(MenuRow(image: R.image.settingsLegal(),
                                   title: NSLocalizedString("Terms of use", comment: ""),
                                   action: { [ weak self ] in
                                    guard let url = self?.viewModel.termsOfUsageUrl
                                    else { return }
                                    UIApplication.shared.open(url)
                                   }))
        module.rows.append(MenuRow(image: R.image.settingsLegal(),
                                   title: NSLocalizedString("Privacy policy", comment: ""),
                                   action: {[ weak self ] in
                                    guard let url = self?.viewModel.privacyPolicyUrl
                                    else { return }
                                    UIApplication.shared.open(url)
                                   }))
        menu.append(module)
    }
    
    // MARK: - UI elements actions
    
    @objc private func backButtonTapped() {
        coordinator.dismiss()
    }
    
    private func subscribtionCheck() {
        let loadingHUD = AlertManager.getLoadingHUD(on: _view)
        loadingHUD.show(in: _view)
        viewModel.checkSubscriptionsStatus { [ weak self ] isActive in
            guard let self = self
            else { return }
            loadingHUD.dismiss()
            switch isActive {
            case .active:
                AlertManager.showSuccessHUD(on: self.view,
                                            withText: NSLocalizedString("You already have active subscription!", comment: ""))
            case .notPurchased:
                self.coordinator.openSubscribtion()
            }
        }
    }
    
    private func restore() {
        let loadingHUD = AlertManager.getLoadingHUD(on: _view)
        loadingHUD.show(in: _view)
        viewModel.restorePurchases { [ weak self ] result in
            guard let self = self
            else { return }
            loadingHUD.dismiss()
            switch result {
            case .failed:
                AlertManager.showErrorHUD(on: self.view, withText: result.localized)
                
            case .success:
                AlertManager.showSuccessHUD(on: self.view, withText: result.localized)
                
            case .nothingToRestore:
                AlertManager.showErrorHUD(on: self.view, withText: result.localized)
                
            }
        }
    }
}

// MARK: - UITableViewDataSource

extension MenuViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return menu.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menu[section].rows.count
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return menu[section].title
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard !menu[section].title.isEmpty
        else { return nil }
        
        let view = UIView()
        view.backgroundColor = R.color.main()
        
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = R.font.sfuiTextBold(size: 17)
        label.text = menu[section].title
        label.textColor = R.color.tintColorDark()
        view.addSubview(label)
        
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: view.topAnchor, constant: 24),
            label.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 14)
        ])
        
        return view
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifire, for: indexPath)
        let menuRow = menu[indexPath.section].rows[indexPath.row]
        
        if menu[indexPath.section].rows.count - 1 == indexPath.row ||
            indexPath.row == 0 {
            if menu[indexPath.section].rows.count == 1 {
                cell.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner, .layerMinXMinYCorner, .layerMaxXMinYCorner],
                                  radius: cellCornerRadious)
                
            } else if menu[indexPath.section].rows.count - 1 == indexPath.row {
                cell.roundCorners(corners: [.layerMinXMaxYCorner, .layerMaxXMaxYCorner],
                                  radius: cellCornerRadious)
            } else if indexPath.row == 0 {
                cell.roundCorners(corners: [.layerMinXMinYCorner, .layerMaxXMinYCorner],
                                  radius: cellCornerRadious)
            }
        } else {
            cell.layer.cornerRadius = 0
        }
        
        cell.layer.masksToBounds = true
        cell.backgroundColor = R.color.backgroundLight()
        cell.imageView?.image = menuRow.image?.withRenderingMode(.alwaysTemplate)
        cell.imageView?.tintColor = R.color.tintColorDark()
        cell.textLabel?.text = menuRow.title
        cell.textLabel?.font = R.font.sfuiTextBold(size: 14)
        cell.textLabel?.textColor = R.color.tintColorDark()
        cell.accessoryType = .disclosureIndicator
        cell.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = R.color.main()?.withAlphaComponent(0.3)
        cell.selectedBackgroundView = backgroundView
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return !menu[section].title.isEmpty ? 60 : 0
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 56
    }
}

// MARK: - UITableViewDelegate

extension MenuViewController: UITableViewDelegate {

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        menu[indexPath.section].rows[indexPath.row].action()
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
