//
//  MovieGenreViewController.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import UIKit

class MovieGenreViewController: UIViewController, MovieGenreViewProtocol {
    
    var presenter: (any MovieGenrePresenterProtocol)?
    
    private var spinner = UIActivityIndicatorView()
    private var movieGenres: [MovieGenreModel] = []
    
    private let tableView: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.isHidden = true
        return table
    }()
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.numberOfLines = 0
        label.isHidden = true
        return label
    }()
    
    func update(with movieGenreResponse: MovieGenreResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.movieGenres = movieGenreResponse.genres
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    func update(with error: any Error) {
        DispatchQueue.main.async { [weak self] in
            self?.movieGenres = []
            self?.tableView.isHidden = true
            self?.label.text = error.localizedDescription
            self?.label.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(tableView)
        view.addSubview(spinner)
        view.backgroundColor = .systemBackground
        tableView.delegate = self
        tableView.dataSource = self
        spinner.translatesAutoresizingMaskIntoConstraints = false
        spinner.startAnimating()
        spinner.hidesWhenStopped = true
        
        spinner.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        spinner.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = view.bounds
        label.center = view.center
    }
}

extension MovieGenreViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieGenres.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movieGenres[indexPath.row].name.capitalized
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showMovieList(movieGenres[indexPath.row])
    }
    
}
