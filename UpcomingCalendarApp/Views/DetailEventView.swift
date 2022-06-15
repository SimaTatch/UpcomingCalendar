
import UIKit

class DetailEventView: UIView {

    init() {
        super.init(frame: .zero)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        layer.cornerRadius = 5
        addSubview(eventName)
        addSubview(stack)
        stack.addArrangedSubview(eventName)
        stack.addArrangedSubview(timeLeftLabel)
        addSubview(eventDetail)
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public let eventName: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .poppinsMedium16
        label.minimumScaleFactor = 0.5
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let timeLeftLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .poppinsRegular16
//        label.layer.borderWidth = 1.0
//        label.layer.borderColor = UIColor.specialMagnolia.cgColor
        label.minimumScaleFactor = 0.5
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    public let eventDetail: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.font = .poppinsRegular16
        label.textAlignment = .left
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let stack: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    
    private func setupConstraints() {
        NSLayoutConstraint.activate ([
            eventName.heightAnchor.constraint(equalToConstant: self.frame.size.height),
            eventName.widthAnchor.constraint(equalToConstant: self.frame.size.width/2)
        ])
        
        NSLayoutConstraint.activate ([
            timeLeftLabel.heightAnchor.constraint(equalToConstant: self.frame.size.height),
            timeLeftLabel.widthAnchor.constraint(equalToConstant: self.frame.size.width/2)
        ])
        
        NSLayoutConstraint.activate ([
            stack.topAnchor.constraint(equalTo: self.topAnchor, constant: 0),
            stack.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            stack.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            stack.heightAnchor.constraint(equalToConstant: 60)
        ])
        
        NSLayoutConstraint.activate ([
            eventDetail.topAnchor.constraint(equalTo: stack.bottomAnchor, constant: 5),
            eventDetail.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            eventDetail.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            eventDetail.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0)
            
        ])
    }
}
