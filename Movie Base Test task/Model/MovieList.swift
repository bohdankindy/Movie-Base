//
//  MovieList.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 07.05.2021.
//

import Foundation

struct MovieList {
    static var shared = MovieList()
    
    var movieList: [Movie] = []
    
    mutating func sortByTitle() {
        movieList.sort { $0.original_title < $1.original_title }
    }
}

