//
//  MovieGenreModel.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import Foundation

struct MovieGenreResponse: Codable {
    let genres: [MovieGenreModel]
}

struct MovieGenreModel: Codable {
    let id: Int
    let name: String
}
