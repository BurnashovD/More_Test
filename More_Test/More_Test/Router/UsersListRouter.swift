//
//  UsersListRouter.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit

struct UsersListRouter: BaseRouterProtocol {
    
    private let navigationController: UINavigationController
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func initialVC() {
        let modul = UsersListModulBuilder.build(navigationController: navigationController)
        navigationController.pushViewController(modul, animated: true)
    }
    
    func forward(_ user: User) {
        let modul = UserInfoModulBuilder.build(user, navController: navigationController)
        navigationController.pushViewController(modul, animated: true)
    }
}
