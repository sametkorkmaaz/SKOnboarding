//
//  SKOnboardingPageViewController.swift
//  
//
//  Created by Samet Korkmaz on 16.09.2025.
//

import UIKit

class SKOnboardingPageViewController: UIViewController {

    private let page: SKOnboardingPage
    
    private let imageContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 28, weight: .bold)
        label.textAlignment = .center
        label.numberOfLines = 0
        label.textColor = page.textColor
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18, weight: .regular)
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
        
        view.addSubview(imageContainerView)
        imageContainerView.addSubview(imageView)
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        
        let imageContainerSize: CGFloat = view.bounds.width * 0.8
        
        NSLayoutConstraint.activate([
            imageContainerView.topAnchor.constraint(equalTo: view.topAnchor),
            imageContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            imageContainerView.widthAnchor.constraint(equalToConstant: imageContainerSize),
            imageContainerView.heightAnchor.constraint(equalToConstant: imageContainerSize),
            
            imageView.centerXAnchor.constraint(equalTo: imageContainerView.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: imageContainerView.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: imageContainerView.widthAnchor),
            imageView.heightAnchor.constraint(equalTo: imageContainerView.heightAnchor),
            
            titleLabel.topAnchor.constraint(equalTo: imageContainerView.bottomAnchor, constant: 32),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            
            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 16),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40)
            descriptionLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -4)
        ])
    }

    private func configure() {
        imageView.image = page.image
        titleLabel.text = page.title
        descriptionLabel.text = page.description
    }
}
