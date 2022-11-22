//
//  TVShowsViewController.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 18.10.2022.
//

import UIKit
import Alamofire
import Kingfisher

enum TVTabType: Int {
    case popular = 0
    case topRated = 1
}


class TVShowsViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var items: [TVItem] = []
    
    @IBAction func mySegmentedControl(_ sender: UISegmentedControl) {
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
    
    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.delegate = self
        tableView.dataSource = self
        
        fetchPopularTVShows()
        
    }
    
    func fetchPopularTVShows() {
      let request = AF.request("https://api.themoviedb.org/3/tv/popular?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US&page=1")
      request.responseJSON { (data) in
        print(data)
      }
      request.responseDecodable(of: TVShowsResponse.self) { (response) in
        guard let popularShows = response.value else { return }
          print(popularShows)
          self.items = popularShows.results
          self.tableView.reloadData()
          
      }
  }
    
    func fetchTopRatedTVShows() {
      let request = AF.request("https://api.themoviedb.org/3/tv/top_rated?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US&page=1")
      request.responseJSON { (data) in
        print(data)
      }
      request.responseDecodable(of: TVShowsResponse.self) { (response) in
        guard let topRatedShows = response.value else { return }
          print(topRatedShows)
          self.items = topRatedShows.results
          self.tableView.reloadData()
          
      }
  }
    
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        items.count
    }
    
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! TVTableViewCell
            
            cell.tvName.text = items[indexPath.row].original_name
            cell.tvViewNum.text = String(items[indexPath.row].popularity)
            cell.tvDate.text = items[indexPath.row].first_air_date
            cell.tvRating.text = String(items[indexPath.row].vote_average)
            
            // image
            cell.tvImg.kf.indicatorType = .activity
            let imgURL = "https://image.tmdb.org/t/p/w500\(items[indexPath.row].poster_path)"
            let url = URL(string: imgURL)
            cell.tvImg.kf.setImage(with: url)
            
            return cell
        }
}
