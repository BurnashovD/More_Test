//
//  UsersListViewProtocol.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

/// Протокол вью списка пользователей
protocol UsersListViewProtocol: AnyObject {
    func loadUsers()
    func refreshList()
    func loadForwardUsers(_ sections: [Int])
}
