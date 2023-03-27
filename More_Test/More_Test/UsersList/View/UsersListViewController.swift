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
    
    // MARK: - Public properties
    
    var presenter: UsersListPresenterProtocol?
    
    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        presenter?.fetchUsers()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        title = "Users"
        configureTableView()
        usersTableView.separatorStyle = .none
        view.addSubview(usersTableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(named: "default")
    }
    
    private func configureTableView() {
        usersTableView.backgroundColor = UIColor(named: "default")
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.prefetchDataSource = self
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

/// UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let count = presenter?.users.count else { return 0 }
        return count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: "userCell", for: indexPath) as? UserCell,
            let user = presenter?.users[indexPath.row]
        else { return UITableViewCell() }
        
        cell.configure(user)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard
            let selectedCell = tableView.indexPathForSelectedRow,
            let cell = tableView.cellForRow(at: selectedCell) as? UserCell
        else { return }
        let user = cell.createSelectedUser()
        presenter?.goForward(user)
    }
    
    
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        // TODO: - Добавить insertRows по indexPath
        let current = indexPaths.map { "\($0.row)" }.joined(separator: ", ")
        guard
            let row = Int(current),
            let count = presenter?.users.count,
            row >= count - 1
        else { return }
        presenter?.fetchForwardUsers()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
}

extension UsersListViewController: UsersListViewProtocol {
    func loadUsers() {
        usersTableView.reloadData()
    }
    
    func loadForwardUsers() {
        usersTableView.reloadData()
    }
}

