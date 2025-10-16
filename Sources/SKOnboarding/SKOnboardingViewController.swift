//
//  SKOnboardingViewController.swift
//  
//
//  Created by Samet Korkmaz on 16.09.2025.
//

import UIKit

class SKOnboardingViewController: UIViewController {

    // MARK: - Properties
    private var pages: [SKOnboardingPage]
    private var onDismiss: (() -> Void)?
    private var currentPageIndex = 0
    
    private var pageViewController: UIPageViewController!
    private lazy var pageViewControllers: [UIViewController] = {
        return self.pages.map { SKOnboardingPageViewController(page: $0) }
    }()
    
    // MARK: - UI Elements
    private let headerView = UIView()
    private let headerShapeLayer = CAShapeLayer()
    
    private let pageControl: UIPageControl = {
        let pc = UIPageControl()
        pc.currentPageIndicatorTintColor = .darkGray
        pc.pageIndicatorTintColor = .lightGray
        pc.translatesAutoresizingMaskIntoConstraints = false
        pc.isUserInteractionEnabled = false
        return pc
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = .systemFont(ofSize: 18, weight: .bold)
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 25
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var skipButton: UIButton = {
        let button = UIButton()
        button.setTitle("Skip", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 17, weight: .regular)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(skipButtonTapped), for: .touchUpInside)
        return button
    }()

    // MARK: - Initializer
    init(pages: [SKOnboardingPage], onDismiss: (() -> Void)?) {
        self.pages = pages
        self.onDismiss = onDismiss
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setupPageViewController()
        updateUI(for: 0)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        let path = UIBezierPath()
        path.move(to: .zero)
        path.addLine(to: CGPoint(x: 0, y: headerView.bounds.height))
        path.addQuadCurve(to: CGPoint(x: headerView.bounds.width, y: headerView.bounds.height),
                          controlPoint: CGPoint(x: headerView.bounds.width / 2, y: headerView.bounds.height - 100))
        path.addLine(to: CGPoint(x: headerView.bounds.width, y: 0))
        path.close()
        headerShapeLayer.path = path.cgPath
    }

    // MARK: - Setup
    private func setupViews() {
        headerView.translatesAutoresizingMaskIntoConstraints = false
        headerView.layer.addSublayer(headerShapeLayer)
        
        view.addSubview(headerView)
        view.addSubview(skipButton)
        view.addSubview(nextButton)
        view.addSubview(pageControl)
        
        pageControl.numberOfPages = pages.count
        
        NSLayoutConstraint.activate([
            headerView.topAnchor.constraint(equalTo: view.topAnchor),
            headerView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            headerView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            headerView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.3),

            skipButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),
            skipButton.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -20),
            
            pageControl.bottomAnchor.constraint(equalTo: nextButton.topAnchor, constant: -view.bounds.height * 0.02),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

            nextButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -16),
            nextButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 40),
            nextButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -40),
            nextButton.heightAnchor.constraint(equalToConstant: view.bounds.height * 0.08)
        ])
    }
    
    private func setupPageViewController() {
        pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        pageViewController.dataSource = self
        pageViewController.delegate = self
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        pageViewController.view.backgroundColor = .clear
        
        NSLayoutConstraint.activate([
            pageViewController.view.topAnchor.constraint(equalTo: headerView.bottomAnchor, constant: -view.bounds.height * 0.2),
            pageViewController.view.bottomAnchor.constraint(equalTo: pageControl.topAnchor),
            pageViewController.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            pageViewController.view.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
        
        if let firstVC = pageViewControllers.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: true)
        }
    }
    
    // MARK: - Actions
    @objc private func skipButtonTapped() {
        dismiss(animated: true, completion: onDismiss)
    }
    
    @objc private func nextButtonTapped() {
        let isLastPage = currentPageIndex == pages.count - 1
        if isLastPage {
            dismiss(animated: true, completion: onDismiss)
        } else {
            let nextIndex = currentPageIndex + 1
            pageViewController.setViewControllers([pageViewControllers[nextIndex]], direction: .forward, animated: true) { [weak self] _ in
                self?.updateUI(for: nextIndex)
            }
        }
    }
    
    // MARK: - Helper Methods
    private func updateUI(for index: Int) {
        guard index >= 0 && index < pages.count else { return }
        
        currentPageIndex = index
        let currentPage = pages[index]
        let isLastPage = index == pages.count - 1
        view.backgroundColor = currentPage.bgColor

        headerShapeLayer.fillColor = currentPage.mainColor.cgColor
        nextButton.backgroundColor = currentPage.mainColor
        skipButton.setTitleColor(.white, for: .normal)
        pageControl.currentPage = index
        pageControl.currentPageIndicatorTintColor = currentPage.mainColor
        pageControl.pageIndicatorTintColor = currentPage.mainColor.withAlphaComponent(0.3)
        
        let buttonTitle = isLastPage ? "DONE" : "NEXT"
        nextButton.setTitle(buttonTitle, for: .normal)
    }
}

// MARK: - UIPageViewController DataSource & Delegate
extension SKOnboardingViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewControllers.firstIndex(of: viewController), index > 0 else { return nil }
        return pageViewControllers[index - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = pageViewControllers.firstIndex(of: viewController), index < pageViewControllers.count - 1 else { return nil }
        return pageViewControllers[index + 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard completed, let currentVC = pageViewController.viewControllers?.first, let index = pageViewControllers.firstIndex(of: currentVC) else { return }
        updateUI(for: index)
    }
}
