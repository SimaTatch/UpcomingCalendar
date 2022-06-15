
import UIKit

class DetailViewController: UIViewController {

    let detailEventView = DetailEventView()
    private let addVC = AddEventViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .specialMagnolia
        setupNavigationBar()
        view.addSubview(detailEventView)
        setupConstraints()
    }
    
    //MARK: - NavigationBar install
    private func setupNavigationBar() {
        self.navigationController?.navigationBar.topItem?.title = "Event details"
        self.navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.font: UIFont(name: "Poppins-Medium", size: 23)!]
        navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "xmark.circle.fill"),
            style: .plain,
            target: self,
            action: #selector(cancellButtonTapped))
        navigationItem.leftBarButtonItem =
            UIBarButtonItem(
                image: UIImage(systemName: "square.and.arrow.up"),
                style: .plain,
                target: self,
                action: #selector(shareButtonTapped)
            )
        navigationItem.rightBarButtonItem?.tintColor = .specialIndigo
        navigationItem.leftBarButtonItem?.tintColor = .specialIndigo
        navigationController?.hidesBarsOnSwipe = true
    }
    
    @objc func cancellButtonTapped() {
        self.dismiss(animated: true)
    }
    
    @objc func shareButtonTapped() {
        let vc = UIActivityViewController(activityItems: [detailEventView.eventName.text as Any,detailEventView.eventDetail.text as Any, detailEventView.timeLeftLabel.text as Any], applicationActivities: [])
           vc.popoverPresentationController?.barButtonItem = navigationItem.rightBarButtonItem
           present(vc, animated: true)
    }

    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            detailEventView.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
            detailEventView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            detailEventView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
            detailEventView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -450)
        ])
        
    }
}
