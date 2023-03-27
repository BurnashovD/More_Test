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
    private var lastProfileId = 0
    
    var users: [User] = []
    
    init(view: UsersListViewProtocol, networkService: NetworkServiceProtocol, router: BaseRouterProtocol) {
        self.networkService = networkService
        self.router = router
        self.view = view
    }
    
    func fetchUsers() {
        networkService.fetchUsers(method: .users(lastProfileId), request: .users) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(users):
                self.users = users
                self.setNewId(users.last?.id)
                self.view?.loadUsers()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func fetchForwardUsers() {
        // TODO: - Закончить префетч
        networkService.fetchUsers(method: .users(lastProfileId), request: .users) { [weak self] result in
            guard let self = self else { return }
            switch result {
            case let .success(users):
                let oldUsersCount = self.users.count
                self.users.append(contentsOf: users)
                let newSections = (oldUsersCount ..< (oldUsersCount + users.count)).map { $0 }
                self.view?.loadForwardUsers()
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
    
    func goForward(_ user: User) {
        router.forward(user)
    }
    
    private func setNewId(_ id: Int?) {
        guard let id = id else { return }
        lastProfileId = id
    }
}
