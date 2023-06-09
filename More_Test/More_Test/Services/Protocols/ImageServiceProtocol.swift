//
//  ImageServiceProtocol.swift
//  More_Test
//
//  Created by Daniil on 28.03.2023.
//

import Foundation

/// Протокол сервиса изображений
protocol ImageServiceProtocol {
    func fetchImage(_ url: String, _ completion: @escaping ((Result<Data, Error>) -> Void))
}
