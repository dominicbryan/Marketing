//
//  SmartMotionMarketingViewController.swift
//  ABMarketing
//
//  Created by Dominic Bryan on 04/06/2020.
//  Copyright © 2020 Neos Ventures Ltd. All rights reserved.
//

import UIKit

public protocol SmartKitMarketingDelegate {
    func smartMotionKitBuyPressed()
    func smartSenseKitBuyPressed()
    func findOutMorePressed()
}

public enum SmartMotionMarketingVariants {
    case A, B
}

final public class SmartMotionMarketingViewController: UIViewController {

    private let delegate: SmartKitMarketingDelegate
    private let variant: SmartMotionMarketingVariants
    
    public init(delegate: SmartKitMarketingDelegate,
         variant: SmartMotionMarketingVariants = .A) {
        self.delegate = delegate
        self.variant = variant
        
        super.init(nibName: nil, bundle: nil)
        self.modalPresentationStyle = .overCurrentContext
        view.backgroundColor = .clear
        setupViews()
        addCloseTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .topaz
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 20
        view.layer.shadowColor = UIColor.shadowGrey.cgColor
        view.layer.shadowOpacity = 1
        view.layer.shadowOffset = CGSize(width: 0.0, height: 2.0)
        view.layer.shadowRadius = 10
        return view
    }()
    
