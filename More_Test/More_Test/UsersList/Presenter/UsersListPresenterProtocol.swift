//
//  UsersListPresenterProtocol.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

protocol UsersListPresenterProtocol {
    var users: [User] { get set }
    func fetchUsers()
    func goForward(_ user: User)
}
