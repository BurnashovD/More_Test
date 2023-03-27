//
//  PersonalInfoCell.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit
import SnapKit

final class PersonalInfoCell: UITableViewCell {
    // MARK: - Visual components
    
    private let userNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 25, weight: .medium)
        return label
    }()
    
    private let emailLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = .systemFont(ofSize: 15)
        return label
    }()
    
    private let companyNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = .systemFont(ofSize: 17)
        return label
    }()
    
    private let personalInfoStackView: UIStackView = {
        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        stack.axis = .vertical
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
        userNameLabel.text = user.name == "" ? "no name" : user.name
        emailLabel.text = user.email == "" ? "no email" : user.email
        companyNameLabel.text = user.company == "" ? "no company" : "Company: \(user.company)"
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        backgroundColor = UIColor(named: "default")
        addSubviewsOnStack()
        addSubview(personalInfoStackView)
    }
    
    private func addSubviewsOnStack() {
        personalInfoStackView.addArrangedSubview(userNameLabel)
        personalInfoStackView.addArrangedSubview(emailLabel)
        personalInfoStackView.addArrangedSubview(companyNameLabel)
    }
    
    private func createStackViewConstraints() {
        personalInfoStackView.snp.makeConstraints { make in
            make.top.bottom.trailing.equalTo(contentView)
            make.leading.equalTo(contentView).offset(15)
        }
    }
}
