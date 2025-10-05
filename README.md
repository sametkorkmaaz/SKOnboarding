# SKOnboarding

[![Swift Version](https://img.shields.io/badge/Swift-5.9-orange.svg)](https://swift.org)
[![Platform](https://img.shields.io/badge/Platform-iOS%2013%2B-blue.svg)](https://developer.apple.com/ios/)
[![License](https://img.shields.io/badge/License-MIT-lightgrey.svg)](https://opensource.org/licenses/MIT)

`SKOnboarding` is a simple, stylish, and fully customizable onboarding library for Swift UIKit projects. Add a modern onboarding flow to your app with just a few lines of code.

## ✨ Features

-   🎨 **Fully Customizable:** Set a unique main color and text color for each onboarding page.
-   🌀 **Modern Design:** A sleek look featuring a curved header and circular image views.
-   👍 **Easy to Use:** Comes with pre-built "Next", "Done", and "Skip" buttons.
-   🧩 **Simple Integration:** Add it to your project in seconds with Swift Package Manager (SPM).
-   ✅ **Completion Handler Support:** Execute code once the onboarding flow is completed.

## 📸 Screenshot

*(It's highly recommended to add a screenshot or GIF of your library in action here. You can add the image to your repository and link it.)*

![SKOnboarding Demo](https://i.imgur.com/gK9Jg0h.jpg)

## ⚙️ Installation

You can easily add `SKOnboarding` to your project using **Swift Package Manager**.

1.  In your Xcode project, go to `File > Add Packages...`
2.  In the search bar, paste the URL of this repository:
    ```
    [https://github.com/your-username/SKOnboarding.git](https://github.com/your-username/SKOnboarding.git)
    ```
3.  For the "Dependency Rule", select **"Up to Next Major Version"** and click **"Add Package"**.

## 🚀 Usage

Using the library is straightforward. First, `import SKOnboarding`. Then, create an array of `SKOnboardingPage` objects and call the `launch` method.

```swift
import UIKit
import SKOnboarding

class ViewController: UIViewController {

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showOnboarding()
    }

    private func showOnboarding() {
        // Create your pages with custom content and colors
        let pages: [SKOnboardingPage] = [
            SKOnboardingPage(image: UIImage(named: "image1") ?? UIImage(),
                             title: "Explore",
                             description: "Discover all the amazing features our app has to offer.",
                             mainColor: UIColor(red: 0.22, green: 0.69, blue: 0.45, alpha: 1.00),
                             textColor: .darkGray),
            SKOnboardingPage(image: UIImage(named: "image2") ?? UIImage(),
                             title: "Save",
                             description: "Easily save your favorite content to your profile for later.",
                             mainColor: .systemOrange,
                             textColor: .darkGray),
            SKOnboardingPage(image: UIImage(named: "image3") ?? UIImage(),
                             title: "Search",
                             description: "Find exactly what you're looking for with our advanced search.",
                             mainColor: .systemPurple,
                             textColor: .darkGray)
        ]
        
        // Launch the onboarding flow
        SKOnboarding.launch(from: self, with: pages) {
            print("Onboarding was successfully completed!")
            // You can add code here to run after the user finishes the onboarding.
        }
    }
}
```

### Customization

You can customize each page by passing parameters when creating an `SKOnboardingPage` object:

-   `image`: The `UIImage` to be displayed on the page.
-   `title`: The main title text.
-   `description`: The description text below the title.
-   `mainColor`: The color of the header and the "Next/Done" button for that page.
-   `textColor`: The color of the title and description text for that page.

## 📝 License

This project is licensed under the MIT License. See the `LICENSE` file for more details.
