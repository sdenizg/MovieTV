import UIKit
import Alamofire
import Kingfisher

enum TVTabType: Int {
     case popular = 0
     case topRated = 1
}

class TVShowsViewController: UIViewController {
     
     @IBOutlet weak var tableView: UITableView!
     var items: [TVItem] = []
     var itemId: Int?
     var isTV: Bool?
     private let apiKey = "2dbd75835d31fe29e22c5fcc1f402b7c"
     
    
     @IBAction private func tvSegmentedControl(_ sender: UISegmentedControl) {
          let sended = sender.selectedSegmentIndex
          let selectedTab = TVTabType(rawValue: sended)
          
          switch selectedTab {
          case .popular:
               fetchPopularTVShows()
          case .topRated:
               fetchTopRatedTVShows()
          case .none:
               break
          }
     }
     
     override func viewDidLoad() {
          super.viewDidLoad()
          
          tableView.delegate = self
          tableView.dataSource = self
          
          fetchPopularTVShows()
     }
     
     private func fetchPopularTVShows() {
          let request = AF.request("https://api.themoviedb.org/3/tv/popular?api_key=\(apiKey)&language=en-US&page=1")
          request.responseDecodable(of: TVShowsResponse.self) { [weak self] (response) in
               guard let self = self else { return }
               guard let popularShows = response.value else { return }
               self.items = popularShows.results
               self.tableView.reloadData()
          }
     }
     
     private func fetchTopRatedTVShows() {
          let request = AF.request("https://api.themoviedb.org/3/tv/top_rated?api_key=\(apiKey)&language=en-US&page=1")
          request.responseDecodable(of: TVShowsResponse.self) { [weak self] (response) in
               guard let self = self else { return }
               guard let topRatedShows = response.value else { return }
               self.items = topRatedShows.results
               self.tableView.reloadData()
          }
     }
}

extension TVShowsViewController: UITableViewDataSource {
     
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
          let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TVTableViewCell
          
          cell.tvNameLabel.text = items[indexPath.row].original_name
          cell.tvViewNumLabel.text = String(items[indexPath.row].popularity)
          cell.tvDateLabel.text = items[indexPath.row].first_air_date
          cell.tvRatingLabel.text = String(items[indexPath.row].vote_average)
          cell.tvImageView.kf.indicatorType = .activity
          let imgURL = "https://image.tmdb.org/t/p/w500\(items[indexPath.row].poster_path)"
          let url = URL(string: imgURL)
          cell.tvImageView.kf.setImage(with: url)
          
          return cell
     }
     
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
          if let destination = segue.destination as? DetailViewController {
               let object = sender as! TVItem
               destination.itemId = object.id
               destination.isTV = true
          }
     }
}

extension TVShowsViewController: UITableViewDelegate {
     
     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
          items.count
     }
     
     func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
          return 176.0
     }
     
     func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          let selectedItem = items[indexPath.row]
          performSegue(withIdentifier: "showDetailsTV", sender: selectedItem)
     }
}
