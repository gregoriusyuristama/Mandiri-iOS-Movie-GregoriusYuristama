//
//  MovieListViewController.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import UIKit
import UIScrollView_InfiniteScroll

class MovieListViewController: UIViewController, MovieListViewProtocol {
    
    var presenter: (any MovieListPresenterProtocol)?
    
    private var spinner = UIActivityIndicatorView()
    private var movieList: [MovieListModel] = []
    
    private let collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: UICollectionViewFlowLayout())
        collectionView.register(MovieListCollectionViewCell.nib(), forCellWithReuseIdentifier: MovieListCollectionViewCell.identifier)
        collectionView.isHidden = true
        return collectionView
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(collectionView)
        view.addSubview(spinner)
        view.backgroundColor = .systemBackground
        collectionView.delegate = self
        collectionView.dataSource = self
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        let safeArea = view.safeAreaLayoutGuide
        
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.topAnchor.constraint(equalTo: safeArea.topAnchor).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: safeArea.trailingAnchor, constant: -16).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: safeArea.leadingAnchor, constant: 16).isActive = true
        
    }
    
    func update(with movieListResponse: MovieListResponse, isPagination: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isPagination {
                self?.movieList.append(contentsOf: movieListResponse.results)
                self?.collectionView.finishInfiniteScroll()
            } else {
                self?.movieList = movieListResponse.results
                self?.collectionView.addInfiniteScroll(handler: { table in
                    self?.presenter?.loadMoreMovies()
                })
            }
            self?.collectionView.reloadData()
            self?.collectionView.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    func update(with error: any Error, isPagination: Bool) {
        DispatchQueue.main.async { [weak self] in
            if isPagination {
                // TODO: Handle error when paginating
            } else {
                self?.movieList = []
            }
            self?.collectionView.isHidden = true
            self?.label.text = error.localizedDescription
            self?.label.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        label.frame = view.bounds
        label.center = view.center
    }
}

extension MovieListViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        self.movieList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MovieListCollectionViewCell.identifier, for: indexPath) as? MovieListCollectionViewCell else { return UICollectionViewCell() }
        cell.config(movieList[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        presenter?.showMovieDetail(movieList[indexPath.row])
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = self.view.frame.width / 2 - 32
        let height = width * 4/3 + 32
        return CGSize(width: width, height: height)
    }
}
