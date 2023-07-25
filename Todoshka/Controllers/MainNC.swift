//
//  MainNavVC.swift
//  Todoshka
//
//  Created by Anton Kholodkov on 24.07.2023.
//

import UIKit

class MainNC: UINavigationController {
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
        
        configureNavBar()
    }
    
    private func configureNavBar() {
        let navBar = self.navigationBar
        
        
        let standardAppearance = UINavigationBarAppearance()
        standardAppearance.configureWithOpaqueBackground()
        standardAppearance.backgroundColor = UIColor(named: Colors.NavBarColor.rawValue)
        
        navBar.standardAppearance = standardAppearance
        navBar.scrollEdgeAppearance = standardAppearance
        navBar.compactAppearance = standardAppearance
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
