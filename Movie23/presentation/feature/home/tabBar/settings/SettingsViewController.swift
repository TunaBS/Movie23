
//  SettingsViewController.swift
//  Movie23
//
//  Created by BS00880 on 3/7/24.
//

import UIKit

class SettingsViewController: UIViewController {
    
//    let authManager = AuthenticationManager.shared
//    var languageManager = LanguageManager.shared
    let englishButton = CustomButton(title: "English", hasBackground: false, fontSize: .small, titleColor: .systemBlue)
    let banglaButton = CustomButton(title: "Bengali", hasBackground: false, fontSize: .small, titleColor: .systemBlue)
//    var language = "en"
    var savedLanguage = UserDefaults.standard.string(forKey: "appLanguage")
               
    let noName = "No name"

    let userNameOfCurrentUser = AuthenticationManager.shared.currentUser?.userName
    let emailOfCurrentUser = AuthenticationManager.shared.currentUser?.email
//    let headerView = HeaderView(title: "Settings")
    var userInfoBox = UIView()
    var appSupportBoxForDarkTheme = UIView()
    var appSupportBoxForLanguage = UIView()
    var accountSettingsBox = UIView()
    
    let darkModeSwitch: UISwitch = {
        let toggleSwitch = UISwitch()
        toggleSwitch.addTarget(self, action: #selector(didChangeSwitch), for: .valueChanged)
        return toggleSwitch
    }()
    let isDarkMode = UserDefaults.standard.bool(forKey: "isDarkMode")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBackground

        /*NotificationCenter.default.addObserver(self, selector: #selector(languageDidChange), name: .languageDidChange, object: nil)*/
                
        userInfoBox = showUserInfo(userName: userNameOfCurrentUser ?? "No Name", email: emailOfCurrentUser ?? "No email")
        print("Current Username in settings view: \(userNameOfCurrentUser ?? noName)")
        print("Current User Email in settings view: \(emailOfCurrentUser ?? noName)")
        appSupportBoxForDarkTheme = showSupports(heading: "Theme", bodyLine: "Dark Theme", darkMode: true)
        appSupportBoxForLanguage = showSupports(heading: "Language", bodyLine: "Language", darkMode: false)
        accountSettingsBox = showAccountSettingsButtons()
        
        addSubViews()
        setUpUI()
        darkModeSwitch.isOn = isDarkMode
        applyTheme(isDarkMode: isDarkMode)
    }
    
    private func addSubViews() {
        view.addSubview(userInfoBox)
        view.addSubview(appSupportBoxForDarkTheme)
        view.addSubview(appSupportBoxForLanguage)
        view.addSubview(accountSettingsBox)
    }
    private func setUpUI() {
        userInfoBox.pinToBottomOfSomethingCenter(height: nil, to: self.view, to: nil, width: 0.8, topPlace: true)
        appSupportBoxForDarkTheme.pinToBottomOfSomethingCenter(height: nil, to: self.view, to: userInfoBox, width: 0.9)
        appSupportBoxForLanguage.pinToBottomOfSomethingCenter(height: nil, to: self.view, to: appSupportBoxForDarkTheme, width: 0.9)
        accountSettingsBox.pinToBottomOfSomethingCenter(height: nil, to: self.view, to: appSupportBoxForLanguage, width: 0.9)
        
    }
    
    private func showUserInfo(userName: String, email: String) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = true
        
        let userNameLabel = UILabel()
        userNameLabel.text = userName
        userNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        userNameLabel.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(userNameLabel)
        
