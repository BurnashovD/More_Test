//
//  NetworkService.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Moya
import Foundation
import PromiseKit

/// Сетевой сервис
struct NetworkService: NetworkServiceProtocol {
    // MARK: - Private properties
    
    private let usersProvider = MoyaProvider<GitHub<Any>>()
    private let networkQueue = DispatchQueue(label: "networkQueue")
    
    // MARK: - Public methods
    
    func fetchUsers(method: GitHub<Any>, request: RequestType) -> Promise<[User]> {
        return Promise { seal in
            networkQueue.async {
                usersProvider.request(method) { result in
                    switch result {
                    case let .success(response):
                        do {
                            guard request == .users else {
                                guard
                                    let user = try? JSONDecoder().decode(User.self, from: response.data)
                                else { return }
                                seal.fulfill([user])
                                return
                            }
                            guard
                                let users = try? JSONDecoder().decode([User].self, from: response.data)
                            else { return }
                            seal.fulfill(users)
                            return
                        }
                    case let .failure(error):
                        seal.reject(error)
                    }
                }
            }
        }
    }
}



enum RequestType {
    case users
    case user
}
