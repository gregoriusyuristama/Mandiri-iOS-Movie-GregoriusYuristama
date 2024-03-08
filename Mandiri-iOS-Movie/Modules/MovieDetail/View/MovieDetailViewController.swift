//
//  MovieDetailViewController.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import UIKit
import YouTubePlayer

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    var presenter: (any MovieDetailPresenterProtocol)?
    private var spinner = UIActivityIndicatorView()
    private var spinnerYoutube = UIActivityIndicatorView()
    
    @IBOutlet weak var youtubeView: UIView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    
    private var youtubePlayer: YouTubePlayerView = {
        let ytPlayer = YouTubePlayerView()
        ytPlayer.isHidden = true
        return ytPlayer
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private let youtubeErrorLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    func update(with movieListResponse: MovieDetailModel) {
        DispatchQueue.main.async { [weak self] in
            self?.movieRating.text = movieListResponse.voteAverage?.description
            self?.movieDescription.text = movieListResponse.overview
            self?.movieRating.isHidden = false
            self?.movieDescription.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    func update(with error: any Error) {
        DispatchQueue.main.async { [weak self] in
            self?.label.text = error.localizedDescription
            self?.label.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        youtubeView.isHidden = true
        movieRating.isHidden = true
        movieDescription.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(youtubeErrorLabel)
        view.addSubview(spinner)
        view.addSubview(spinnerYoutube)
        view.addSubview(youtubePlayer)
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        spinnerYoutube.translatesAutoresizingMaskIntoConstraints = false
        spinnerYoutube.startAnimating()
        spinnerYoutube.hidesWhenStopped = true
        
        spinnerYoutube.centerXAnchor.constraint(equalTo: youtubeView.centerXAnchor).isActive = true
        spinnerYoutube.centerYAnchor.constraint(equalTo: youtubeView.centerYAnchor).isActive = true
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        youtubePlayer.frame = youtubeView.bounds
        youtubePlayer.center = youtubeView.center
        label.frame = view.bounds
        label.center = view.center
        youtubeErrorLabel.frame = youtubeView.bounds
        youtubeErrorLabel.center = youtubeView.center
    }
    
    func updateYoutubePlayer(with movieVideos: MovieVideosModel) {
        print(movieVideos)
        DispatchQueue.main.async { [weak self] in
            guard let videoId = movieVideos.key, let url = URL(string: "\(YoutubeAPIConstant.watchYoutubeVideoFromID)\(videoId)") else {
                self?.updateYoutubePlayer(with: YoutubeError.invalidId)
                return
            }
            self?.youtubePlayer.loadVideoURL(url)
            self?.youtubeView.isHidden = false
            self?.youtubePlayer.isHidden = false
        }
    }
    
    func updateYoutubePlayer(with error: any Error) {
        DispatchQueue.main.async { [weak self] in
            self?.youtubeErrorLabel.text = "Cannot Play Trailer: \(error.localizedDescription)"
            self?.youtubeErrorLabel.isHidden = false
            self?.spinnerYoutube.stopAnimating()
            debugPrint(error.localizedDescription)
        }
    }
}
