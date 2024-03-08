//
//  MovieDetailViewController.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import UIKit
import YouTubePlayer
import UIScrollView_InfiniteScroll

class MovieDetailViewController: UIViewController, MovieDetailViewProtocol {
    var presenter: (any MovieDetailPresenterProtocol)?
    
    
    @IBOutlet weak var youtubeView: UIView!
    @IBOutlet weak var movieRating: UILabel!
    @IBOutlet weak var movieDescription: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var tableViewContainer: UIView!
    
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
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UserReviewTableViewCell.nib(), forCellReuseIdentifier: UserReviewTableViewCell.identifier)
        table.isHidden = true
        return table
    }()
    
    private let userReviewLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    private var spinner: UIActivityIndicatorView = {
        let sp = UIActivityIndicatorView()
        sp.translatesAutoresizingMaskIntoConstraints = false
        sp.startAnimating()
        sp.hidesWhenStopped = true
        return sp
    }()
    
    private var spinnerYoutube: UIActivityIndicatorView = {
        let sp = UIActivityIndicatorView()
        sp.translatesAutoresizingMaskIntoConstraints = false
        sp.startAnimating()
        sp.hidesWhenStopped = true
        return sp
    }()
    
    private var spinnerUserReview: UIActivityIndicatorView = {
        let sp = UIActivityIndicatorView()
        sp.translatesAutoresizingMaskIntoConstraints = false
        sp.startAnimating()
        sp.hidesWhenStopped = true
        return sp
    }()
    
    private var userReviews: [UserReviewsModel] = []
    
    override func viewWillAppear(_ animated: Bool) {
        youtubeView.isHidden = true
        movieRating.isHidden = true
        movieDescription.isHidden = true
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(youtubeErrorLabel)
        view.addSubview(userReviewLabel)
        view.addSubview(spinner)
        view.addSubview(spinnerYoutube)
        view.addSubview(spinnerUserReview)
        view.addSubview(youtubePlayer)
        view.addSubview(tableView)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        spinnerYoutube.centerXAnchor.constraint(equalTo: youtubeView.centerXAnchor).isActive = true
        spinnerYoutube.centerYAnchor.constraint(equalTo: youtubeView.centerYAnchor).isActive = true
        
        spinnerUserReview.centerXAnchor.constraint(equalTo: tableViewContainer.centerXAnchor).isActive = true
        spinnerUserReview.centerYAnchor.constraint(equalTo: tableViewContainer.centerYAnchor).isActive = true
        
        self.label.sizeToFit()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        youtubePlayer.frame = youtubeView.bounds
        youtubePlayer.center = youtubeView.center
        
        label.frame = view.bounds
        label.center = view.center
        
        youtubeErrorLabel.frame = youtubeView.bounds
        youtubeErrorLabel.center = youtubeView.center
        
        tableView.frame = tableViewContainer.bounds
        tableView.center = tableViewContainer.center
        
        userReviewLabel.frame = tableViewContainer.bounds
        userReviewLabel.center = tableViewContainer.center
    }
    
    func updateYoutubePlayer(with movieVideos: MovieVideosModel) {
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
    
    func update(with movieListResponse: MovieDetailModel) {
        DispatchQueue.main.async { [weak self] in
            if let voteAverage = movieListResponse.voteAverage {
                self?.movieRating.text = "⭐️ \(voteAverage.rounded(toPlaces: 2)) / 10.0"
            } else {
                self?.movieRating.text = "No Rating Value"
            }
            
            if let releaseDate = movieListResponse.releaseDate {
                self?.releaseDateLabel.text = "Release Date: \(releaseDate.toFormattedDate())"
            } else {
                self?.releaseDateLabel.text = "Release Date: -"
            }
            
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
    
    func updateUserReview(with userReviews: [UserReviewsModel], isPagination: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isPagination {
                self?.userReviews.append(contentsOf: userReviews)
                self?.tableView.finishInfiniteScroll()
                if let isPaginationAvailable = self?.presenter?.isPaginationAvailable, !isPaginationAvailable {
                    self?.tableView.removeInfiniteScroll()
                }
            } else {
                self?.userReviews = userReviews
                if let isPaginationAvailable = self?.presenter?.isPaginationAvailable, isPaginationAvailable {
                    self?.tableView.addInfiniteScroll(handler: { table in
                        self?.presenter?.loadMoreUserReviews()
                    })
                }
            }
            if userReviews.count == 0 {
                self?.userReviewLabel.text = "No Review Available"
                self?.userReviewLabel.isHidden = false
                self?.tableView.isHidden = true
            } else {
                self?.tableView.reloadData()
                self?.tableView.isHidden = false
            }
            self?.spinnerUserReview.stopAnimating()
        }
    }
    
    func updateUserReview(with error: any Error, isPagination: Bool) {
        DispatchQueue.main.async { [weak self] in
            self?.userReviewLabel.text = error.localizedDescription
            self?.userReviewLabel.isHidden = false
            self?.tableView.isHidden = true
            self?.spinnerUserReview.stopAnimating()
        }
    }
}

extension MovieDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userReviews.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: UserReviewTableViewCell.identifier, for: indexPath) as? UserReviewTableViewCell else { return UITableViewCell() }
        cell.config(userReviews[indexPath.row])
        return cell
    }
    
    
}
