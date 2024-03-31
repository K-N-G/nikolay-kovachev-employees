//
//  DateFormat.swift
//  NikolayKovachevEmployees
//
//  Created by KNG on 31.03.24.
//

import Foundation

enum DateFormat: String {
    case standard = "yyyy-MM-dd"
    case dayFirst = "dd-MM-yyyy"
    case monthFirst = "MM-dd-yyyy"
    case shortYear = "yy-MM-dd"
    case slashDayFirst = "dd/MM/yyyy"
    case slashMonthFirst = "MM/dd/yyyy"
    case slashYearFirst = "yyyy/MM/dd"
    case withTime = "yyyy/MM/dd HH:mm:ss"
    case withTimeAndDayFirst = "dd-MM-yyyy HH:mm:ss"
    
    static var allFormats: [DateFormat] {
        return [.standard, .dayFirst, .monthFirst, .shortYear, .slashDayFirst, .slashMonthFirst, .slashYearFirst, .withTime, .withTimeAndDayFirst]
    }
}