    private lazy var containerStack: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 11.0, left: 0.0, bottom: 29.0, right: 0.0)
        return stackView
    }()
    
    
    // MARK: - Title stack
    private let celebrationEmojiLabel: UILabel = {
        let label = UILabel()
        label.text = "🎉"
        label.font = UIFont.systemFont(ofSize: 32.0)
        return label
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "NEW FROM NEOS"
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Bold", size: 20.0)
        return label
    }()
    
    private let subtitleLabel: UILabel = {
        let label = UILabel()
        label.text = "Discover Neos Smart Kits"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .regular)
        return label
    }()
    
    private lazy var titleStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [celebrationEmojiLabel,
                                                       titleLabel,
                                                       subtitleLabel])
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 4.0
        return stackView
    }()
    
    
    // MARK: - Smart Motion Kit Stack
    
    private let smartMotionKitLabel: UILabel = {
        let label = UILabel()
        label.text = "SMART MOTION KIT"
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Bold", size: 16.0)
        return label
    }()
    
    private let smartMotionKitSubLabel: UILabel = {
        let label = UILabel()
        
        let attributedString = NSMutableAttributedString(string: "Motion and contact sensors: senses movement within rooms and senses open and close action", attributes: [
          .font: UIFont.systemFont(ofSize: 14.0, weight: .regular),
          .foregroundColor: UIColor(white: 1.0, alpha: 1.0),
          .kern: -0.12
        ])
        attributedString.addAttribute(.font, value: UIFont.systemFont(ofSize: 14.0, weight: .bold), range: NSRange(location: 0, length: 26))
        label.attributedText = attributedString
        label.numberOfLines = 0
        return label
    }()
    
    private let smartMotionKitBuyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY NOW", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        button.backgroundColor = .darkTopaz
        button.layer.cornerRadius = 21.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layoutMargins = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 50)
        button.addTarget(self, action: #selector(smartMotionKitBuyButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var smartMotionKitBuyButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smartMotionKitBuyButton,
                                                       UIView()])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var smartMotionKitLeftStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smartMotionKitLabel,
                                                       smartMotionKitSubLabel])
        stackView.axis = .vertical
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0.0, left: 18.0, bottom: 0.0, right: 0.0)
        stackView.setCustomSpacing(11.0, after: smartMotionKitSubLabel)
        return stackView
    }()
    
    private let smartMotionKitImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "smartMotionKitImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var smartMotionKitContainerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smartMotionKitLeftStack,
                                                       smartMotionKitImage])
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.alignment = .top
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 25.0, left: 0.0, bottom: 25.0, right: 9.0)
        return stackView
    }()
    
    // MARK: - Smart Leak Kit Stack
    
    private let smartSenseKitLabel: UILabel = {
        let label = UILabel()
        label.text = "SMART LEAK KIT"
        label.textColor = .white
        label.font = UIFont(name: "Montserrat-Bold", size: 16.0)
        return label
    }()
    
    private let smartSenseKitSubLabel: UILabel = {
        let label = UILabel()
        label.text = "Get alerts for water leaks, humidity and temperature"
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .regular)
        label.textColor = .white
        label.numberOfLines = 0
        return label
    }()
    
    private let smartSenseKitBuyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY NOW", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        button.backgroundColor = .darkTopaz
        button.layer.cornerRadius = 21.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(smartSenseKitBuyButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var smartSenseKitBuyButtonStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smartSenseKitBuyButton,
                                                       UIView()])
        stackView.axis = .horizontal
        return stackView
    }()
    
    private lazy var smartSenseKitRightStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smartSenseKitLabel,
                                                       smartSenseKitSubLabel])
        stackView.axis = .vertical
        switch variant {
        case .A:
            stackView.setCustomSpacing(11.0, after: smartSenseKitSubLabel)
        case .B:
            stackView.isLayoutMarginsRelativeArrangement = true
            stackView.layoutMargins = UIEdgeInsets(top: 15.0, left: 0.0, bottom: 0.0, right: 0.0)
        }
        return stackView
    }()
    
    private let smartSenseKitImage: UIImageView = {
        let imageView = UIImageView(image: UIImage(named: "smartSenseKitImage"))
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private lazy var smartSenseKitContainerStack: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [smartSenseKitImage,
                                                       smartSenseKitRightStack])
        stackView.axis = .horizontal
        stackView.spacing = 6.0
        stackView.alignment = .top
        stackView.distribution = .fillProportionally
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0.0, left: 7.0, bottom: 0.0, right: 22.0)
        return stackView
    }()
    
    // MARK: - New Label
    
    private let smartMotionKitNewLabel: UILabel = newLabel()
    
    private let smartSenseKitNewLabel: UILabel = newLabel()
    
    private static func newLabel() -> UILabel {
        let label = UILabel()
        label.text = "NEW!"
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }
    
    // MARK: - Find Out More Button
    private let findOutMoreButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("FIND OUT MORE", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 14.0, weight: .bold)
        button.backgroundColor = .darkTopaz
        button.layer.cornerRadius = 21.0
        button.translatesAutoresizingMaskIntoConstraints = false
        button.contentEdgeInsets = UIEdgeInsets(top: 0.0, left: 19.0, bottom: 0.0, right: 19.0)
        button.addTarget(self, action: #selector(findOutMoreButtonAction), for: .touchUpInside)
        return button
    }()
    
    private lazy var findOutMoreStackView: UIStackView = {
        let stackView = UIStackView(arrangedSubviews: [findOutMoreButton])
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        return stackView
    }()
    
    // MARK: - Close button
    private let closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setBackgroundImage(UIImage(named: "newFromNeosMarketingCloseButton"), for: .normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(closeButtonAction), for: .touchUpInside)
        return button
    }()
    
    // MARK: - Setup Views
    private func setupViews() {
        /// Setup containing view
        view.addSubview(containerView)
        view.addSubview(containerStack)
        
        /// Setup stacks
        containerStack.addArrangedSubview(titleStack)
        containerStack.addArrangedSubview(smartMotionKitContainerStack)
        containerStack.addArrangedSubview(smartSenseKitContainerStack)
        
        /// Add close button to title stack
        titleStack.addSubview(closeButton)
        
        /// Setup buttons for variant
        switch variant {
        case .A:
            smartMotionKitLeftStack.addArrangedSubview(smartMotionKitBuyButtonStack)
            smartSenseKitRightStack.addArrangedSubview(smartSenseKitBuyButtonStack)
        case .B:
            containerStack.addArrangedSubview(findOutMoreStackView)
            containerStack.setCustomSpacing(8.0, after: smartSenseKitContainerStack)
        }
        
        /// Setup new labels
        smartMotionKitImage.addSubview(smartMotionKitNewLabel)
        smartSenseKitImage.addSubview(smartSenseKitNewLabel)
        
        let constraints: [NSLayoutConstraint] = [
            /// Container View
            containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            containerView.heightAnchor.constraint(equalToConstant: 428),
            containerView.widthAnchor.constraint(equalToConstant: 313),
            
            ///Container Stack
            containerStack.topAnchor.constraint(equalTo: containerView.topAnchor),
            containerStack.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            containerStack.bottomAnchor.constraint(equalTo: containerView.bottomAnchor),
            containerStack.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            
            /// Smart Motion label and button sizing
            smartMotionKitSubLabel.widthAnchor.constraint(equalToConstant: 215),
            smartMotionKitBuyButton.heightAnchor.constraint(equalToConstant: 42.0),
            smartMotionKitBuyButton.widthAnchor.constraint(equalToConstant: 150),
            
            /// Smart Motion label and button sizing
            smartSenseKitRightStack.widthAnchor.constraint(equalToConstant: 170),
            smartSenseKitBuyButton.heightAnchor.constraint(equalToConstant: 42.0),
            smartSenseKitBuyButton.widthAnchor.constraint(equalToConstant: 150),
            
            /// New Labels
            smartMotionKitNewLabel.topAnchor.constraint(equalTo: smartMotionKitImage.topAnchor),
            smartMotionKitNewLabel.centerXAnchor.constraint(equalTo: smartMotionKitImage.centerXAnchor, constant: 20),
            
            smartSenseKitNewLabel.topAnchor.constraint(equalTo: smartSenseKitImage.topAnchor),
            smartSenseKitNewLabel.centerXAnchor.constraint(equalTo: smartSenseKitImage.centerXAnchor, constant: 10),
            
            /// Find out more button
            findOutMoreButton.heightAnchor.constraint(equalToConstant: 42.0),
            
            /// Close button
            closeButton.heightAnchor.constraint(equalToConstant: 24),
            closeButton.widthAnchor.constraint(equalToConstant: 24),
            closeButton.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 12),
            closeButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -12)
        ]
        
        NSLayoutConstraint.activate(constraints)
        
        
    }
    
    // MARK: - Setup Button Targets
    
    @objc private func smartMotionKitBuyButtonAction() {
        delegate.smartMotionKitBuyPressed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func smartSenseKitBuyButtonAction() {
        delegate.smartSenseKitBuyPressed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func findOutMoreButtonAction() {
        delegate.findOutMorePressed()
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc private func closeButtonAction() {
        self.dismiss(animated: true, completion: nil)
    }
    
    // MARK: - Tap Gesture to dismiss pop-up
    
    private func addCloseTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(closeButtonAction))
        view.addGestureRecognizer(tap)
    }
}

extension UIColor {
    static let topaz = UIColor(red: 22/255.0, green: 195/255.0, blue: 183/255.0, alpha: 1.0)
    
    static let darkTopaz = UIColor(red: 16/255.0, green: 146/255.0, blue: 137/255.0, alpha: 1.0)
    
    static let shadowGrey = UIColor(red: 119/255.0, green: 129/255.0, blue: 134/255.0, alpha: 1.0)
}
