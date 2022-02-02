//
//  FavoriteMoviesViewController.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 09.05.2021.
//

import UIKit

class FavoriteMoviesViewController: UIViewController {

    //MARK: - Constants

    let imageBase = "https://image.tmdb.org/t/p/w500"
    let detailViewControllerID = "detailViewControllerID"
    
    let itemsPerRow = 2
    let margin: CGFloat = 10
    
    //MARK: - Outlets

    @IBOutlet weak var collectionView: UICollectionView!
    
    //MARK: - UIViewController LifeCycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        collectionView.reloadData()
    }
}

//MARK: - UICollectionViewDelegate

extension FavoriteMoviesViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let detailVC = storyboard?.instantiateViewController(withIdentifier: detailViewControllerID) as! DetailViewController
        let movie = FavoriteMovies.shared.favoriteMovies[indexPath.row]
            
        detailVC.movie = movie
        detailVC.delegate = self
        navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

//MARK: - UICollectionViewDataSource

extension FavoriteMoviesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return FavoriteMovies.shared.favoriteMovies.count
    }
    
    func collectionView(_ collectionView: UICollectionView,
                        cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let item = FavoriteMovies.shared.favoriteMovies[indexPath.item]
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Info Cell", for: indexPath) as! InfoCell
        
        cell.movieNameLabel.text = item.original_title
        
        let imageURL = URL(string: imageBase + item.poster_path)!
        let imageData = try? Data(contentsOf: imageURL)
        cell.posterImageView.image = UIImage(data: imageData!)
        
        return cell
    }
}

//MARK: - UICollectionViewDelegateFlowLayout

extension FavoriteMoviesViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (UIScreen.main.bounds.width - CGFloat(itemsPerRow + 1) * margin) / CGFloat(itemsPerRow)
        
        return CGSize(width: width , height: width)
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

extension FavoriteMoviesViewController: DetailViewControllerDelegate {
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
