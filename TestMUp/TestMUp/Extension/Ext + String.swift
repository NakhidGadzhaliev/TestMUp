//
//  Ext + String.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 28.04.2023.
//

import Foundation

extension String {
    func localized() -> String {
        return NSLocalizedString(
            self,
            tableName: "Localizable",
            bundle: .main,
            value: self,
            comment: self
        )
    }
}
