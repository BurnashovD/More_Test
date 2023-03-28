//
//  Routable.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

/// Протокол базового роутера
protocol BaseRouterProtocol {
    func initialVC()
    func forward(_ user: User)
}
