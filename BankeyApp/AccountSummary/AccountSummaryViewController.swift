//
//  AccountSummaryViewController.swift
//  BankeyApp
//
//  Created by Олег Федоров on 12.01.2022.
//

import UIKit

class AccountSummaryViewController: UIViewController {
    
    var accounts: [AccountSummaryCellViewModel] = []
    var tableView = UITableView()
    
    lazy var logoutBarButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(
            title: "Logout",
            style: .plain,
            target: self,
            action: #selector(logoutTapped)
        )
        barButtonItem.tintColor = .label
        return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        fetchData()
    }
    
    // MARK: - Actions
    @objc private func logoutTapped() {
        NotificationCenter.default.post(name: .logout, object: nil)
    }
}

// MARK: - SetupUI
extension AccountSummaryViewController {
    private func setup() {
        setupTableView()
        setupTableHeaderView()
        setupNavigationBar()
    }
    
    private func setupTableView() {
        tableView.backgroundColor = appColor
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(AccountSummaryCell.self,
                           forCellReuseIdentifier: AccountSummaryCell.reuseID)
        tableView.rowHeight = AccountSummaryCell.rowHeight
        tableView.tableFooterView = UIView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.topAnchor
            ),
            tableView.leadingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.leadingAnchor
            ),
            tableView.trailingAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.trailingAnchor
            ),
            tableView.bottomAnchor.constraint(
                equalTo: view.safeAreaLayoutGuide.bottomAnchor
            )
        ])
    }
    
    private func setupTableHeaderView() {
        let header = AccountSummaryHeaderView(frame: .zero)
        
        var size = header.systemLayoutSizeFitting(UIView.layoutFittingCompressedSize)
        size.width = UIScreen.main.bounds.width
        header.frame.size = size
        
        tableView.tableHeaderView = header
    }
    
    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = logoutBarButtonItem
    }
}

// MARK: - UITableViewDataSource
extension AccountSummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView,
                   numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView,
                   cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard !accounts.isEmpty else { return UITableViewCell() }
        
        let cell = tableView.dequeueReusableCell(
            withIdentifier: AccountSummaryCell.reuseID,
            for: indexPath
        ) as! AccountSummaryCell
        
        let account = accounts[indexPath.row]
        cell.configure(with: account)

        return cell
    }
}

// MARK: - UITableViewDelegate
extension AccountSummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView,
                   didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

// MARK: - API
extension AccountSummaryViewController {
    private func fetchData() {
        let savings = AccountSummaryCellViewModel(
            accountType: .banking,
            accountName: "Basic Savings",
            balance: 929466.23
        )
        let chequing = AccountSummaryCellViewModel(
            accountType: .banking,
            accountName: "No-Fee All-In Chequing",
            balance: 17562.44)
        let visa = AccountSummaryCellViewModel(
            accountType: .creditCard,
            accountName: "Visa Avion Card",
            balance: 412.83
        )
        let masterCard = AccountSummaryCellViewModel(
            accountType: .creditCard,
            accountName: "Student Mastercard",
            balance: 50.83
        )
        let investment1 = AccountSummaryCellViewModel(
            accountType: .investment,
            accountName: "Tax-Free Saver",
            balance: 2000.00
        )
        let investment2 = AccountSummaryCellViewModel(
            accountType: .investment,
            accountName: "Growth Fund",
            balance: 15000.00
        )
        
        accounts.append(contentsOf: [savings, chequing,
                                     masterCard, visa,
                                     investment1, investment2])
    }
}
