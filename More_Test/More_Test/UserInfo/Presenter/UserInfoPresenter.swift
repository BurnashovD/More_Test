//
//  UserInfoPresenter.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

final class UserInfoPresenter: UserInfoPresenterProtocol {
    private let networkService: NetworkServiceProtocol
    private let router: UserInfoRouterProtocol
    private weak var view: UserInfoViewProtocol?
    
    var user: User
    
    init(view: UserInfoViewProtocol, user: User, router: UserInfoRouterProtocol, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.user = user
        self.router = router
    }
}
