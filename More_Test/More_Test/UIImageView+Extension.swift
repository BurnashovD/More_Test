//
//  UIImageView+Extension.swift
//  More_Test
//
//  Created by Daniil on 28.03.2023.
//

import UIKit

/// Расширение для загрузки изображений
extension UIImageView {
    func loadImage(_ url: String) {
        let imageService = ImageService()
        imageService.fetchImage(url) { result in
            switch result {
            case let .success(data):
                self.image = UIImage(data: data)
            case let .failure(error):
                print(error.localizedDescription)
            }
        }
    }
}
