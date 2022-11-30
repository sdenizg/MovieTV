//
//  MovieViewController.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 18.10.2022.
//

import UIKit
import Alamofire
import Kingfisher

enum TabType: Int {
    case popular = 0
    case nowPlaying = 1
    case topRated = 2
}

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: [MovieItem] = []
    
    @IBAction func mySegmentedCntrl(_ sender: UISegmentedControl) {
        
        let sended = sender.selectedSegmentIndex
        let selectedTab = TabType(rawValue: sended)
        
        switch selectedTab {
        case .popular:
            fetchPopularMovies()
        case .nowPlaying:
            fetchNowPlayingMovies()
        case .topRated:
            fetchTopRatedMovies()
        case .none:
            break
        }
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchPopularMovies()
        /* fetchTopRatedMovies()
         fetchNowPlayingMovies() */
    }
    
    func fetchPopularMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/popular?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US&page=1")
        request.responseJSON { (data) in
            print(data)
        }
        request.responseDecodable(of: MovieResponse.self) { (response) in
            guard let popularMovies = response.value else { return }
            // print(popularMovies)
            self.items = popularMovies.results
            self.tableView.reloadData()
            
        }
    }
    
    func fetchTopRatedMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/top_rated?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US&page=1")
        request.responseJSON { (data) in
            print(data)
        }
        request.responseDecodable(of: MovieResponse.self) { (response) in
            guard let topRatedMovies = response.value else { return }
            // print(topRatedMovies)
            self.items = topRatedMovies.results
            self.tableView.reloadData()
            
        }
    }
    
    func fetchNowPlayingMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US&page=1")
        request.responseJSON { (data) in
            print(data)
        }
        request.responseDecodable(of: MovieResponse.self) { (response) in
            guard let nowPlayingMovies = response.value else { return }
           // print(nowPlayingMovies)
            self.items = nowPlayingMovies.results
            self.tableView.reloadData()
            
        }
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        
        cell.movieName.text = items[indexPath.row].title
        cell.movieViewNum.text = String(items[indexPath.row].popularity)
        cell.movieDate.text = items[indexPath.row].release_date
        cell.movieRating.text = String(items[indexPath.row].vote_average)
        //cell.movieImg.image = UIImage(named: items[indexPath.row].poster_path)!
        
        cell.movieImg.kf.indicatorType = .activity
        let imgURL = "https://image.tmdb.org/t/p/w500\(items[indexPath.row].poster_path)"
        let url = URL(string: imgURL)
        cell.movieImg.kf.setImage(with: url)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        performSegue(withIdentifier: "showDetailsMovie", sender: selectedItem)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? DetailViewController {
            let object = sender as! MovieItem
            destination.itemId = object.id
            destination.isMovie = true
        }
    }
    
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
