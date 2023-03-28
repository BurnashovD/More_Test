//
//  UsersListRouter.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit

/// Роутер экрана списка пользователей
struct UsersListRouter: BaseRouterProtocol {
    // MARK: - Private propeties
    
    private let navigationController: UINavigationController
    
    // MARK: - init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func initialVC() {
        let modul = UsersListModulBuilder.build(navigationController: navigationController)
        navigationController.pushViewController(modul, animated: true)
    }
    
    func forward(_ user: User) {
        let modul = UserInfoModulBuilder.build(user, navController: navigationController)
        navigationController.pushViewController(modul, animated: true)
    }
}
