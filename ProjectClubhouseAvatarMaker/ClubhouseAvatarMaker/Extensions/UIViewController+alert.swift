//
//  UIViewController+alert.swift
//  ClubhouseAvatarMaker
//
//  Created by Антон Текутов on 19.02.2021.
//

import UIKit

enum AlertType {
    case error
    case success
}

extension UIViewController {

    func showErrorAlert(with message: String?, errorHandler: (() -> Void)? = nil) {
        let alert = createAlert(title: "Ошибка", message: message, type: .error, style: .alert, handler: errorHandler)
        present(alert, animated: true, completion: nil)
    }

    func showSuccessAlert(with title: String, message: String, okHandler: (() -> Void)? = nil) {
        let alert = createAlert(title: title, message: message, type: .success, style: .alert, handler: okHandler)
        present(alert, animated: true, completion: nil)
    }
    
    func showChooseAlert(with title: String, message: String, okHandler: (() -> Void)? = nil, cancelHandler: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Oк", style: .default, handler: { (_) in
              okHandler?()
          })
        
        let cancelAction = UIAlertAction(title: "Отмена", style: .cancel, handler: { (_) in
            cancelHandler?()
        })

        alert.addAction(okAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithContinueQuestion(title: String, message: String, resultHandler: @escaping (_ continue: Bool) -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Отмена",
                                      style: .cancel,
                                      handler: { (_) in resultHandler(false) }))
        alert.addAction(UIAlertAction(title: "Продолжить",
                                      style: UIAlertAction.Style.default,
                                      handler: { (_) in resultHandler(true) }))
        present(alert, animated: true, completion: nil)
    }

    func createAlert(title: String,
                     message: String?,
                     type: AlertType,
                     style: UIAlertController.Style,
                     handler: (() -> Void)? = nil) -> UIAlertController {

        let alert = UIAlertController(title: title, message: message, preferredStyle: style)

        let action = UIAlertAction(title: "OK", style: .cancel, handler: { (_) in
            handler?()
        })

        alert.addAction(action)

        return alert
    }
    
    func showAlertWithPicker(title: String, message: String, pickerItems: [String], stringReturnHandler: @escaping (_ enteredText: String) -> Void) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: UIAlertController.Style.alert)
        
        let pickerView = UIPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 200))
        let pickerManager = PickerViewManager(pickerView: pickerView, itemsCollection: pickerItems)
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250, height: 200)
        vc.view.addSubview(pickerView)
        alert.setValue(vc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Отмена", comment: ""),
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Выбрать", comment: ""),
                                      style: UIAlertAction.Style.default,
                                      handler: { (_) in stringReturnHandler(pickerManager.selectedValue) }))
        present(alert, animated: true, completion: nil)
    }
    
    func showAlertWithColorPicker(startColor: UIColor?, colorReturnHandler: @escaping (_ color: UIColor) -> Void) {
        let alert = UIAlertController(title: "Выберите цвет",
                                      message: "",
                                      preferredStyle: UIAlertController.Style.alert)
        let colorPicker = ColorPickerView(frame: CGRect(x: 0, y: 0, width: 250, height: 265))
        if let startColor = startColor {
            colorPicker.setColor(startColor)
        }
        
        let vc = UIViewController()
        vc.preferredContentSize = CGSize(width: 250, height: 265)
        vc.view.addSubview(colorPicker)
        alert.setValue(vc, forKey: "contentViewController")
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Отмена", comment: ""),
                                      style: .cancel,
                                      handler: nil))
        alert.addAction(UIAlertAction(title: NSLocalizedString("Выбрать", comment: ""),
                                      style: UIAlertAction.Style.default,
                                      handler: { (_) in colorReturnHandler(colorPicker.color) }))
        present(alert, animated: true, completion: nil)
    }

}
