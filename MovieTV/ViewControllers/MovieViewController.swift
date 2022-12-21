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
    var movieType: String = ""
    
    @IBAction private func movieSegmentedControl(_ sender: UISegmentedControl) {
        let sended = sender.selectedSegmentIndex
        let selectedTab = TabType(rawValue: sended)
        
        switch selectedTab {
        case .popular:
            movieType = "popular"
            fetchPopularMovies()
        case .nowPlaying:
            movieType = "now_playing"
            fetchNowPlayingMovies()
        case .topRated:
            movieType = "top_rated"
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
        
        UITabBar.appearance().barTintColor = UIColor.black 
    }
    
    private func fetchPopularMovies() {
        fetchMovies()
    }
    
    private func fetchTopRatedMovies() {
        fetchMovies()
    }
    
    private func fetchNowPlayingMovies() {
        fetchMovies()
    }
    
    private func fetchMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/\(movieType)?api_key=\(apiKey)&language=en-US&page=1")
        request.responseDecodable(of: MovieResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(_):
                guard let movies = response.value else { return }
                self.items = movies.results
                self.tableView.reloadData()
            case .failure(let DecodingError):
                print(DecodingError)
            }
        }
    }
}

extension MovieViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath.row]
        performSegue(withIdentifier: "showDetailsMovie", sender: selectedItem)
        tableView.deselectRow(at: indexPath, animated: true)
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
        cell.movieDateLabel.text = items[indexPath.row].releaseDate
        cell.movieRatingLabel.text = String(items[indexPath.row].voteAverage)
        cell.movieImageView.kf.indicatorType = .activity
        let imgURL = "https://image.tmdb.org/t/p/w500\(items[indexPath.row].posterPath)"
        let url = URL(string: imgURL)
        cell.movieImageView.kf.setImage(with: url)
        
        return cell
    }
}
