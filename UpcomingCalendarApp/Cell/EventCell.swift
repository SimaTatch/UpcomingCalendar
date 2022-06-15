//
//  EventCell.swift
//  UpcomingCalendarApp
//
//  Created by Серафима  Татченкова  on 04.06.2022.
//

import Foundation
import UIKit

class EventCell: UITableViewCell {
    
    
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.backgroundColor = .white
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        eventName.frame = CGRect(x: 5,
                                 y: 5,
                                 width: contentView.frame.size.width/2,
                                 height: contentView.frame.size.height - 10)
        eventDate.frame = CGRect(x: eventName.frame.size.width + 5,
                                 y: 5,
                                 width: contentView.frame.size.width/2 - 10,
                                 height: contentView.frame.size.height - 10)
    }
    
     let eventName: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
//        label.text = "ddddddddd"
        label.font = .poppinsRegular16
        label.numberOfLines = 0
        label.minimumScaleFactor = 0.7
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
     let eventDate: UILabel = {
        let label = UILabel()
        label.adjustsFontSizeToFitWidth = true
//        label.text = "date/date/date"
        label.textAlignment = .right
        label.numberOfLines = 0
         label.font = .poppinsRegular16
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    

    
    private func setupViews() {
        self.addSubview(eventName)
        self.addSubview(eventDate)
    }
}
