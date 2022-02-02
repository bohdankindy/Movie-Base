//
//  Movie Info.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 07.05.2021.
//

import Foundation

struct Movie: Codable, Equatable {
    var original_title: String
    var original_language: String
    var overview: String
    var poster_path: String
    var release_date: String
    var isFavorite: Bool?       
}
