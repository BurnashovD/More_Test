//
//  UserInfoRouter.swift
//  More_Test
//
//  Created by Daniil on 28.03.2023.
//

import UIKit

/// Роутер экрана с информацией о выбранном пользователе
struct UserInfoRouter: UserInfoRouterProtocol {
    // MARK: - Private properties
    
    private let navigationController: UINavigationController
    
    // MARK: - init
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    // MARK: - Public methods
    
    func back() {
        navigationController.popViewController(animated: true)
    }
}
