// The Swift Programming Language
// https://docs.swift.org/swift-book

import UIKit

public final class SKOnboarding {
    
    @MainActor public static func launch(from viewController: UIViewController,
                                         with pages: [SKOnboardingPage],
                                         completion: (() -> Void)? = nil) {
        guard !pages.isEmpty else {
            print("SKOnboarding Hata: Gösterilecek sayfa bulunamadı.")
            return
        }
        
        let onboardingVC = SKOnboardingViewController(pages: pages, onDismiss: completion)
        onboardingVC.modalPresentationStyle = .fullScreen
        
        viewController.present(onboardingVC, animated: true)
    }
}
