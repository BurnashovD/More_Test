//
//  UsersListPresenter.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

final class UsersListPresenter: UsersListPresenterProtocol {
    
    private let networkService: NetworkServiceProtocol
    private let router: BaseRouterProtocol
    private weak var view: UsersListViewProtocol?
    
    var users: [User] = []
    
    init(view: UsersListViewProtocol, networkService: NetworkServiceProtocol, router: BaseRouterProtocol) {
        self.networkService = networkService
        self.router = router
        self.view = view
    }
    
    func fetchUsers() {
        networkService.fetchUsers(method: .users(0), request: .users) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(users):
                self.users = users
                self.view?.loadUsers()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func goForward(_ user: User) {
        router.forward(user)
    }
}
