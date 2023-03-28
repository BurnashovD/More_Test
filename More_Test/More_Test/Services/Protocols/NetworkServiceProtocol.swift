//
//  NetworkServiceProtocol.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation
import PromiseKit

/// Протокол сетевого сервиса
protocol NetworkServiceProtocol {
    func fetchUsers(method: GitHub<Any>, request: RequestType) -> Promise<[User]>
}
