//
//  AccountSummaryCell.swift
//  BankeyApp
//
//  Created by Олег Федоров on 12.01.2022.
//

import UIKit

class AccountSummaryCell: UITableViewCell {
    
    let viewModel: AccountSummaryCellViewModel? = nil
    
    let typeLabel = UILabel()
    let underlineView = UIView()
    let nameLabel = UILabel()
    
    let balanceStackView = UIStackView()
    let balanceLabel = UILabel()
    let balanceAmountLabel = UILabel()
    
    let chevronImageView = UIImageView()
    
    static let reuseID = "AccountSummaryCell"
    static let rowHeight: CGFloat = 112
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setup()
        layout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension AccountSummaryCell {
    // MARK: - SetupUI
    private func setup() {
        typeLabel.translatesAutoresizingMaskIntoConstraints = false
        typeLabel.font = UIFont.preferredFont(forTextStyle: .caption1)
        typeLabel.adjustsFontForContentSizeCategory = true
        
        underlineView.translatesAutoresizingMaskIntoConstraints = false
        underlineView.layer.cornerRadius = 2
        
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.preferredFont(forTextStyle: .body)
        nameLabel.adjustsFontForContentSizeCategory = true
        
        balanceStackView.translatesAutoresizingMaskIntoConstraints = false
        balanceStackView.axis = .vertical
        balanceStackView.spacing = 0
        
        balanceLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceLabel.font = UIFont.preferredFont(forTextStyle: .body)
        balanceLabel.textAlignment = .right
        
        balanceAmountLabel.translatesAutoresizingMaskIntoConstraints = false
        balanceAmountLabel.textAlignment = .right
        
        chevronImageView.translatesAutoresizingMaskIntoConstraints = false
        chevronImageView.image = UIImage(systemName: "chevron.right")
        chevronImageView.tintColor = appColor
    }
    
    // MARK: - Constraints
    private func layout() {
        contentView.addSubview(typeLabel)
        contentView.addSubview(underlineView)
        contentView.addSubview(nameLabel)
         
        balanceStackView.addArrangedSubview(balanceLabel)
        balanceStackView.addArrangedSubview(balanceAmountLabel)
        contentView.addSubview(balanceStackView)
        contentView.addSubview(chevronImageView)
        
        // typeLabel
        NSLayoutConstraint.activate([
            typeLabel.topAnchor.constraint(
                equalToSystemSpacingBelow: topAnchor, multiplier: 2
            ),
            typeLabel.leadingAnchor.constraint(
                equalToSystemSpacingAfter: leadingAnchor, multiplier: 2
            )
        ])
        
        // underlineView
        NSLayoutConstraint.activate([
            underlineView.topAnchor.constraint(
                equalToSystemSpacingBelow: typeLabel.bottomAnchor,
                multiplier: 1
            ),
            underlineView.leadingAnchor.constraint(
                equalTo: typeLabel.leadingAnchor
            ),
            underlineView.widthAnchor.constraint(equalToConstant: 60),
            underlineView.heightAnchor.constraint(equalToConstant: 4)
        ])
        
        // nameLabel
        NSLayoutConstraint.activate([
            nameLabel.topAnchor.constraint(
                equalToSystemSpacingBelow: underlineView.bottomAnchor,
                multiplier: 2
            ),
            nameLabel.leadingAnchor.constraint(
                equalTo: typeLabel.leadingAnchor
            )
        ])
        
        // balanceStackView
        NSLayoutConstraint.activate([
            balanceStackView.topAnchor.constraint(
                equalToSystemSpacingBelow: underlineView.bottomAnchor,
                multiplier: 0
            ),
            balanceStackView.leadingAnchor.constraint(
                equalTo: nameLabel.trailingAnchor, constant: 4
            ),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: balanceStackView.trailingAnchor,
                multiplier: 4
            )
        ])
        
        // chevronImageView
        NSLayoutConstraint.activate([
            chevronImageView.topAnchor.constraint(
                equalToSystemSpacingBelow: underlineView.bottomAnchor,
                multiplier: 1
            ),
            trailingAnchor.constraint(
                equalToSystemSpacingAfter: chevronImageView.trailingAnchor,
                multiplier: 1
            )
        ])
    }
}

extension AccountSummaryCell {
    func configure(with vm: AccountSummaryCellViewModel) {
        typeLabel.text = vm.accountType.rawValue
        nameLabel.text = vm.accountName
        balanceAmountLabel.attributedText = vm.balanceAsAttributedString
        
        switch vm.accountType {
        case .banking:
            underlineView.backgroundColor = appColor
            balanceLabel.text = "Current balance"
        case .creditCard:
            underlineView.backgroundColor = .systemOrange
            balanceLabel.text = "Current balance"
        case .investment:
            underlineView.backgroundColor = .systemPurple
            balanceLabel.text = "Value "
        }
    }
}
