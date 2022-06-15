//
//  NewEventView.swift
//  UpcomingCalendarApp
//
//  Created by Серафима  Татченкова  on 05.06.2022.
//

import UIKit

class NewEventView: UIView {

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 10
        addSubview(eventTitleTF)
        addSubview(eventNotesTF)
        setupConstraints()
        eventTitleTF.becomeFirstResponder()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
     let eventTitleTF: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.underLineSetup()
        textField.setLeftPaddingPoints(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    
     let eventNotesTF: UITextField = {
       let textField = UITextField()
        textField.placeholder = "Notes"
        textField.setLeftPaddingPoints(10)
        textField.translatesAutoresizingMaskIntoConstraints = false
        return textField
    }()
    

    private func setupConstraints() {
        
        NSLayoutConstraint.activate ([
            eventTitleTF.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            eventTitleTF.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            eventTitleTF.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            eventTitleTF.heightAnchor.constraint(equalToConstant: 80)
        ])

        NSLayoutConstraint.activate ([
            eventNotesTF.topAnchor.constraint(equalTo: eventTitleTF.bottomAnchor, constant: 2),
            eventNotesTF.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            eventNotesTF.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            eventNotesTF.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)

        ])
        
        
        
        // does not work
//        NSLayoutConstraint.activate ([
//            eventTitleTF.widthAnchor.constraint(equalToConstant: frame.size.width),
//            eventTitleTF.heightAnchor.constraint(equalToConstant: 80)
//        ])
//
//        NSLayoutConstraint.activate ([
//            eventNotesTF.widthAnchor.constraint(equalToConstant: frame.size.width),
//            eventNotesTF.heightAnchor.constraint(equalToConstant: frame.height - 80)
//
//        ])
        
        
    }
}


extension UITextField {

    
    func setLeftPaddingPoints(_ amount:CGFloat){
        let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: amount, height: self.frame.size.height))
        self.leftView = paddingView
        self.leftViewMode = .always
    }

    
    func underLineSetup() {
        let bottomLine = CALayer()
        bottomLine.frame = CGRect(x: 10.0, y: 75 - 1, width: 325, height: 0.5)
        bottomLine.backgroundColor = UIColor(red: 0.235, green: 0.235, blue: 0.263, alpha: 0.36).cgColor
        self.borderStyle = UITextField.BorderStyle.none
        self.layer.addSublayer(bottomLine)
    }
}
