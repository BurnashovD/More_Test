//
//  UsersListViewController.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit
import SnapKit

final class UsersListViewController: UIViewController {
    // MARK: - Visual components
    
    private let usersTableView: UITableView = {
        let table = UITableView()
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Private properties
    
    private let users: [User] = [.init(id: 1, login: "@Loh", name: "Daniil Burnashov", company: "Apple", prifilePhoto: "", email: "aaa@mail.ru", followers: 2, following: 4, createdDate: "2014-06-30T22:41:56Z")]
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        title = "Users"
        configureTableView()
        usersTableView.separatorStyle = .none
        view.addSubview(usersTableView)
    }
    
    private func configureTableView() {
        usersTableView.backgroundColor = UIColor(named: "default")
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.register(UserCell.self, forCellReuseIdentifier: "userCell")
    }
    
    private func setupLayout() {
        createTableViewConstraints()
    }
    
    private func createTableViewConstraints() {
        usersTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
}

extension UsersListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        50
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell
        else { return UITableViewCell() }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

