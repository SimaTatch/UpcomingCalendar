//
//  CustomButton.swift
//  UpcomingCalendarApp
//
//  Created by Серафима  Татченкова  on 03.06.2022.
//

import Foundation
import UIKit



//MARK: - filter buttons: unabled, since I found out about scopeButton

class CustomButton: UIButton {
    
    required init(titleString : String) {
        super.init(frame: .zero)
        backgroundColor = .specialGray
        titleLabel?.text = titleString
        titleLabel?.font = .poppinsRegular16
        layer.cornerRadius = 13
        setTitle(titleString, for: .normal)
        setTitleColor(.black, for: .normal)
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

class ButtonStackView: UIView {
    
    init() {
        super.init(frame: .zero)
        backgroundColor = .clear
        setupArrangedSubviews()
        addSubview(customStackView)
        addTargetToButtons()
        setupConstraints()
        translatesAutoresizingMaskIntoConstraints = false
    }
    
    var buttonCompletion: ((String) -> Void)?
    
    let weekButton = CustomButton(titleString: "Week")
    let monthButton = CustomButton(titleString: "Month")
    let yearButton = CustomButton(titleString: "Year")
    let customButton = CustomButton(titleString: "Custom")
    
     let customStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        stackView.spacing = 5
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func buttonIsTapped(sender: UIButton) {
        deselectAllButtons()
        sender.isSelected = true
        sender.backgroundColor = .specialIndigo
        sender.setTitleColor(.white, for: .normal)
        buttonCompletion?(sender.titleLabel?.text ?? "")
        
//        switch sender.titleLabel?.text {
//        case "Week": return weekButtonBool = true
//        case "Month": return monthButtonBool = true
//        case "Year": return yearButtonBool = true
//        case "Custom": return customButtonBool = true
//        default: break
//        }
    }
    
     func deselectAllButtons(){
        for subView in customStackView.arrangedSubviews
        {
            if let button = subView as? UIButton {
                button.isSelected = false
                button.backgroundColor = .specialGray
                button.setTitleColor(.black, for: .normal)
            }
        }
    }
    
     func setupArrangedSubviews() {
        customStackView.addArrangedSubview(weekButton)
        customStackView.addArrangedSubview(monthButton)
        customStackView.addArrangedSubview(yearButton)
        customStackView.addArrangedSubview(customButton)
    }
    
     func addTargetToButtons() {
        weekButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        monthButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        yearButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        customButton.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            weekButton.widthAnchor.constraint(equalToConstant: self.frame.width/4),
            weekButton.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
        
        NSLayoutConstraint.activate ([
            monthButton.widthAnchor.constraint(equalToConstant: self.frame.width/4),
            monthButton.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
        
        NSLayoutConstraint.activate ([
            yearButton.widthAnchor.constraint(equalToConstant: self.frame.width/4),
            yearButton.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
        
        NSLayoutConstraint.activate ([
            customButton.widthAnchor.constraint(equalToConstant: self.frame.width/4),
            customButton.heightAnchor.constraint(equalToConstant: self.frame.height)
        ])
        
        NSLayoutConstraint.activate ([
            customStackView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            customStackView.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            customStackView.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            customStackView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
        ])
    }
}
