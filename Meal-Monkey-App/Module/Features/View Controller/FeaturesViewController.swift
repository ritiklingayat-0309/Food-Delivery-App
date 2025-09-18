//
//  FeaturesViewController.swift
//  Meal-Monkey-App
//
//  Created by Ritik Lingayat on 04/08/25.
//

import UIKit

/// `FeaturesViewController`
///
/// Displays the onboarding feature screens in a collection view with images, titles,
/// and subtitles. Supports swiping through pages or navigating using the "Next/Done" button.
class FeaturesViewController: UIViewController {

    // MARK: - Outlets

    /// Label to display the subtitle/description of the current feature.
    @IBOutlet weak var lblSubTitle: UILabel!

    /// Button to navigate to the next feature or complete onboarding.
    @IBOutlet weak var btnNext: UIButton!

    /// Collection view that displays the feature images.
    @IBOutlet weak var colView: UICollectionView!

    /// Label to display the title of the current feature.
    @IBOutlet weak var lblTitle: UILabel!

    /// Page control to indicate the current onboarding step.
    @IBOutlet weak var pageController: UIPageControl!

    // MARK: - Properties

    /// Array of `Features` objects used to populate the collection view and labels.
    var arrFeatures: [Features] = Features.addData()

    // MARK: - Lifecycle

    /// Called after the controller's view is loaded into memory.
    override func viewDidLoad() {
        super.viewDidLoad()

        // Set initial labels
        updateLabels(for: 0)

        // Apply styles
        EditStyle.setborder(textfields: [btnNext])
        self.navigationItem.hidesBackButton = true

        // Register collection view cell
        colView.register(
            UINib(
                nibName: Main.CellIdentifier.FeaturesCollectionViewCell,
                bundle: nil
            ),
            forCellWithReuseIdentifier: Main.CellIdentifier
                .FeaturesCollectionViewCell
        )

        // Configure page control
        pageController.numberOfPages = arrFeatures.count
        pageController.currentPage = 0
        pageController.addTarget(
            self,
            action: #selector(pageControlTapped(_:)),
            for: .valueChanged
        )

        //  Apply theme initially
        applyTheme()

        //  Listen for theme changes
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(applyTheme),
            name: NSNotification.Name("themeChanged"),
            object: nil
        )

    }

    @objc func pageControlTapped(_ sender: UIPageControl) {
        let page = sender.currentPage
        let xOffset = CGFloat(page) * colView.frame.width
        colView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
        updateLabels(for: page)
    }

    // MARK: - UI Update
    /// Updates the title, subtitle, and button text for the given feature page.
    /// - Parameter page: The index of the current feature.
    func updateLabels(for page: Int) {
        guard page < arrFeatures.count else { return }
        let feature = arrFeatures[page]
        lblTitle.text = feature.title
        lblSubTitle.text = feature.subtitle

        // Change button title on last page
        if page == arrFeatures.count - 1 {
            btnNext.setTitle(
                LocalizationManager.shared.localizedString(
                    forKey: Main.Features.btnDone
                ),
                for: .normal
            )

        } else {
            btnNext.setTitle(
                LocalizationManager.shared.localizedString(
                    forKey: Main.Features.btnNext
                ),
                for: .normal
            )
        }
    }

    // MARK: - Actions

    /// Handles the Next/Done button tap.
    /// - Parameter sender: The button triggering the action.
    @IBAction func btnNextClick(_ sender: Any) {
        let currentPage = pageController.currentPage

        // If not the last page, go to the next page
        if currentPage < arrFeatures.count - 1 {
            let nextPage = currentPage + 1
            let xOffset = CGFloat(nextPage) * colView.frame.width
            colView.setContentOffset(CGPoint(x: xOffset, y: 0), animated: true)
            pageController.currentPage = nextPage
            updateLabels(for: nextPage)

            // If last page, navigate to Login screen
        } else {
            let storyboard = UIStoryboard(
                name: Main.StoryboardIdentifier.LoginStoryboard,
                bundle: nil
            )
            if let signUpVC = storyboard.instantiateViewController(
                withIdentifier: Main.ViewControllerIdentifier
                    .LoginViewController
            ) as? LoginViewController {
                self.navigationController?.pushViewController(
                    signUpVC,
                    animated: true
                )
            }
        }
    }

    @objc private func applyTheme() {
        let theme = ThemeManager.currentTheme
        view.backgroundColor = theme.backgroundColor
        lblTitle.textColor = theme.titleColor
        lblSubTitle.textColor = theme.secondaryFontColor
        btnNext.backgroundColor = theme.buttonColor
        btnNext.setTitleColor(theme.buttonTitle, for: .normal)
        pageController.currentPageIndicatorTintColor = theme.buttonColor
        pageController.pageIndicatorTintColor = theme.buttonColor
            .withAlphaComponent(0.4)
    }

    deinit {
        NotificationCenter.default.removeObserver(
            self,
            name: NSNotification.Name("themeChanged"),
            object: nil
        )
    }
}
