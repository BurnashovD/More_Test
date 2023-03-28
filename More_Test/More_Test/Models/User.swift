//
//  User.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import Foundation

/// Пользователь
struct User: Decodable {
    /// Идентификатор
    let id: Int
    /// Логин
    let login: String
    /// Имя
    let name: String
    /// Компания
    let company: String
    /// Фото профиля
    let prifilePhoto: String
    /// Почта
    let email: String
    /// Подписчики
    let followers: Int
    /// Подписки
    let following: Int
    /// Дата создания аккаунта
    let createdDate: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case login
        case name
        case company
        case prifilePhoto = "avatar_url"
        case email
        case followers
        case following
        case createdDate = "created_at"
    }
    
    init(id: Int, login: String, name: String, company: String, prifilePhoto: String, email: String, followers: Int, following: Int, createdDate: String) {
        self.id = id
        self.login = login
        self.name = name
        self.company = company
        self.prifilePhoto = prifilePhoto
        self.email = email
        self.followers = followers
        self.following = following
        self.createdDate = createdDate
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.id = try container.decodeIfPresent(Int.self, forKey: .id) ?? 0
        self.login = try container.decodeIfPresent(String.self, forKey: .login) ?? ""
        self.name = try container.decodeIfPresent(String.self, forKey: .name) ?? ""
        self.company = try container.decodeIfPresent(String.self, forKey: .company) ?? ""
        self.prifilePhoto = try container.decodeIfPresent(String.self, forKey: .prifilePhoto) ?? ""
        self.email = try container.decodeIfPresent(String.self, forKey: .email) ?? ""
        self.followers = try container.decodeIfPresent(Int.self, forKey: .followers) ?? 0
        self.following = try container.decodeIfPresent(Int.self, forKey: .following) ?? 0
        self.createdDate = try container.decodeIfPresent(String.self, forKey: .createdDate) ?? ""
    }
}

