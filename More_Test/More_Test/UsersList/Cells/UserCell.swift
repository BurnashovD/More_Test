//
//  UserCell.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit
import SnapKit

final class UserCell: UITableViewCell {
    // MARK: - Visual components
    
    private let userInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
        stack.alignment = .leading
        stack.distribution = .fill
        return stack
    }()

    private let usersProfilePhotoImageView: UIImageView = {
        let image = UIImageView()
        image.frame = CGRect(x: 0, y: 0, width: 50, height: 50)
        image.layer.cornerRadius = image.frame.size.width / 2
        image.layer.masksToBounds = false
        image.contentMode = .scaleAspectFill
        image.clipsToBounds = true
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    private let usersLoginLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private let usersIdLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 10)
        return label
    }()
    
    private let showMoreImageView: UIImageView = {
        let image = UIImageView()
        image.translatesAutoresizingMaskIntoConstraints = false
        image.image = UIImage(systemName: "chevron.right")
        image.tintColor = .black
        return image
    }()
    
    // MARK: - Private properties
    
    private var id = 0
    private var login = ""
    
    // MARK: - Public methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createStackViewConstraints()
        createUserImageViewConstraints()
        createShowMoreImageViewConstraints()
    }
    
    func configure(_ user: User) {
        id = user.id
        login = user.login
        usersProfilePhotoImageView.loadImage(user.prifilePhoto)
        usersLoginLabel.text = user.login
        usersIdLabel.text = "id: \(user.id)"
    }
    
    func createSelectedUser() -> User {
        let user = User(id: id, login: login, name: "", company: "", prifilePhoto: "", email: "", followers: 0, following: 0, createdDate: "")
        return user
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        contentView.backgroundColor = UIColor(named: "default")
        addSubviewsToStack()
        addSubview(showMoreImageView)
        addSubview(usersProfilePhotoImageView)
        addSubview(userInfoStackView)
    }
    
    private func addSubviewsToStack() {
        userInfoStackView.addArrangedSubview(usersLoginLabel)
        userInfoStackView.addArrangedSubview(usersIdLabel)
    }
    
    private func createStackViewConstraints() {
        userInfoStackView.snp.makeConstraints { make in
            make.top.equalTo(contentView.snp.top).offset(10)
            make.trailing.equalTo(contentView.snp.trailing)
            make.bottom.equalTo(contentView.snp.bottom)
            make.leading.equalTo(contentView.snp.leading).offset(70)
        }
    }
    
    private func createShowMoreImageViewConstraints() {
        showMoreImageView.snp.makeConstraints { make in
            make.trailing.equalTo(-10)
            make.top.equalTo(contentView.snp.top).offset(20)
            make.height.equalTo(20)
            make.width.equalTo(15)
        }
    }
    
    private func createUserImageViewConstraints() {
        usersProfilePhotoImageView.snp.makeConstraints { make in
            make.centerY.equalTo(userInfoStackView.snp.centerY)
            make.leading.equalTo(contentView.snp.leading).offset(10)
            make.width.height.equalTo(usersProfilePhotoImageView.bounds.height)
        }
    }
}
