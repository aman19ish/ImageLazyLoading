//
//  BaseViewController.swift
//  ImageLazyLoading
//
//  Created by Aman gupta on 20/06/20.
//  Copyright © 2020 AmanGupta. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    // MARK: - Outlets
    
    // MARK: - Properties
    
    // MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addKeyboardNotifications()
    }
    
    deinit {
        debugPrint("\(String(describing: self)) dealloacated")
        removeKeyboardNotifications()
    }
    
    // MARK: - Action Methods
    
}

// MARK: - Manage Keyboard Notification
extension BaseViewController {
    //Add Keyboard Notification
    func addKeyboardNotifications() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillDisappear), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillAppear), name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    //Add Keyboard Notification
    func removeKeyboardNotifications() {
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
    }
    
    func viewTextFieldEndEditing() {
        view.endEditing(true)
    }
    
    //Keyborad Notification selector methods
    @objc func keyboardWillDisappear(notification: NSNotification) {
        
    }
    
    @objc func keyboardWillAppear(notification: NSNotification) {
        
    }

}

// MARK: - Show Error Message
extension BaseViewController {
    func showAlertWithHandlers(messageTitle: String = MessageConstants.appTitle, messageText: String?, actionLeftTitle: String = MessageConstants.cancel, actionRightTitle: String = MessageConstants.oK, cancelCompletion: ((_ alert: UIAlertAction) -> Void), okCompletion: ((_ alert: UIAlertAction) -> Void)?) {
        let uiAlert = UIAlertController(title: messageTitle, message: messageText ?? ErrorMessageConstants.unknown.rawValue, preferredStyle: UIAlertController.Style.alert)
        uiAlert.addAction(UIAlertAction(title: actionLeftTitle, style: .default) { (alert) in
            okCompletion?(alert)
        })
        uiAlert.addAction(UIAlertAction(title: actionRightTitle, style: .default) { (alert) in
            okCompletion?(alert)
        })
        present(uiAlert, animated: true, completion: nil)
    }
    
}
