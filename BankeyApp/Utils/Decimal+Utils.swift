//
//  DecimalUtils.swift
//  BankeyApp
//
//  Created by Олег Федоров on 14.01.2022.
//

import Foundation

extension Decimal {
    var doubleValue: Double {
        return NSDecimalNumber(decimal: self).doubleValue
    }
}
