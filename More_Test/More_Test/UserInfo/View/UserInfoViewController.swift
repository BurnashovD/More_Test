//
//  UserInfoViewController.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit
import SnapKit

final class UserInfoViewController: UIViewController {
    // MARK: - Visual components
    
    private let userInfoTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    var presenter: UserInfoPresenterProtocol?
    
    // MARK: - Private properties
    
    private let cellTypes: [CellTypes] = [.photo, .personal, .info]
    private let users: [User] = [.init(id: 1, login: "@Loh", name: "Daniil Burnashov", company: "Apple", prifilePhoto: "", email: "aaa@mail.ru", followers: 2, following: 4, createdDate: "2014-06-30T22:41:56")]

    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        configureTableView()
        view.addSubview(userInfoTableView)
    }
    
    private func configureTableView() {
        userInfoTableView.backgroundColor = UIColor(named: "default")
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
        userInfoTableView.register(ProfilePhotoCell.self, forCellReuseIdentifier: "photoCell")
        userInfoTableView.register(PersonalInfoCell.self, forCellReuseIdentifier: "personalCell")
        userInfoTableView.register(UserInfoCell.self, forCellReuseIdentifier: "infoCell")
    }

    
    private func setupLayout() {
        createTableViewConstraints()
    }
    
    private func createTableViewConstraints() {
        userInfoTableView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
    }
    
}

extension UserInfoViewController: UITableViewDelegate, UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        cellTypes.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let type = cellTypes[indexPath.section]
        switch type {
        case .photo:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "photoCell", for: indexPath) as? ProfilePhotoCell
            else { return UITableViewCell() }
            return cell
            
        case .personal:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "personalCell", for: indexPath) as? PersonalInfoCell
            else { return UITableViewCell() }
            return cell
            
        case .info:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell", for: indexPath) as? UserInfoCell
            else { return UITableViewCell() }
            cell.configure(users[indexPath.row])
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = cellTypes[indexPath.section]
        switch type {
        case .photo:
            return 200
        case .personal:
            return 70
        case .info:
            return 120
        }
    }
}

extension UserInfoViewController: UserInfoViewProtocol {
    
}

private extension UserInfoViewController {
    enum CellTypes {
        case photo
        case personal
        case info
    }
}
