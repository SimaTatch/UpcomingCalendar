//
//  ViewController.swift
//  UpcomingCalendarApp
//
//  Created by Серафима  Татченкова  on 02.06.2022.
//

import UIKit



class MainEventsViewController: UIViewController, AddEventViewControllerDelegate, UISearchBarDelegate, UISearchResultsUpdating {

    
    let idForCell = "MyCell"
    var eventStruct = [EventStruct]()
    var filteredEventStruct = [EventStruct]()
    let searchController = UISearchController()
    var boolResult = Bool()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround() 
        initSearchController()
        customDatePicker.isHidden = true
        customDatePicker.addTarget(self, action: #selector(handleDatePicker), for: .valueChanged)
        view.backgroundColor = .white
        setupNavigationBar()
        setupViews()
        setupTableView()
        setupConstraints()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        self.navigationController?.isNavigationBarHidden = false
    }
  
// MARK: - UI properties
    private var eventsTableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .clear
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var customDatePicker: UIDatePicker = {
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

// MARK: - @objc methods for buttonItems and datePicker
    
    @objc private func handleDatePicker() {
        filterForSearchTextAndScopeButton(searchText: "", scopeButton: searchController.searchBar.scopeButtonTitles![searchController.searchBar.selectedScopeButtonIndex])
    }
    
    @objc private func addEventsButtonTapped() {
        let addVC = AddEventViewController()
        addVC.delegate = self
        self.present(UINavigationController(rootViewController: addVC), animated: true, completion: nil)
    }
    
// MARK: - AppEventViewController delegate method implementation
    func addNewEVE(text: EventStruct) {
        self.dismiss(animated: true) {
            self.eventStruct.append(text)
            DispatchQueue.main.async {
                self.eventsTableView.reloadData()
            }
        }
    }
}



//MARK: - SearchController installation and implementation
extension MainEventsViewController {
    
    func initSearchController() {
        searchController.loadViewIfNeeded()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.enablesReturnKeyAutomatically = false
        searchController.searchBar.returnKeyType = UIReturnKeyType.done
        definesPresentationContext = true
        
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        searchController.searchBar.scopeButtonTitles = ["All", "Week", "Month", "Year", "Custom"]
        searchController.searchBar.delegate = self
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        let searchBar = searchController.searchBar
        
        let scopeButton = searchBar.scopeButtonTitles![searchBar.selectedScopeButtonIndex]
        let searchText = searchBar.text!
        
        filterForSearchTextAndScopeButton(searchText: searchText, scopeButton: scopeButton)
    }
    func  filterForSearchTextAndScopeButton(searchText: String, scopeButton: String = "All") {
        
        filteredEventStruct = eventStruct.filter { event in
            customDatePicker.isHidden = true
            
            let scopeMatch = (scopeButton == "All" ||
                              event.weekMonthYear.lowercased().contains(scopeButton.lowercased()))
            
//            only if custom button is tapped
            if scopeButton == "Custom" {
                customDatePicker.isHidden = false
                if event.certainDate.isBetween(Date(), and: customDatePicker.date) {
                    eventsTableView.reloadData()
                    
//                    if searchText exists while custom button is tapped
                    if (searchController.searchBar.text != "") {
                        let searchMatchText = event.eventName.lowercased().contains(searchText.lowercased())
                        return searchMatchText
                    }
                    return true
                }
            }
//            if searchText exists while other buttons are tapped
            if (searchController.searchBar.text != "") {
                let searchMatchText = event.eventName.lowercased().contains(searchText.lowercased())
                return scopeMatch && searchMatchText
            } else {
                return scopeMatch
            }
        }
        eventsTableView.reloadData()
    }
}



// MARK: - Views, navigationBar, constraints setup
extension MainEventsViewController {
    
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "My Events"
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addEventsButtonTapped))
        navigationItem.rightBarButtonItem?.tintColor = .specialIndigo
        navigationController?.hidesBarsOnSwipe = true
    }
    
    private func setupViews() {
        view.addSubview(eventsTableView)
        view.addSubview(customDatePicker)
    }
    
    private func setupTableView() {
        eventsTableView.register(EventCell.self, forCellReuseIdentifier: idForCell)
        eventsTableView.dataSource = self
        eventsTableView.delegate = self
    }
    
    private func setupConstraints() {

        NSLayoutConstraint.activate ([
            customDatePicker.topAnchor.constraint(equalTo: view.safeTopAnchor, constant: 0),
            customDatePicker.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        
        NSLayoutConstraint.activate ([
            eventsTableView.topAnchor.constraint(equalTo: customDatePicker.bottomAnchor, constant: 5),
            eventsTableView.leadingAnchor.constraint(equalTo: view.safeLeftAnchor, constant: 10),
            eventsTableView.bottomAnchor.constraint(equalTo: view.safeBottomAnchor, constant: -10),
            eventsTableView.trailingAnchor.constraint(equalTo: view.safeRightAnchor, constant: -10)
        ])
    }
}




// MARK: - UITableViewDelegate, UITableViewDataSource
extension MainEventsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (searchController.isActive) {
            return filteredEventStruct.count
        }
        return eventStruct.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idForCell, for: indexPath) as! EventCell
         
        let thisStruct: EventStruct!
        
        if (searchController.isActive) {
            thisStruct = filteredEventStruct[indexPath.row]
        } else {
            thisStruct = eventStruct[indexPath.row]
        }
        
        cell.eventName.text = thisStruct.eventName
        let date = thisStruct.timeLeft
        cell.eventDate.text = date
        cell.backgroundColor = .specialLightGray
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath)
    {
        let verticalPadding: CGFloat = 8
        let maskLayer = CALayer()
        maskLayer.cornerRadius = 3
        maskLayer.backgroundColor = UIColor.specialLightGray.cgColor
        maskLayer.frame = CGRect(x: cell.bounds.origin.x, y: cell.bounds.origin.y, width: cell.bounds.width, height: cell.bounds.height).insetBy(dx: 0, dy: verticalPadding/2)
        cell.layer.mask = maskLayer
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let detailVC = DetailViewController()
        let thisStruct: EventStruct!
        
        if (searchController.isActive) {
            thisStruct = filteredEventStruct[indexPath.row]
        } else {
            thisStruct = eventStruct[indexPath.row]
        }
        
        detailVC.detailEventView.eventName.text = thisStruct.eventName
        detailVC.detailEventView.eventDetail.text = thisStruct.noteName
        detailVC.detailEventView.timeLeftLabel.text = thisStruct.timeLeft
        self.present(UINavigationController(rootViewController: detailVC), animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCell.EditingStyle {
        return .delete
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.beginUpdates()
            eventStruct.remove(at:indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)
            tableView.endUpdates()
        }
    }
}


