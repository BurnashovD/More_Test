//
//  UserInfoPresenter.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation
import PromiseKit

/// Презентер экрана с информацией о выбранном пользователе
final class UserInfoPresenter: UserInfoPresenterProtocol {
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol
    private let router: UserInfoRouterProtocol
    
    private weak var view: UserInfoViewProtocol?
    
    // MARK: - Public propeties
    
    var user: User
    
    // MARK: - init
    
    init(view: UserInfoViewProtocol, user: User, router: UserInfoRouterProtocol, networkService: NetworkServiceProtocol) {
        self.networkService = networkService
        self.user = user
        self.view = view
        self.router = router
    }
    
    // MARK: - Public methods
    
    func fetchInfo() {
        firstly {
            networkService.fetchUsers(method: .user(user.login), request: .user)
        }.then { users in
            guard let user = users.first else { return Promise() }
            self.user = user
            return Promise()
        }.done { _ in
            self.view?.loadUserInfo()
        }.catch { error in
            print(error.localizedDescription)
        }
    }
}
