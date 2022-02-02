//
//  FavoriteMovieList.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 09.05.2021.
//

import Foundation

struct FavoriteMovies {
    static var shared = FavoriteMovies()
    
    let userDefaultsSaveKey = "SaveFavoriteMovies"

    var favoriteMovies: [Movie] = []
    
    mutating func addFavoriteMovie(movie: Movie) {
        favoriteMovies.append(movie)
        sortByTitle()
        saveFavoriteMovies()
    }
    
    mutating func deleteFavoriteMovie(movie: Movie) {
        favoriteMovies.remove(at: favoriteMovies.firstIndex(where: {$0.original_title == movie.original_title})!)
        saveFavoriteMovies()
    }
    
    func saveFavoriteMovies() {
        try? UserDefaults.standard.setObject(object: favoriteMovies, forKey: userDefaultsSaveKey)
    }
    
    mutating func restoreFavoriteMovies() {
        if let retrievedMovies = try? UserDefaults.standard.getObject(forKey: userDefaultsSaveKey, castTo: [Movie].self) {
            favoriteMovies = retrievedMovies
        }
    }
    
    mutating func sortByTitle() {
        favoriteMovies.sort { $0.original_title < $1.original_title }
    }
}
