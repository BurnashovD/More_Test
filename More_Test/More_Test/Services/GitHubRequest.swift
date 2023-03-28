//
//  GitHubRequest.swift
//  More_Test
//
//  Created by Daniil on 28.03.2023.
//

import Moya
import Foundation

/// Типы запросов
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
            return .requestParameters(parameters: ["since": "\(value)", "per_page": 60], encoding: URLEncoding.default)
        case .user:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return ["Content-Type": "application/json"]
    }
}
