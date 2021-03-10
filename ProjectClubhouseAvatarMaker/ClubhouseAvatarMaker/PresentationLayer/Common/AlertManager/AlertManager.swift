//
//  AlertManager.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 26.02.2021.
//

import UIKit
import JGProgressHUD

final class AlertManager {
    
    static func showSuccessHUD(on view: UIView, withText text: String? = nil, detailText: String? = nil, delegate: JGProgressHUDDelegate? = nil) {
        let successHUD = JGProgressHUD(style: .light)
        successHUD.indicatorView = JGProgressHUDSuccessIndicatorView()
        successHUD.delegate = delegate
        
        successHUD.textLabel.text = text
        successHUD.detailTextLabel.text = detailText
        
        successHUD.show(in: view)
        successHUD.dismiss(afterDelay: 2.0)
        
        successHUD.tapOutsideBlock = { (hud) in
            hud.dismiss()
        }
    }
    
    static func showErrorHUD(on view: UIView, withText text: String? = nil, detailText: String? = nil, delegate: JGProgressHUDDelegate? = nil) {
        let successHUD = JGProgressHUD(style: .light)
        successHUD.indicatorView = JGProgressHUDErrorIndicatorView()
        successHUD.delegate = delegate
        
        successHUD.textLabel.text = text
        successHUD.detailTextLabel.text = detailText
        
        successHUD.show(in: view)
        successHUD.dismiss(afterDelay: 2.0)
        
        successHUD.tapOutsideBlock = { (hud) in
            hud.dismiss()
        }
    }
    
    static func getLoadingHUD(on view: UIView, withText text: String? = nil, detailText: String? = nil, delegate: JGProgressHUDDelegate? = nil) -> JGProgressHUD {
        let loadingHUD = JGProgressHUD(style: .light)
        loadingHUD.delegate = delegate
        
        loadingHUD.textLabel.text = text
        loadingHUD.detailTextLabel.text = detailText
        loadingHUD.show(in: view)
        
        return loadingHUD
    }
    
    static func getProgressHUD(on view: UIView, withText text: String? = nil, detailText: String? = nil, delegate: JGProgressHUDDelegate? = nil) -> JGProgressHUD {
        let progressHUD = JGProgressHUD(style: .light)
        let progressView = JGProgressHUDPieIndicatorView()
        progressHUD.indicatorView = progressView
        
        progressView.color = R.color.tintColorDark()!
        progressView.fillColor = R.color.backgroundDark()!
        
        progressHUD.delegate = delegate
        
        progressHUD.textLabel.text = text
        progressHUD.detailTextLabel.text = detailText
        
        progressHUD.show(in: view)
        
        return progressHUD
    }
}
