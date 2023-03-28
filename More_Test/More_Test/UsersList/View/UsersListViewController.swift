//
//  UsersListViewController.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit
import SnapKit
import PromiseKit

/// Список пользователей GitHub
final class UsersListViewController: UIViewController {
    // MARK: - Visual components
    
    private let usersTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    private let listRefreshControl: UIRefreshControl = {
        let control = UIRefreshControl()
        control.tintColor = .black
        return control
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
        title = Constants.navigationTitle
        configureTableView()
        view.addSubview(usersTableView)
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.barTintColor = UIColor(named: Constants.defaultColorName)
        listRefreshControl.addTarget(self, action: #selector(refreshListAction), for: .valueChanged)
    }
    
    private func configureTableView() {
        usersTableView.addSubview(listRefreshControl)
        usersTableView.backgroundColor = UIColor(named: Constants.defaultColorName)
        usersTableView.delegate = self
        usersTableView.dataSource = self
        usersTableView.prefetchDataSource = self
        usersTableView.register(UserCell.self, forCellReuseIdentifier: Constants.userCellIdentifier)
    }
    
    private func setupLayout() {
        createTableViewConstraints()
    }
    
    private func createTableViewConstraints() {
        usersTableView.snp.makeConstraints { make in
            make.top.leading.bottom.trailing.equalToSuperview()
        }
    }
    
    @objc private func refreshListAction() {
        presenter?.refreshList()
    }
}

/// Реализация протокола вью
extension UsersListViewController: UsersListViewProtocol {
    func loadUsers() {
        usersTableView.reloadData()
    }
    
    func loadForwardUsers(_ sections: [Int]) {
        self.usersTableView.insertSections(IndexSet(sections), with: .automatic)
    }
    
    func refreshList() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.listRefreshControl.endRefreshing()
        }
        usersTableView.reloadData()
    }
}

/// UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching
extension UsersListViewController: UITableViewDelegate, UITableViewDataSource, UITableViewDataSourcePrefetching {
    func numberOfSections(in tableView: UITableView) -> Int {
        guard let count = presenter?.users.count else { return 0 }
        return count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard
            let cell = tableView.dequeueReusableCell(withIdentifier: Constants.userCellIdentifier, for: indexPath) as? UserCell,
            let user = presenter?.users[indexPath.section]
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
        let current = indexPaths.map(\.section).max()
        guard
            let current = current,
            let count = presenter?.users.count,
            Int(current) > count - Constants.cellTillTableEnd
        else { return }
        presenter?.fetchForwardUsers()
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        Constants.cellHeight
    }
}

/// Константы
private extension UsersListViewController {
    enum Constants {
        static let userCellIdentifier = "userCell"
        static let defaultColorName = "default"
        static let navigationTitle = "GitHub"
        static let cellHeight: CGFloat = 60
        static let cellTillTableEnd = 10
    }
}

