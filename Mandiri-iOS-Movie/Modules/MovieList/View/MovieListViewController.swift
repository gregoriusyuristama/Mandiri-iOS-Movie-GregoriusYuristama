//
//  MovieListViewController.swift
//  Mandiri-iOS-Movie
//
//  Created by Gregorius Yuristama Nugraha on 3/8/24.
//

import UIKit

class MovieListViewController: UIViewController, MovieListViewProtocol {
    
    var presenter: (any MovieListPresenterProtocol)?
    
    private var spinner = UIActivityIndicatorView()
    private var movieList: [MovieListModel] = []
    
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
    
    func update(with movieListResponse: MovieListResponse) {
        DispatchQueue.main.async { [weak self] in
            self?.movieList = movieListResponse.results
            self?.tableView.reloadData()
            self?.tableView.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    func update(with error: any Error) {
        DispatchQueue.main.async { [weak self] in
            self?.movieList = []
            self?.tableView.isHidden = true
            self?.label.text = error.localizedDescription
            self?.label.isHidden = false
            self?.spinner.stopAnimating()
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
        label.frame = view.bounds
        label.center = view.center
    }
}

extension MovieListViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        movieList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = movieList[indexPath.row].title
        cell.textLabel?.textColor = .black
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter?.showMovieDetail(movieList[indexPath.row])
    }
    
}
