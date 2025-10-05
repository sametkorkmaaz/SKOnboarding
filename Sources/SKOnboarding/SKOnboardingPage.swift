//
//  SKOnboardingPage.swift
//  
//
//  Created by Samet Korkmaz on 16.09.2025.
//

import UIKit

public struct SKOnboardingPage {
    public var image: UIImage
    public var title: String
    public var description: String
    public var mainColor: UIColor = .systemBlue
    public var textColor: UIColor = .label
    
    public init(image: UIImage, title: String, description: String, mainColor: UIColor = .systemBlue, textColor: UIColor = .label) {
        self.image = image
        self.title = title
        self.description = description
        self.mainColor = mainColor
        self.textColor = textColor
    }
}
