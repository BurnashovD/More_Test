//
//  UserInfoRouter.swift
//  More_Test
//
//  Created by Daniil on 28.03.2023.
//

import UIKit

struct UserInfoRouter: UserInfoRouterProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
