//
//  YoutubeError.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

enum YoutubeError: Error {
    case invalidId
}

extension YoutubeError: LocalizedError {
    public var errorDescription: String? {
        switch self {
        case .invalidId:
            return NSLocalizedString(
                "Invalid Video ID",
                comment: "Invalid Video ID"
            )
        }
    }
}
