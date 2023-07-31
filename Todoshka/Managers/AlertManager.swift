//
//  AlertManager.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 31.07.2023.
//

import UIKit

class AlertManager {
    
}

//MARK: - TextField Alerts
extension AlertManager {
    
    private struct AlertAction {
        let title: String
        let style: UIAlertAction.Style
        let handler: ([String]) -> Void
    }
    
    private static func showTextFieldAlert(on vc: UIViewController,
                                           title: String,
                                           message: String? = nil,
                                           textFields: [(UITextField) -> Void],
                                           actions: [AlertAction]) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        textFields.forEach({ alert.addTextField(configurationHandler: $0) })
        
        actions.forEach { action in
            alert.addAction(UIAlertAction(title: action.title, style: action.style, handler: { _ in
                let strings = (alert.textFields ?? []).compactMap {
                    $0.text?.isEmpty == false ? $0.text : nil
                }
                action.handler(strings)
            }))
        }
        
        DispatchQueue.main.async { vc.present(alert, animated: true) }
    }
    
    static func addTaskAlert(on vc: UIViewController,
                            completion: @escaping ([String]) -> Void) {
        
        var textFields: [(UITextField) -> ()] = []
        
        textFields.append { (textField) in
            textField.placeholder = "e.g. call mom tomorrow morning"
            textField.autocapitalizationType = .none
        }
        
//        textFields.append { (textField) in
//            textField.placeholder = "Password"
//            textField.autocapitalizationType = .words
//            textField.isSecureTextEntry = true
//        }
        
        let actions: [AlertAction] = [
            AlertAction(title: "Cancel", style: .cancel, handler: { _ in completion([]) }),
            AlertAction(title: "Add", style: .default, handler: completion)
        ]
        
        self.showTextFieldAlert(on: vc, title: "Add new task", message: nil, textFields: textFields, actions: actions)
    }
}
