//
//  DetailViewController.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 31.10.2022.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    //  var items: [DetailItem] = []
    
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
    
        /* detailName.text = DetailItem.original_title
         detailRating.text = String(movie.vote_average)
         detailPopularity.text = String(movie.popularity)
         detailOverview.text = movie.overview
         detailRuntime.text = "0" */
        
        fetchMovieDetails()
       // fetchTVDetails()
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
        
        func fetchTVDetails() {
            let request = AF.request("https://api.themoviedb.org/3/tv/\(itemId!)?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US")
            request.responseJSON { (data) in
                print(data)
            }
            request.responseDecodable(of: DetailItem.self) { (response) in
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
}
