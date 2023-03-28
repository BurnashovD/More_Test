//
//  ProfilePhotoCell.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit
import SnapKit

/// Ячейка с фото пользователя
final class ProfilePhotoCell: UITableViewCell {
    // MARK: - Visual components
    
    private let usersPhotoImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        image.clipsToBounds = true
        image.layer.cornerRadius = image.bounds.width / 2
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    // MARK: - Public methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createImageViewConstraint()
    }
    
    func configure(user: User) {
        usersPhotoImageView.loadImage(user.prifilePhoto)
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        backgroundColor = UIColor(named: Constants.defaultColorName)
        addSubview(usersPhotoImageView)
    }
    
    private func createImageViewConstraint() {
        usersPhotoImageView.snp.makeConstraints { make in
            make.top.bottom.equalTo(contentView)
            make.leading.equalTo(contentView).offset(10)
            make.width.height.equalTo(200)
        }
    }
}

/// Константы
private extension ProfilePhotoCell {
    enum Constants {
        static let defaultColorName = "default"
    }
}
