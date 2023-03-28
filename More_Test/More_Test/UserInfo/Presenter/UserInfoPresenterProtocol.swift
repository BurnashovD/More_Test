//
//  UserInfoPresenterProtocol.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

/// Протокол презентера экрана с информацией о выбранном пользователе
protocol UserInfoPresenterProtocol {
    var user: User { get set }
    func fetchInfo()
}
