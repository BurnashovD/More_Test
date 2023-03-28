//
//  UserInfoViewController.swift
//  More_Test
//
//  Created by Daniil on 27.03.2023.
//

import UIKit
import SnapKit

/// Экран с информацией о выбранном пользователе
final class UserInfoViewController: UIViewController {
    // MARK: - Visual components
    
    private let userInfoTableView: UITableView = {
        let table = UITableView()
        table.separatorStyle = .none
        table.allowsSelection = false
        table.translatesAutoresizingMaskIntoConstraints = false
        return table
    }()
    
    // MARK: - Public properties
    
    var presenter: UserInfoPresenterProtocol?
    
    // MARK: - Private properties
    
    private let cellTypes: [CellTypes] = [.photo, .personal, .info]

    // MARK: - Public methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        setupLayout()
        presenter?.fetchInfo()
    }
    
    // MARK: - Private methods
    
    private func configureUI() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationController?.navigationBar.tintColor = .black
        configureTableView()
        view.addSubview(userInfoTableView)
    }
    
    private func configureTableView() {
        userInfoTableView.backgroundColor = UIColor(named: Constants.defaultColorName)
        userInfoTableView.delegate = self
        userInfoTableView.dataSource = self
        userInfoTableView.register(ProfilePhotoCell.self, forCellReuseIdentifier: Constants.photoCellIdentifier)
        userInfoTableView.register(PersonalInfoCell.self, forCellReuseIdentifier: Constants.personalInfoCellIdentifier)
        userInfoTableView.register(UserInfoCell.self, forCellReuseIdentifier: Constants.infoCellIdentifier)
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

/// Реализация протокола вью
extension UserInfoViewController: UserInfoViewProtocol {
    func loadUserInfo() {
        userInfoTableView.reloadData()
    }
}

/// UITableViewDelegate, UITableViewDataSource
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
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.photoCellIdentifier, for: indexPath) as? ProfilePhotoCell,
                let user = presenter?.user
            else { return UITableViewCell() }
            cell.configure(user: user)
            return cell
            
        case .personal:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.personalInfoCellIdentifier, for: indexPath) as? PersonalInfoCell,
                let user = presenter?.user
            else { return UITableViewCell() }
            cell.configure(user)
            return cell
            
        case .info:
            guard
                let cell = tableView.dequeueReusableCell(withIdentifier: Constants.infoCellIdentifier, for: indexPath) as? UserInfoCell,
                let user = presenter?.user
            else { return UITableViewCell() }
            cell.configure(user)
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let type = cellTypes[indexPath.section]
        switch type {
        case .photo:
            return Constants.photoCellHeight
        case .personal:
            return Constants.personalCellHeight
        case .info:
            return Constants.infoCellHeight
        }
    }
}

/// Константы и типы ячеек
private extension UserInfoViewController {
    enum Constants {
        static let infoCellIdentifier = "infoCell"
        static let personalInfoCellIdentifier = "personalCell"
        static let photoCellIdentifier = "photoCell"
        static let defaultColorName = "default"
        static let photoCellHeight: CGFloat = 200
        static let personalCellHeight: CGFloat = 70
        static let infoCellHeight: CGFloat = 140
    }
    
    enum CellTypes {
        case photo
        case personal
        case info
    }
}
