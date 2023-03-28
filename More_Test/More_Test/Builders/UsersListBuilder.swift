//
//  UsersListBuilder.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit

/// Сборщик модуля списка пользователей
enum UsersListModulBuilder {
    static func build(navigationController: UINavigationController) -> UIViewController {
        let view = UsersListViewController()
        let networkService = NetworkService()
        let router = UsersListRouter(navigationController: navigationController)
        let presenter = UsersListPresenter(view: view, networkService: networkService, router: router)
        view.presenter = presenter
        return view
    }
}
