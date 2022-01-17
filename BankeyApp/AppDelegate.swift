//
//  AppDelegate.swift
//  BankeyApp
//
//  Created by Олег Федоров on 04.01.2022.
//

import UIKit

let appColor: UIColor = .systemTeal

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    let loginViewController = LoginViewController()
    let onboardingContainerViewController = OnboardingContainerViewController()
    let mainViewController = MainViewController()
    
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
    ) -> Bool {
        
        window = UIWindow(frame: UIScreen.main.bounds)
        window?.makeKeyAndVisible()
        window?.backgroundColor = .systemBackground
        
        loginViewController.delegate = self
        onboardingContainerViewController.delegate = self
        
        registerForNotifications()
        
        displayLogin()
        return true
    }
    
}

// MARK: - Navigation
extension AppDelegate {
    private func displayLogin() {
        setRootViewController(loginViewController)
    }
    
    private func displaNextScreen() {
        if LocalState.hasOnBoarded {
            prepMainView()
            setRootViewController(mainViewController)
        } else {
            setRootViewController(onboardingContainerViewController)
        }
    }
}

// MARK: - Protocol Delegate Methods
extension AppDelegate: LoginViewContollerDelegate {
    func didLogin() {
        displaNextScreen()
    }
}

extension AppDelegate: OnboardingContainerViewControllerDelegate {
    func didFinishOnboarding() {
        LocalState.hasOnBoarded = true
        prepMainView()
        setRootViewController(mainViewController)
    }
}

// MARK: - Notifications
extension AppDelegate {
    private func registerForNotifications() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(didLogout),
            name: .logout,
            object: nil
        )
    }
    
    @objc func didLogout() {
        setRootViewController(loginViewController)
    }
}

// MARK: - Helpers
extension AppDelegate {
    func setRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard animated, let window = self.window else {
            self.window?.rootViewController = vc
            self.window?.makeKeyAndVisible()
            return
        }
        
        window.rootViewController = vc
        window.makeKeyAndVisible()
        UIView.transition(with: window,
                          duration: 0.3,
                          options: .transitionCrossDissolve,
                          animations: nil,
                          completion: nil)
    }
    
    private func prepMainView() {
        mainViewController.setStatusBar()
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().backgroundColor = appColor
    }
}
