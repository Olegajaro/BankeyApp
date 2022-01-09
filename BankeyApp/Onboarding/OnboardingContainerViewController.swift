//
//  OnboardingContainerViewController.swift
//  BankeyApp
//
//  Created by Олег Федоров on 07.01.2022.
//

import UIKit

protocol OnboardingContainerViewControllerDelegate: AnyObject {
    func didFinishOnboarding()
}

class OnboardingContainerViewController: UIViewController {
    
    // MARK: - Properties
    let pageViewController: UIPageViewController
    var pages = [UIViewController]()
    var currentVC: UIViewController {
        didSet {
            guard let index = pages.firstIndex(of: currentVC) else { return }
            nextButton.isHidden = index == pages.count - 1
            backButton.isHidden = index == 0
            doneButton.isHidden = !(index == pages.count - 1)
        }
    }
    
    let nextButton = UIButton(type: .system)
    let backButton = UIButton(type: .system)
    let closeButton = UIButton(type: .system)
    let doneButton = UIButton(type: .system)
    
    weak var delegate: OnboardingContainerViewControllerDelegate?
    
    // MARK: - Lifecycle
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
    
    // MARK: - SetupUI
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
        nextButton.translatesAutoresizingMaskIntoConstraints = false
        nextButton.setTitle("Next", for: [])
        nextButton.addTarget(self,
                             action: #selector(nextTapped),
                             for: .primaryActionTriggered)
        
        backButton.translatesAutoresizingMaskIntoConstraints = false
        backButton.setTitle("Back", for: [])
        backButton.addTarget(self,
                             action: #selector(backTapped),
                             for: .primaryActionTriggered)
        
        closeButton.translatesAutoresizingMaskIntoConstraints = false
        closeButton.setTitle("Close", for: [])
        closeButton.addTarget(self,
                              action: #selector(closeTapped),
                              for: .primaryActionTriggered)
        
        
        doneButton.translatesAutoresizingMaskIntoConstraints = false
        doneButton.setTitle("Done", for: [])
        doneButton.addTarget(self,
                             action: #selector(doneTapped),
                             for: .primaryActionTriggered)
    }
    
    private func layout() {
        view.addSubview(nextButton)
        view.addSubview(backButton)
        view.addSubview(closeButton)
        view.addSubview(doneButton)
        
        // nextButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(
                equalToSystemSpacingAfter: nextButton.trailingAnchor,
                multiplier: 2
            ),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalToSystemSpacingBelow: nextButton.bottomAnchor,
                multiplier: 4
            )
        ])
        
        // backButton
        NSLayoutConstraint.activate([
            backButton.leadingAnchor.constraint(
                equalToSystemSpacingAfter: view.leadingAnchor,
                multiplier: 2
            ),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalToSystemSpacingBelow: backButton.bottomAnchor,
                multiplier: 4
            )
        ])
        
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
        
        // doneButton
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(
                equalToSystemSpacingAfter: doneButton.trailingAnchor,
                multiplier: 2
            ),
            view.safeAreaLayoutGuide.bottomAnchor.constraint(
                equalToSystemSpacingBelow: doneButton.bottomAnchor,
                multiplier: 4
            )
        ])
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
        return pages[index - 1]
    }
    
    private func getNextViewController(
        from viewController: UIViewController
    ) -> UIViewController? {
        guard
            let index = pages.firstIndex(of: viewController),
            index + 1 < pages.count
        else { return nil }
        
        currentVC = pages[index + 1]
        return pages[index + 1]
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        pages.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        pages.firstIndex(of: self.currentVC) ?? 0
    }
}

// MARK: - Actions
extension OnboardingContainerViewController {
    @objc private func nextTapped() {
        guard
            let nextVC = getNextViewController(from: currentVC)
        else { return }
        
        pageViewController.setViewControllers([nextVC],
                                              direction: .forward,
                                              animated: false,
                                              completion: nil)
    }
    
    @objc private func backTapped() {
        guard
            let previousVC = getPreviousViewController(from: currentVC)
        else { return }
        
        pageViewController.setViewControllers([previousVC],
                                              direction: .reverse,
                                              animated: false,
                                              completion: nil)
    }
    
    @objc private func closeTapped() {
        delegate?.didFinishOnboarding()
    }
    
    @objc private func doneTapped() {
        delegate?.didFinishOnboarding()
    }
}
