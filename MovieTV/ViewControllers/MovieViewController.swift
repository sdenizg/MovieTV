import UIKit
import Alamofire
import Kingfisher

enum TabType: Int {
    case popular = 0
    case nowPlaying = 1
    case topRated = 2
}

class MovieViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    var items: [MovieItem] = []
    private let apiKey = "2dbd75835d31fe29e22c5fcc1f402b7c"

    
    @IBAction private func movieSegmentedControl(_ sender: UISegmentedControl) {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchPopularMovies()
    }
    
    private func fetchPopularMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1")
        request.responseDecodable(of: MovieResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            guard let popularMovies = response.value else { return }
            self.items = popularMovies.results
            self.tableView.reloadData()
        }
    }
    
    private func fetchTopRatedMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/top_rated?api_key=\(apiKey)&language=en-US&page=1")
        request.responseDecodable(of: MovieResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            guard let topRatedMovies = response.value else { return }
            self.items = topRatedMovies.results
            self.tableView.reloadData()
        }
    }
    
    private func fetchNowPlayingMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/now_playing?api_key=\(apiKey)&language=en-US&page=1")
        request.responseDecodable(of: MovieResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            guard let nowPlayingMovies = response.value else { return }
            self.items = nowPlayingMovies.results
            self.tableView.reloadData()
        }
    }
}

extension MovieViewController: UITableViewDataSource {
    
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
}

extension MovieViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
        
        cell.movieNameLabel.text = items[indexPath.row].title
        cell.movieViewNumLabel.text = String(items[indexPath.row].popularity)
        cell.movieDateLabel.text = items[indexPath.row].release_date
        cell.movieRatingLabel.text = String(items[indexPath.row].vote_average)
        cell.movieImageView.kf.indicatorType = .activity
        let imgURL = "https://image.tmdb.org/t/p/w500\(items[indexPath.row].poster_path)"
        let url = URL(string: imgURL)
        cell.movieImageView.kf.setImage(with: url)
        
        return cell
    }
}
