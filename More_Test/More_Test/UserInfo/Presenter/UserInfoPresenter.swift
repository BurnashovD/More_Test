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
        self.view = view
        self.router = router
    }
    
    func fetchInfo() {
        networkService.fetchUsers(method: .user(user.login), request: .user) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(user):
                guard let user = user.first else { return }
                self.user = user
                self.view?.loadUserInfo()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
