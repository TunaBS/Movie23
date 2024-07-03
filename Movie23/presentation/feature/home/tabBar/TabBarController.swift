//
//  TabBarController.swift
//  Movie23
//
//  Created by BS00880 on 3/7/24.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        setUpTabs()
        
        self.tabBar.barTintColor = .systemBackground
        self.tabBar.tintColor = .systemBlue
        self.tabBar.unselectedItemTintColor = .systemFill
    }
    

    private func setUpTabs() {
        let homeVC = self.createNav(with: "Home", and: UIImage(systemName: "house"), vc: HomeViewController())
        let watchListVC = self.createNav(with: "WatchList", and: UIImage(systemName: "list.bullet"), vc: WatchListViewController())
        let settingsVC = self.createNav(with: "Settings", and: UIImage(systemName: "gearshape.fill"), vc: SettingsViewController())
        let searchVC = self.createNav(with: "Search", and: UIImage(systemName: "magnifyingglass"), vc: SearchViewController())
        self.setViewControllers([homeVC, searchVC, watchListVC, settingsVC], animated: true)
    }
    
    private func createNav(with title: String, and image: UIImage?, vc: UIViewController) -> UINavigationController {
        
        let nav = UINavigationController(rootViewController: vc)
        nav.tabBarItem.title = title
        nav.tabBarItem.image = image
        
        return nav
    }

}
