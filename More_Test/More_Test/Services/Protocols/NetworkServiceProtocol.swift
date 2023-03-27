//
//  NetworkServiceProtocol.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

protocol NetworkServiceProtocol {
    func fetchUsers(method: GitHub<Any>, request: RequestType, _ completion: @escaping ((Result<[User], Error>) -> Void))
}
