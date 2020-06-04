//
//  SmartMotionMarketingCell.swift
//  ABMarketing
//
//  Created by Dominic Bryan on 04/06/2020.
//  Copyright © 2020 Neos Ventures Ltd. All rights reserved.
//

import UIKit

public protocol SmartMotionMarketingCellDelegate: class {
    func actionButtonPressed()
}

class SmartMotionMarketingCell: UITableViewCell {
    
    static let cellIdentifier: String = "smartMotionMarketingCell"
    
    private weak var delegate: SmartMotionMarketingCellDelegate?
    private var variant: SmartMotionMarketingVariants = .A

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        selectionStyle = .none
        backgroundColor = .topaz
        setupViews()
        
        /// Action needs to be added once the cell is initiated, adding this in the button constant closure meant self was nil.
        actionButton.addTarget(self,
                               action: #selector(buyButtonAction),
                               for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - Container Stack
    lazy var containerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [])
        stackView.axis = .horizontal
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.distribution = .fillProportionally
        stackView.spacing = 5
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 8)
        return stackView
    }()
    
    // MARK: - Centre Stack
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW FROM NEOS!"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textAlignment = .center
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Neos Smart Kits"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textAlignment = .center
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY NOW", for: .normal)
        button.titleEdgeInsets = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        button.titleLabel?.adjustsFontSizeToFitWidth = true
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        button.backgroundColor = .darkTopaz
        button.layer.cornerRadius = 16.0
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    private lazy var buttonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [UIView(),
                                                       actionButton,
                                                       UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 15
        stackView.distribution = .fillProportionally
        return stackView
    }()
    
    private lazy var centreStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [titleLabel,
                                                       subtitleLabel,
                                                       buttonStack])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 15, left: 0, bottom: 14, right: 0)
        stackView.setCustomSpacing(11, after: subtitleLabel)
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    // MARK: - Left Stack
    
    private let smartMotionKitImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "smartMotionKitImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let smartMotionKitLabel: UILabel = {
        let label = UILabel()
        label.text = "Smart Motion Kit"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var leftStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smartMotionKitImage,
                                                       smartMotionKitLabel])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 17, left: 0, bottom: 11, right: 0)
        return stackView
    }()
    
    // MARK: - Right Stack
    
    private let smartSenseKitImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "smartSenseKitImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let smartSenseKitLabel: UILabel = {
        let label = UILabel()
        label.text = "Smart Leak Kit"
        label.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        label.textColor = .white
        label.textAlignment = .center
        return label
    }()
    
    private lazy var rightStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smartSenseKitImage,
                                                       smartSenseKitLabel])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 17, left: 0, bottom: 11, right: 0)
        return stackView
    }()
    
    // MARK: - Setup Views
    private func setupViews() {
        addSubview(containerStack)
        
        containerStack.addArrangedSubview(leftStack)
        containerStack.addArrangedSubview(centreStack)
        containerStack.addArrangedSubview(rightStack)
        
        let constraints: [NSLayoutConstraint] = [
            containerStack.topAnchor.constraint(equalTo: topAnchor),
            containerStack.trailingAnchor.constraint(equalTo: trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: bottomAnchor),
            containerStack.leadingAnchor.constraint(equalTo: leadingAnchor),
            
            smartMotionKitLabel.heightAnchor.constraint(equalToConstant: 16),
            smartSenseKitLabel.heightAnchor.constraint(equalToConstant: 16),
            centreStack.widthAnchor.constraint(equalToConstant: 130)
        ]
        
        NSLayoutConstraint.activate(constraints)
    }
    
    // MARK: Button Actions
    @objc private func buyButtonAction() {
        delegate?.actionButtonPressed()
    }
    
    //MARK: - Configure Cell
    public func configure(delegate: SmartMotionMarketingCellDelegate, variant: SmartMotionMarketingVariants = .A) {
        self.variant = variant
        self.delegate = delegate
        
        switch variant {
        case .A:
            actionButton.setTitle("BUY NOW", for: .normal)
            buttonStack.spacing = 15
        case .B:
            actionButton.setTitle("FIND OUT MORE", for: .normal)
            buttonStack.spacing = 0
        }
    }
    
}
