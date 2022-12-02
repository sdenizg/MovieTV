//
//  DetailViewController.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 31.10.2022.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController {
    
    var detailItems: DetailItem!
    var tvDetailItems: TVDetailItem!
    
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailPopularity: UILabel!
    @IBOutlet weak var detailRuntime: UILabel!
    @IBOutlet weak var detailOverview: UITextView!
    
    var itemId: Int!
    var isMovie: Bool!
    var isTV: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchMovieDetails()
        //fetchTVDetails()
    }
    
    func fetchMovieDetails() {
        let request = AF.request("https://api.themoviedb.org/3/movie/\(itemId!)?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US")
        /* request.responseJSON { (data) in
         // print(data)
         } */
        request.responseDecodable(of: DetailItem.self) { [self] (response) in
            
            switch response.result {
            case .success(_):
                guard let details = response.value else { return }
                // print(details)
                self.detailItems = details
                detailName.text = detailItems.original_title
                detailRating.text = String(detailItems.vote_average)
                detailPopularity.text = String(detailItems.popularity)
                detailOverview.text = detailItems.overview
                detailRuntime.text = String(detailItems.runtime)
                
                // image
                detailImg.kf.indicatorType = .activity
                let imgURL = "https://image.tmdb.org/t/p/w500\(detailItems.poster_path)"
                let url = URL(string: imgURL)
                detailImg.kf.setImage(with: url)
                
            case .failure(let DecodingError):
                print(DecodingError)
            }
        }
    }
    
    func fetchTVDetails() {
        let request = AF.request("https://api.themoviedb.org/3/tv/\(itemId!)?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US")
        /* request.responseJSON { (data) in
         // print(data)
         } */
        request.responseDecodable(of: TVDetailItem.self) { [self] (response) in
            
            switch response.result {
            case .success(_):
                guard let tvDetails = response.value else { return }
                // print(details)
                self.tvDetailItems = tvDetails
                detailName.text = tvDetailItems.original_name
                detailRating.text = String(tvDetailItems.vote_average)
                detailPopularity.text = String(tvDetailItems.popularity)
                detailOverview.text = tvDetailItems.overview
                detailRuntime.text = String(tvDetailItems.episode_run_time)
                
                // image
                detailImg.kf.indicatorType = .activity
                let imgURL = "https://image.tmdb.org/t/p/w500\(tvDetailItems.poster_path)"
                let url = URL(string: imgURL)
                detailImg.kf.setImage(with: url)
                
            case .failure(let DecodingError):
                print(DecodingError)
            }
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

