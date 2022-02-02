//
//  DetailViewController.swift
//  Movie Base Test task
//
//  Created by Bohdan Kindy on 09.05.2021.
//

import UIKit

//MARK: - DetailViewControllerDelegate

protocol DetailViewControllerDelegate {
    func updateMovieFavoriteStateToTrue(movie: Movie)
    func updateMovieFavoriteStateToFalse(movie: Movie)
}

class DetailViewController: UIViewController {
    
    //MARK: - Constants

    let imageBase = "https://image.tmdb.org/t/p/w500"
    
    //MARK: - Properties

    var movie: Movie?
    var delegate: DetailViewControllerDelegate?
    
    //MARK: - Outlets

    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var movieTitleLabel: UILabel!
    @IBOutlet weak var movieLanguageLabel: UILabel!
    @IBOutlet weak var movieOverviewLabel: UILabel!
    @IBOutlet weak var releaseYearLabel: UILabel!
    @IBOutlet weak var addFavoriteButton: UIButton!
    
    
//MARK: - UIViewController Lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
//MARK: - Actions
    
    @IBAction func backButtonPressed(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func addFavoritePressed(_ sender: UIButton) {
        sender.isSelected.toggle()
        guard movie != nil else {return}
        if sender.isSelected {
            delegate?.updateMovieFavoriteStateToTrue(movie: movie!)
            movie?.isFavorite = true
            FavoriteMovies.shared.addFavoriteMovie(movie: movie!)
        } else {
            delegate?.updateMovieFavoriteStateToFalse(movie: movie!)
            movie?.isFavorite = false
            FavoriteMovies.shared.deleteFavoriteMovie(movie: movie!)
        }
    }
}

//MARK: - UI Settings

extension DetailViewController {
    func setupUI() {
        guard let movie = movie else { return }
        
        addFavoriteButton.isSelected = movie.isFavorite!
        movieTitleLabel.text = movie.original_title
        movieLanguageLabel.text = "Language: " + movie.original_language
        movieOverviewLabel.text = movie.overview
        
        var releaseYearText = movie.release_date
        
        let range = releaseYearText.index(releaseYearText.startIndex, offsetBy: 4)..<releaseYearText.endIndex
        releaseYearText.removeSubrange(range)
        releaseYearLabel.text = "Release Year: " + releaseYearText
        
        let imageURL = URL(string: imageBase + movie.poster_path)!
        let imageData = try? Data(contentsOf: imageURL)
        posterImageView.image = UIImage(data: imageData!)
    }
}
