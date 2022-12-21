import UIKit
import Alamofire
import Kingfisher

enum DetectingShowType: Int {
    case movie = 0
    case tv = 1
}

class DetailViewController: UIViewController {
    
    var cast: [Cast] = []
    var detailItems: DetailItem?
    var itemId: Int?
    var isMovie: Bool?
    var isTV: Bool?
    var detectedShowType: Int = 0
    var showType: String = ""
    private let apiKey = "2dbd75835d31fe29e22c5fcc1f402b7c"
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailNameLabel: UILabel!
    @IBOutlet weak var detailRatingLabel: UILabel!
    @IBOutlet weak var detailPopularityLabel: UILabel!
    @IBOutlet weak var detailRuntimeLabel: UILabel!
    @IBOutlet weak var detailOverviewLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        fetchMovieOrTVDetailsIfNeeded()
    }
    
    private func fetchMovieDetails() {
        fetchDetail()
    }
    
    private func fetchTVDetails() {
        fetchDetail()
    }
    
    private func fetchDetail() {
        selectingShowType()
        let request = AF.request("https://api.themoviedb.org/3/\(showType)/\(itemId!)?api_key=\(apiKey)&language=en-US")
        request.responseDecodable(of: DetailItem.self) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(_):
                guard let details = response.value else { return }
                self.detailItems = details
                guard let detailItems = self.detailItems else { return }
                self.detailRatingLabel.text = String(detailItems.voteAverage)
                self.detailPopularityLabel.text = String(detailItems.popularity)
                self.detailOverviewLabel.text = detailItems.overview
                self.detailImageView.kf.indicatorType = .activity
                let imgURL = "https://image.tmdb.org/t/p/w500\(detailItems.posterPath)"
                let url = URL(string: imgURL)
                self.detailImageView.kf.setImage(with: url)
                if self.showType == "movie" {
                    guard let movieOriginalTitle = detailItems.originalTitle else { return }
                    self.detailNameLabel.text = movieOriginalTitle
                    guard let movieRuntime = detailItems.runtime else { return }
                    self.detailRuntimeLabel.text = "\(String(movieRuntime)) min"
                } else if self.showType == "tv" {
                    guard let tvOriginalName = detailItems.originalName else { return }
                    self.detailNameLabel.text = tvOriginalName
                    guard let tvRuntime = detailItems.episodeRunTime else { return }
                    self.detailRuntimeLabel.text = "\(String(tvRuntime)) min"
                }
            case .failure(let DecodingError):
                print(DecodingError)
            }
        }
    }
    
    private func fetchTVCastDetails() {
        fetchCastDetails()
    }
    
    private func fetchMovieCastDetails() {
        fetchCastDetails()
    }
    
    private func fetchCastDetails() {
        selectingShowType()
        let request = AF.request("https://api.themoviedb.org/3/\(showType)/\(itemId!)/credits?api_key=\(apiKey)&language=en-US")
        request.responseDecodable(of: CastResponse.self) { [weak self] (response) in
            guard let self = self else { return }
            switch response.result {
            case .success(_):
                guard let castDetails = response.value else { return }
                print(castDetails)
                self.cast = castDetails.cast
                self.collectionView.reloadData()
            case .failure(let DecodingError):
                print(DecodingError)
            }
        }
    }
    
    func fetchMovieOrTVDetailsIfNeeded() {
        if isMovie == true {
            fetchMovieDetails()
            fetchMovieCastDetails()
            detectedShowType = 0
            
        } else if isTV == true {
            fetchTVDetails()
            fetchTVCastDetails()
            detectedShowType = 1
        }
    }
    
    func selectingShowType() {
        let selectedShow = DetectingShowType(rawValue: detectedShowType)
        switch selectedShow {
        case .movie:
            showType = "movie"
        case .tv:
            showType = "tv"
        case .none:
            break
        }
    }
}

extension DetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CastCollectionViewCell
        if isMovie == true {
            cell.actNameLabel.text = cast[indexPath.item].originalName
            cell.charNameLabel.text = cast[indexPath.item].character
            cell.actImageView.kf.indicatorType = .activity
            guard let movieProfilePath = cast[indexPath.item].profilePath else {return cell}
            let imgURL = "https://image.tmdb.org/t/p/w500\(movieProfilePath)"
            let url = URL(string: imgURL)
            cell.actImageView.kf.setImage(with: url)
            return cell
        } else if isTV == true {
            cell.actNameLabel.text = cast[indexPath.item].originalName
            cell.charNameLabel.text = cast[indexPath.item].character
            cell.actImageView.kf.indicatorType = .activity
            guard let tvProfilePath = cast[indexPath.item].profilePath else {return cell}
            let imgURL = "https://image.tmdb.org/t/p/w500\(tvProfilePath)"
            let url = URL(string: imgURL)
            cell.actImageView.kf.setImage(with: url)
            return cell
        } else {}
        return cell
    }
}

extension DetailViewController: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cast.count
    }
}

