//
//  UIViewController+Extension.swift
//  UpcomingCalendarApp
//
//  Created by Серафима  Татченкова  on 14.06.2022.
//

import UIKit


//MARK: - Keyboard is dissapears after view is tapped
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissKeyboard() {
        view.endEditing(true)
    }
}
