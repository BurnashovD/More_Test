//
//  NetworkService.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Moya
import Foundation

struct NetworkService: NetworkServiceProtocol {
    
    private let usersProvider = MoyaProvider<GitHub<Any>>()
    
    func fetchUsers(method: GitHub<Any>, request: RequestType, _ completion: @escaping ((Result<[User], Error>) -> Void)) {
        usersProvider.request(method) { result in
            switch result {
            case let .success(response):
                do {
                    guard request == .users else {
                        guard
                            let users = try? JSONDecoder().decode(User.self, from: response.data)
                        else { return }
                        completion(.success([users]))
                        return
                    }
                    guard
                        let users = try? JSONDecoder().decode([User].self, from: response.data)
                    else { return }
                    completion(.success(users))
                }
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }
}

enum GitHub<T> {
    case user(T)
    case users(T)
}

extension GitHub: TargetType {
    var baseURL: URL {
        guard let url = URL(string: "https://api.github.com") else { return URL(filePath: "") }
        return url
    }
    
    var path: String {
        switch self {
        case .users:
            return "/users"
        case let .user(login):
            return "/users/\(login)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .users:
            return .get
        case .user:
            return .get
        }
    }
    
    var sampleData: Data {
        Data()
    }
    
    var task: Moya.Task {
        switch self {
        case let .users(value):
            return .requestParameters(parameters: ["since": "\(value)"], encoding: URLEncoding.default)
        case .user:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
    
    
    
}

enum RequestType {
    case users
    case user
}
