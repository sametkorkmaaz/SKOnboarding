//
//  SKOnboardingPageViewController.swift
//  
//
//  Created by Samet Korkmaz on 16.09.2025.
//

import UIKit

class SKOnboardingPageViewController: UIViewController {

    private let page: SKOnboardingPage
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 32
        stackView.alignment = .center
        stackView.distribution = .fill
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()

    private let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 24, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = page.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 16, weight: .regular)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = page.textColor.withAlphaComponent(0.7)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    init(page: SKOnboardingPage) {
        self.page = page
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        configure()
    }

    private func setupUI() {
        view.backgroundColor = .clear
        
        view.addSubview(stackView)
        
        stackView.addArrangedSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        stackView.addArrangedSubview(titleLabel)
        stackView.addArrangedSubview(descriptionLabel)
        
        stackView.setCustomSpacing(16, after: imageContainerView)
        
        titleLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        descriptionLabel.widthAnchor.constraint(equalTo: stackView.widthAnchor).isActive = true
        
        NSLayoutConstraint.activate([
            stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32),
            stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32),
            stackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            
            imageContainerView.widthAnchor.constraint(equalTo: imageContainerView.heightAnchor),
            imageContainerView.widthAnchor.constraint(lessThanOrEqualTo: stackView.widthAnchor),
            imageContainerView.widthAnchor.constraint(lessThanOrEqualTo: view.widthAnchor, multiplier: 0.8),

            imageView.topAnchor.constraint(equalTo: imageContainerView.topAnchor),
            imageView.bottomAnchor.constraint(equalTo: imageContainerView.bottomAnchor),
            imageView.leadingAnchor.constraint(equalTo: imageContainerView.leadingAnchor),
            imageView.trailingAnchor.constraint(equalTo: imageContainerView.trailingAnchor),
        ])
        
        titleLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        descriptionLabel.setContentCompressionResistancePriority(.required, for: .vertical)
        imageContainerView.setContentCompressionResistancePriority(.defaultLow, for: .vertical)
    }

    private func configure() {
        imageView.image = page.image
        titleLabel.text = page.title
        descriptionLabel.text = page.description
    }
}
