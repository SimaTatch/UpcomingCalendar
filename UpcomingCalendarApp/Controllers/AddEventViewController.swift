//
//  AddEventViewController.swift
//  UpcomingCalendarApp
//
//  Created by Серафима  Татченкова  on 05.06.2022.
//

import UIKit

protocol AddEventViewControllerDelegate {
    func addNewEVE(text: EventStruct)
}

class AddEventViewController: UIViewController {
    
    var delegate: AddEventViewControllerDelegate?
    private let eventView = NewEventView()
    private let cellId = "EventCell"
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        view.backgroundColor = .specialMagnolia
        setupNavigationBar()
        addEventDatePicker.center = view.center
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        view.addSubview(eventView)
        view.addSubview(addEventDatePicker)
        setupConstraints()
    }
    
    private let addEventDatePicker: UIDatePicker = {
        let datePicker = UIDatePicker()
        let calendar = Calendar(identifier: .gregorian)
        datePicker.locale = .current
        datePicker.datePickerMode = .dateAndTime
        datePicker.preferredDatePickerStyle = .compact
        datePicker.tintColor = .specialIndigo
        let currentDate = Date()
        datePicker.minimumDate = currentDate
        datePicker.translatesAutoresizingMaskIntoConstraints = false
        return datePicker
    }()
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "New event"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 23)!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: #selector(saveButtonTapped))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancelButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .specialIndigo
        navigationItem.leftBarButtonItem?.tintColor = .specialIndigo
    }
    
    @objc func saveButtonTapped() {
        if let eventTitle = eventView.eventTitleTF.text, !eventTitle.isEmpty {
            let noteTitle = eventView.eventNotesTF.text ?? ""
            let targetDate = addEventDatePicker.date
//            let rounded = Date(timeIntervalSinceReferenceDate: (addEventDatePicker.date.timeIntervalSinceReferenceDate / 300.0).rounded(.up) * 300.0)
            let titleForScopeButton = dayCheck(date: targetDate)
            let remainingTime = getPollWillEndInInterval(havingEndDate: targetDate)
            let finalStruct = EventStruct(eventName: eventTitle, timeLeft: remainingTime, noteName: noteTitle,weekMonthYear: titleForScopeButton,certainDate: targetDate)
            delegate?.addNewEVE(text: finalStruct)
        }
    }
    
    @objc func cancelButtonTapped() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Determining the remaining time method
        private func getPollWillEndInInterval(havingEndDate endDate:Date) -> String {
            var resultString = ""
             let interval = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: Date(), to: endDate)
             
             if let year = interval.year, year > 0 {
                 resultString.append("\(year)y ")
             }
            if let month = interval.month, month > 0 {
                 resultString.append("\(month)m ")
             }
            if let day = interval.day, day > 0 {
                 resultString.append("\(day)d ")
             }
            if let hour = interval.hour, hour > 0 {
                 resultString.append("\(hour)h ")
             }
            if let minute = interval.minute, minute > 0 {
                 resultString.append("\(minute)m ")
             }  else {
                 resultString = "less than a min"
             }
            return resultString
         }
    
    func dayCheck(date: Date) -> String {
   
        var resultString = ""
        let currentDay = Date()//today
        let calendar = Calendar.current
        
        // week range
        let dayOfWeek = calendar.component(.weekday, from: currentDay) -  1
        let weekdays = calendar.range(of: .weekday, in: .weekOfYear, for: currentDay)!
        let daysWeek = (weekdays.lowerBound ..< weekdays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfWeek, to: currentDay) }
        
        if let lastWeekDay = daysWeek.last {
            if lastWeekDay >= date {
                resultString.append("Week")
            }
        }
        
        // month range
        let dayOfMonth = calendar.component(.weekdayOrdinal, from: currentDay) - 1
        let monthDays = calendar.range(of: .day, in: .month, for: currentDay)!
        let daysMonth = (monthDays.lowerBound ..< monthDays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfMonth, to: currentDay) }
        
        if let lastMonthDay = daysMonth.last {
            if lastMonthDay >= date {
                resultString.append("Month")
            }
        }
        
        // year range
        let dayOfYear = calendar.component(.weekdayOrdinal, from: currentDay) - 1
        let yearDays = calendar.range(of: .day, in: .year, for: currentDay)!
        let daysYear = (yearDays.lowerBound ..< yearDays.upperBound)
            .compactMap { calendar.date(byAdding: .day, value: $0 - dayOfYear, to: currentDay) }
        
        if let lastYearDay = daysYear.last {
            if lastYearDay >= date {
                resultString.append("Year")
            }
        }
        
        return resultString
    }
    
    public func removeTimeStamp(fromDate: Date) -> Date {
        guard let date = Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: fromDate)) else {
            fatalError("Failed to strip time from Date object")
        }
        return date
    }

    private func setupConstraints() {
        
        NSLayoutConstraint.activate ([
            eventView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            eventView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            eventView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            eventView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -400)
        ])
        
        NSLayoutConstraint.activate ([
            addEventDatePicker.topAnchor.constraint(equalTo: eventView.bottomAnchor, constant: 80),
            addEventDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
}




