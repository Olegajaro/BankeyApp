//
//  OnboardingContainerViewController.swift
//  BankeyApp
//
//  Created by Олег Федоров on 07.01.2022.
//

import UIKit

class OnboardingContainerViewController: UIViewController {
    
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController
    let closeButton = UIButton(type: .system)
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        self.pageViewController = UIPageViewController(
            transitionStyle: .scroll,
            navigationOrientation: .horizontal,
            options: nil
        )
        
        let page1 = OnboardingViewController(
            imageName: "delorean",
            titleText: "Bankey is faster, easier to use, and has a brand new look and feel that will make you fell like you are back in 1989."
        )
        let page2 = OnboardingViewController(
            imageName: "world",
            titleText: "Move your money around the world quickly and securely."
        )
        let page3 = OnboardingViewController(
            imageName: "thumbs",
            titleText: "Learn more at www.bankey.com."
        )
        
        pages.append(page1)
        pages.append(page2)
        pages.append(page3)
        
        currentVC = pages.first!
        
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        style()
        layout()
    }
    
    private func setup() {
        view.backgroundColor = .systemPurple
        
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.dataSource = self
        pageViewController.view.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            view.topAnchor.constraint(
                equalTo: pageViewController.view.topAnchor
            ),
            view.leadingAnchor.constraint(
                equalTo: pageViewController.view.leadingAnchor
            ),
            view.trailingAnchor.constraint(
                equalTo: pageViewController.view.trailingAnchor
            ),
            view.bottomAnchor.constraint(
                equalTo: pageViewController.view.bottomAnchor
            )
        ])
        
        pageViewController.setViewControllers([pages.first!],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
        currentVC = pages.first!
    }
    
    private func style() {
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self,
                              action: #selector(closeTapped),
                              for: .primaryActionTriggered)
        view.addSubview(closeButton)
    }
    
    private func layout() {
        // closeButton
        NSLayoutConstraint.activate([
            closeButton.topAnchor.constraint(
                equalToSystemSpacingBelow: view.safeAreaLayoutGuide.topAnchor,
                multiplier: 2
            ),
            closeButton.leadingAnchor.constraint(
                equalToSystemSpacingAfter: view.leadingAnchor,
                multiplier: 2
            )
        ])
    }
    
    @objc private func closeTapped() {
        
    }
}

// MARK: - UIPageViewControllerDataSource
extension OnboardingContainerViewController: UIPageViewControllerDataSource {
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerBefore viewController: UIViewController
    ) -> UIViewController? {
        getPreviousViewController(from: viewController)
    }
    
    func pageViewController(
        _ pageViewController: UIPageViewController,
        viewControllerAfter viewController: UIViewController
    ) -> UIViewController? {
        getNextViewController(from: viewController)
    }
    
    private func getPreviousViewController(
        from viewController: UIViewController
    ) -> UIViewController? {
        guard
            let index = pages.firstIndex(of: viewController),
            index - 1 >= 0
        else { return nil }
        
        currentVC = pages[index - 1]
        return currentVC
    }
    
    private func getNextViewController(
        from viewController: UIViewController
    ) -> UIViewController? {
        guard
            let index = pages.firstIndex(of: viewController),
            index + 1 < pages.count
        else { return nil }
        
        currentVC = pages[index + 1]
        return currentVC
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        pages.firstIndex(of: self.currentVC) ?? 0
    }
}
