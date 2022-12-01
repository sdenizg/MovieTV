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
    
    var detailItems: [DetailItem] = []
    var tvDetailItems: [TVDetailItem] = []
        
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
        
        if isMovie == true {
            detailName.text = detailItems[itemId].original_title // FATAL ERROR
            detailRating.text = String(detailItems[itemId].vote_average)
            detailPopularity.text = String(detailItems[itemId].popularity)
            detailOverview.text = detailItems[itemId].overview
            detailRuntime.text = String(detailItems[itemId].runtime)
            
            // image
            detailImg.kf.indicatorType = .activity
            let imgURL = "https://image.tmdb.org/t/p/w500\(detailItems[itemId].poster_path)"
            let url = URL(string: imgURL)
            detailImg.kf.setImage(with: url)
        }
        
        fetchMovieDetails()
        fetchTVDetails()
    }
    
    func fetchMovieDetails() {
        let request = AF.request("https://api.themoviedb.org/3/movie/\(itemId!)?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US")
        request.responseJSON { (data) in
            print(data)
        }
        request.responseDecodable(of: DetailItem.self) { (response) in
            guard let details = response.value else { return }
            print(details)
        }
        
    }
        func fetchTVDetails() {
            let request = AF.request("https://api.themoviedb.org/3/tv/\(itemId!)?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US")
            request.responseJSON { (data) in
                print(data)
            }
            request.responseDecodable(of: TVDetailItem.self) { (response) in
                guard let details = response.value else { return }
                print(details)
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

