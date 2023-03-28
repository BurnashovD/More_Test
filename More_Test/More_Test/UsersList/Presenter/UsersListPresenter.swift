//
//  UsersListPresenter.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation
import PromiseKit

/// Презентер экрана списка пользователей
final class UsersListPresenter: UsersListPresenterProtocol {
    // MARK: - Public properties
    
    var users: [User] = []
    
    // MARK: - Private properties
    
    private let networkService: NetworkServiceProtocol
    private let router: BaseRouterProtocol
    
    private weak var view: UsersListViewProtocol?
    private var lastProfileId = 0
    
    // MARK: - init
    
    init(view: UsersListViewProtocol, networkService: NetworkServiceProtocol, router: BaseRouterProtocol) {
        self.networkService = networkService
        self.router = router
        self.view = view
    }
    
    // MARK: - Public methods
    
    func fetchUsers() {
        firstly {
            networkService.fetchUsers(method: .users(lastProfileId), request: .users)
        }.then { users in
            self.users = users
            self.setNewId(users.last?.id)
            return Promise()
        }.done { _ in
            self.view?.loadUsers()
        }.catch { error in
            print(error.localizedDescription)
        }
    }
    
    func fetchForwardUsers() {
        firstly {
            networkService.fetchUsers(method: .users(lastProfileId), request: .users)
        }.done { users in
            guard
                self.users.last?.id != users.last?.id
            else { return }
            let oldUsersCount = self.users.count
            self.users.append(contentsOf: users)
            self.setNewId(self.users.last?.id)
            let newSections = (oldUsersCount ..< (oldUsersCount + users.count)).map { $0 }
            self.view?.loadForwardUsers(newSections)
        }.catch { error in
            print(error.localizedDescription)
        }
    }
    
    func refreshList() {
        firstly {
            networkService.fetchUsers(method: .users(0), request: .users)
        }.then { users in
            self.users = users
            return Promise()
        }.done { _ in
            self.view?.refreshList()
        }.catch { error in
            print(error.localizedDescription)
        }
    }
    
    func goForward(_ user: User) {
        router.forward(user)
    }
    
    // MARK: - Private methods
    
    private func setNewId(_ id: Int?) {
        guard let id = id else { return }
        lastProfileId = id
    }
}
