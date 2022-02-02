//
//  ViewController.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 07.05.2021.
//

import UIKit

class MoviesViewController: UIViewController {
    
    //MARK: - Constants
    
    let urlStrBase = "https://api.themoviedb.org/3/movie/"
    let urStrKey = "?api_key=e95a8351f9432f3be0e4b11614f8b162"
    let imageBase = "https://image.tmdb.org/t/p/w500"
    
    let firstMovieNumber = 1
//  lastMovieNumber has an impact on final amount of loaded movies
    let lastMovieNumber = 500
    
    let detailViewControllerID = "detailViewControllerID"
    
    let itemsPerRow = 2
    let margin: CGFloat = 10
    
    //MARK: - Properties
    
    let decoder = JSONDecoder()
    
    //MARK: - Outlets
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadData()
    }
}

//MARK: - Networking

extension MoviesViewController {
    func loadData() {
        let dispatchGroup = DispatchGroup()
        for i in firstMovieNumber...lastMovieNumber {
            dispatchGroup.enter()
            
            let urlStr = urlStrBase + "\(i)" + urStrKey
            
            let url = URL(string: urlStr)!
            
            let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                
                if let data = data,
                   var movie = try? self.decoder.decode(Movie.self, from: data) {
                    movie.isFavorite = false
                    MovieList.shared.movieList.append(movie)
                }
                dispatchGroup.leave()
            }
            task.resume()
        }
        dispatchGroup.notify(queue: .main) {
            MovieList.shared.sortByTitle()
            for favoriteMovie in FavoriteMovies.shared.favoriteMovies {
                var temp = favoriteMovie
                temp.isFavorite = false
                self.updateMovieFavoriteStateToTrue(movie: temp)
            }
            self.collectionView.reloadData()
        }
    }
}

//MARK: - UICollectionViewDelegate

extension MoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: detailViewControllerID) as! DetailViewController
        let movie = MovieList.shared.movieList[indexPath.row]
        
        detailVC.movie = movie
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK: - UICollectionViewDataSource

extension MoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MovieList.shared.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = MovieList.shared.movieList[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Info Cell", for: indexPath) as! InfoCell
        
        cell.movieNameLabel.text = item.original_title
        
        let imageURL = URL(string: imageBase + item.poster_path)!
        let imageData = try? Data(contentsOf: imageURL)
        cell.posterImageView.image = UIImage(data: imageData!)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension MoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - CGFloat(itemsPerRow + 1) * margin) / CGFloat(itemsPerRow)
        
        return CGSize(width: width, height: width)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        insetForSectionAt section: Int) -> UIEdgeInsets {
        
        return UIEdgeInsets(top: margin, left: margin, bottom: margin, right: margin)
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return margin
    }
}

//MARK: - DetailViewControllerDelegate

extension MoviesViewController: DetailViewControllerDelegate {
    func updateMovieFavoriteStateToTrue(movie: Movie) {
        if let index = MovieList.shared.movieList.firstIndex(of: movie) {
            MovieList.shared.movieList[index].isFavorite = true
        }
    }
    
    func updateMovieFavoriteStateToFalse(movie: Movie) {
        if let index = MovieList.shared.movieList.firstIndex(of: movie) {
            MovieList.shared.movieList[index].isFavorite = false
        }
    }
}
