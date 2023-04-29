//
//  Ext + DateFormatter.swift
//  TestMUp
//
//  Created by Нахид Гаджалиев on 27.04.2023.
//

import Foundation

extension DateFormatter {
    static let titleDateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd MMMM YYYY"
        let currentLocale = Locale.current.identifier
        dateFormatter.locale = Locale(identifier: currentLocale)
        return dateFormatter
    }()
}
