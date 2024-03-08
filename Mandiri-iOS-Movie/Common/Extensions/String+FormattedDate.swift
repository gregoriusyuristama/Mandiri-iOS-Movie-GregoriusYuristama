//
//  String+FormattedDAte.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

extension String {
  func toFormattedDate() -> String {
    let inputFormatter = DateFormatter()
    inputFormatter.dateFormat = "yyyy-MM-dd"
    guard let date = inputFormatter.date(from: self) else { return "Failed Date Parsing" }

    let outputFormatter = DateFormatter()
    outputFormatter.dateFormat = "dd MMMM yyyy"
    return outputFormatter.string(from: date)
  }
}
