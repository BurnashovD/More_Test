//
//  ImageService.swift
//  More_Test
//
//  Created by Daniil on 28.03.2023.
//

import Foundation

struct ImageService: ImageServiceProtocol {
        
    func fetchImage(_ url: String, _ completion: @escaping ((Result<Data, Error>) -> Void)) {
        guard let url = URL(string: url) else { return }
        URLSession.shared.dataTask(with: url) { data, _, error in
            guard let data = data else {
                guard let error = error else { return }
                completion(.failure(error))
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }.resume()
    }
}

