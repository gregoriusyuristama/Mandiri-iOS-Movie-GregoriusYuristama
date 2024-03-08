//
//  MovieListTableViewCell.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "MovieListCollectionViewCell"
    
    @IBOutlet weak var movieTitle: UILabel!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var moviePoster: UIImageView!
    
    static func nib() -> UINib {
        .init(nibName: identifier, bundle: nil)
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func config(_ movieList: MovieListModel) {
        
        if let title = movieList.title {
            movieTitle.text = title
        } else {
            movieTitle.text = "No Title Found"
        }
        
        if let voteAverage = movieList.voteAverage {
            movieRating.text = "⭐️ \(voteAverage.rounded(toPlaces: 2)) / 10.0"
        } else {
            movieRating.text = "No Rating Found"
        }
        
        let placeholderImage = UIImage(systemName: "photo")?.withTintColor(.gray, renderingMode: .alwaysOriginal)
        
        guard let moviePosterPath = movieList.posterPath else { return }
        
        moviePoster.sd_imageIndicator = SDWebImageActivityIndicator.grayLarge
        moviePoster.sd_imageIndicator?.startAnimatingIndicator()
        
        moviePoster.sd_setImage(
            with: URL(string: "https://image.tmdb.org/t/p/w500\(moviePosterPath)"),
            placeholderImage: placeholderImage) { [weak self] image, _, _, _ in
                self?.moviePoster.image = image?.roundedCornerImage(with: 40)
                self?.moviePoster.sd_imageIndicator?.stopAnimatingIndicator()
            }
        
    }
    
}
