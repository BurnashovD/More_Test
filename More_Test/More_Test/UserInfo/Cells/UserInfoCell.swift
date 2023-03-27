//
//  UserInfoCell.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit

final class UserInfoCell: UITableViewCell {
    // MARK: - Visual components
    
    private let userInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

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
        addSubviewsOnStack(user: user)
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        backgroundColor = UIColor(named: "default")
        addSubview(userInfoStackView)
    }
    
    private func addSubviewsOnStack(user: User) {
        (0 ... 2).forEach { index in
            let label = UILabel()
            label.textColor = .white
            label.text = configureLabelText(index, user: user)
            label.font = .systemFont(ofSize: index == 2 ? 15 : 25)
            label.textColor = index == 2 ? .black : .white
            userInfoStackView.addArrangedSubview(label)
        }
    }
    
    private func configureLabelText(_ index: Int, user: User) -> String {
        switch index {
        case 0:
            return "Following: \(user.following)"
        case 1:
            return "Followers: \(user.followers)"
        case 2:
            return "Account created: \(convertDateFormat(inputDate: user.createdDate))"
        default:
            break
        }
        return ""
    }
    
    private func createStackViewConstraints() {
        userInfoStackView.snp.makeConstraints { make in
            make.bottom.trailing.equalTo(contentView)
            make.top.equalTo(contentView).offset(50)
            make.leading.equalTo(contentView).offset(15)
        }
    }
    
    private func convertDateFormat(inputDate: String) -> String {
        let olDateFormatter = DateFormatter()
        olDateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
        guard let oldDate = olDateFormatter.date(from: inputDate) else { return "" }
        let convertDateFormatter = DateFormatter()
        convertDateFormatter.dateFormat = "dd MMM yyyy h:mm a"
        return convertDateFormatter.string(from: oldDate)
    }
}
