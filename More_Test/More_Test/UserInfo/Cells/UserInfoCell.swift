//
//  UserInfoCell.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit

/// Ячейка с информацией о пользователе
final class UserInfoCell: UITableViewCell {
    // MARK: - Visual components
    
    private let userInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()
    
    private let followingLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let followersLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25)
        return label
    }()
    
    private let createdDateLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    // MARK: - Private properties
    
    private var index = 0

    // MARK: - Public methods
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        configureUI()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        createStackViewConstraints()
    }
    
    func configure(_ user: User) {
        followersLabel.text = "Followers: \(user.followers)"
        followingLabel.text = "Following: \(user.following)"
        createdDateLabel.text = "Account created: \(convertDateFormat(inputDate: user.createdDate))"
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        addSubviewsOnStack()
        backgroundColor = UIColor(named: "default")
        addSubview(userInfoStackView)
    }
    
    private func addSubviewsOnStack() {
        userInfoStackView.addArrangedSubview(followersLabel)
        userInfoStackView.addArrangedSubview(followingLabel)
        userInfoStackView.addArrangedSubview(createdDateLabel)
    }
    
    private func createStackViewConstraints() {
        userInfoStackView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(contentView)
            make.top.equalTo(contentView).offset(50)
            make.leading.equalTo(contentView).offset(15)
        }
    }
    
    private func convertDateFormat(inputDate: String) -> String {
        guard !inputDate.isEmpty else { return "" }
        var value = inputDate
        value.removeLast()
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let oldDate = olDateFormatter.date(from: value) else { return "" }
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM yyyy h:mm:a"
        return convertDateFormatter.string(from: oldDate)
    }
}
