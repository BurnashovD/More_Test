//
//  UserInfoModulBuilder.swift
//  More_Test
//
//  Created by Daniil on 28.03.2023.
//

import UIKit

/// Сборщик модуля информации о пользователе
enum UserInfoModulBuilder {
    static func build(_ user: User, navController: UINavigationController) -> UIViewController {
        let view = UserInfoViewController()
        let networkService = NetworkService()
        let router = UserInfoRouter(navigationController: navController)
        let presenter = UserInfoPresenter(view: view, user: user, router: router, networkService: networkService)
        view.title = user.login
        view.presenter = presenter
        return view
    }
}