        let emailLabel = UILabel()
        emailLabel.text = email
        emailLabel.font = UIFont.boldSystemFont(ofSize: 16)
        emailLabel.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(emailLabel)
        
        
        userNameLabel.topAnchor.constraint(equalTo: fullView.topAnchor).isActive = true
        userNameLabel.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 10).isActive = true
        emailLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 10).isActive = true
        emailLabel.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 10).isActive = true
        emailLabel.trailingAnchor.constraint(equalTo: fullView.trailingAnchor).isActive = true
        emailLabel.bottomAnchor.constraint(equalTo: fullView.bottomAnchor).isActive = true
        
        
        let paddedView = createPaddedContainer(
            for: fullView,
            padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            cornerRadius: 10.0,
            borderWidth: 0.8,
            borderColor: .systemGray2
        )
        
        return paddedView
    }
    
    private func showSupports(heading: String, bodyLine: String, darkMode: Bool) -> UIView {
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = false
        
        let headingLabel = UILabel()
        headingLabel.text = heading
        headingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(headingLabel)
        
        let bodyLineLabel = UILabel()
        bodyLineLabel.text = bodyLine
        bodyLineLabel.font = UIFont.boldSystemFont(ofSize: 16)
        bodyLineLabel.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(bodyLineLabel)
        
        headingLabel.topAnchor.constraint(equalTo: fullView.topAnchor).isActive = true
        headingLabel.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        bodyLineLabel.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        bodyLineLabel.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
//        bodyLineLabel.trailingAnchor.constraint(equalTo: fullView.trailingAnchor).isActive = true
        bodyLineLabel.bottomAnchor.constraint(equalTo: fullView.bottomAnchor).isActive = true
        
        if(darkMode) {
            fullView.addSubview(darkModeSwitch)
            darkModeSwitch.translatesAutoresizingMaskIntoConstraints = false
            darkModeSwitch.centerYAnchor.constraint(equalTo: bodyLineLabel.centerYAnchor).isActive = true
            darkModeSwitch.leadingAnchor.constraint(equalTo: bodyLineLabel.trailingAnchor, constant: 10).isActive = true
            darkModeSwitch.trailingAnchor.constraint(equalTo: fullView.trailingAnchor, constant: -10).isActive = true
            
            } else {
            let languageButton = languageButton()
            fullView.addSubview(languageButton)
            languageButton.translatesAutoresizingMaskIntoConstraints = false
            languageButton.centerYAnchor.constraint(equalTo: bodyLineLabel.centerYAnchor).isActive = true
            languageButton.leadingAnchor.constraint(greaterThanOrEqualTo: bodyLineLabel.trailingAnchor, constant: 10).isActive = true
            languageButton.trailingAnchor.constraint(equalTo: fullView.trailingAnchor, constant: -10).isActive = true
        }
        
        let paddedView = createPaddedContainer(
            for: fullView,
            padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            cornerRadius: 10.0,
            borderWidth: 0.0
        )
        
        return paddedView
    }
    
    @objc func didChangeSwitch(_ sender: UISwitch) {
        let isDarkMode = sender.isOn
        applyTheme(isDarkMode: isDarkMode)
        UserDefaults.standard.set(isDarkMode, forKey: "isDarkMode")
    }
    func applyTheme(isDarkMode: Bool) {
        UIApplication.shared.windows.forEach { window in
            window.overrideUserInterfaceStyle = isDarkMode ? .dark : .light
        }
        UIColor.foregroundColor = isDarkMode ? UIColor(white: 1.0, alpha: 1) : UIColor(white: 0.0, alpha: 1)
    }

    
    private func languageButton() -> UIView {
        let fullView = UIView()
        
        englishButton.tag = 1
        banglaButton.tag = 2
        
        englishButton.translatesAutoresizingMaskIntoConstraints = false
        banglaButton.translatesAutoresizingMaskIntoConstraints = false
        
        fullView.addSubview(englishButton)
        fullView.addSubview(banglaButton)
        
        englishButton.addTarget(self, action: #selector(languageButtonPressed), for: .touchUpInside)
        banglaButton.addTarget(self, action: #selector(languageButtonPressed), for: .touchUpInside)
        
        englishButton.topAnchor.constraint(equalTo: fullView.topAnchor).isActive = true
        englishButton.leadingAnchor.constraint(equalTo: fullView.leadingAnchor).isActive = true
        banglaButton.topAnchor.constraint(equalTo: fullView.topAnchor).isActive = true
        banglaButton.leadingAnchor.constraint(equalTo: englishButton.trailingAnchor, constant: 10).isActive = true
        banglaButton.bottomAnchor.constraint(equalTo: fullView.bottomAnchor).isActive = true
        banglaButton.trailingAnchor.constraint(equalTo: fullView.trailingAnchor).isActive = true
        return fullView
    }
    
    @objc func languageButtonPressed(sender: UIButton) {
        switch sender.tag {
        case 1:
            print("en selected in Setting vc")
//            languageManager.setLanguage(.english)
            self.languageChanged(strLanguage: "en")
            savedLanguage = "en"
            print("Saved language after button is pressed \(savedLanguage)")
        case 2:
            print("bn selected in Setting vc")
//            languageManager.setLanguage(.bengali)
            self.languageChanged(strLanguage: "bn-BD")
            savedLanguage = "bn-BD"
            print("Saved language after button is pressed \(savedLanguage)")
        default:
            break
        }
    }
    
    func languageChanged(strLanguage: String) {
        englishButton.setTitle("Eng".localizableString(loc: strLanguage), for: .normal)
        banglaButton.setTitle("Ban".localizableString(loc: strLanguage), for: .normal)
    }
    
    private func showAccountSettingsButtons() -> UIView{
        let fullView = UIView()
        fullView.translatesAutoresizingMaskIntoConstraints = true
        
        let headingLabel = UILabel()
//        headingLabel.text = languageManager.localizedString(forKey: "User Profile")
        headingLabel.font = UIFont.boldSystemFont(ofSize: 24)
        headingLabel.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(headingLabel)
        
        let logOutButton = CustomButton(title: "Log Out", fontSize: .small, titleColor: .systemRed)
        logOutButton.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(logOutButton)
        
        let deleteAccountButton = CustomButton(title: "Delete Account", fontSize: .small, titleColor: .systemRed)
        deleteAccountButton.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(deleteAccountButton)
        
        logOutButton.addTarget(self, action: #selector(didTapLogOut), for: .touchUpInside)
        deleteAccountButton.addTarget(self, action: #selector(didTapDeleteAccount), for: .touchUpInside)
        
        
        let signOutImage = UIImageView(image: UIImage(systemName: "rectangle.portrait.and.arrow.forward"))
        signOutImage.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(signOutImage)
        
        let deleteAccountImage = UIImageView(image: UIImage(systemName: "delete.right.fill"))
        deleteAccountImage.translatesAutoresizingMaskIntoConstraints = false
        fullView.addSubview(deleteAccountImage)
        
        headingLabel.topAnchor.constraint(equalTo: fullView.topAnchor).isActive = true
        headingLabel.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 10).isActive = true
        
        signOutImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        signOutImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        signOutImage.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        signOutImage.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 10).isActive = true
//        logOutButton.topAnchor.constraint(equalTo: headingLabel.bottomAnchor, constant: 10).isActive = true
        logOutButton.centerYAnchor.constraint(equalTo: signOutImage.centerYAnchor).isActive = true
        logOutButton.leadingAnchor.constraint(equalTo: signOutImage.trailingAnchor, constant: 10).isActive = true
        
        deleteAccountImage.widthAnchor.constraint(equalToConstant: 24).isActive = true
        deleteAccountImage.heightAnchor.constraint(equalToConstant: 24).isActive = true
        deleteAccountImage.topAnchor.constraint(equalTo: logOutButton.bottomAnchor, constant: 10).isActive = true
        deleteAccountImage.leadingAnchor.constraint(equalTo: fullView.leadingAnchor, constant: 10).isActive = true
        
        deleteAccountButton.centerYAnchor.constraint(equalTo: deleteAccountImage.centerYAnchor).isActive = true
        deleteAccountButton.leadingAnchor.constraint(equalTo: deleteAccountImage.trailingAnchor, constant: 10).isActive = true
//        deleteAccountButton.trailingAnchor.constraint(equalTo: fullView.trailingAnchor).isActive = true
        deleteAccountButton.trailingAnchor.constraint(lessThanOrEqualTo: fullView.trailingAnchor, constant: -10).isActive = true
        deleteAccountButton.bottomAnchor.constraint(equalTo: fullView.bottomAnchor).isActive = true
        
        
        let paddedView = createPaddedContainer(
            for: fullView,
            padding: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
            cornerRadius: 10.0,
            borderWidth: 0.0
        )
        
        return paddedView
    }
    
    @objc private func didTapLogOut() {
        Task {
            try await AuthenticationManager.shared.signOut()
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                await sceneDelegate.checkSignInUser()
                print("into scene delegate")
            }
        }
        
    }
    
    @objc private func didTapDeleteAccount() {
        Task {
            try await AuthenticationManager.shared.deleteAccount()
            if let sceneDelegate = self.view.window?.windowScene?.delegate as? SceneDelegate {
                await sceneDelegate.checkSignInUser()
                print("into scene delegate")
            }
        }
    }
}
extension String {
    func localizableString(loc: String) -> String {
        let path = Bundle.main.path(forResource: loc, ofType: "lproj")
        let bundle = Bundle(path: path!)
        return NSLocalizedString(self, tableName: nil, bundle: bundle!, value: "", comment: "")
    }
}
