//
//  UserInfoPresenterProtocol.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

protocol UserInfoPresenterProtocol {
    var user: User { get set }
    func fetchInfo()
}