//
//  DetailViewController.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 31.10.2022.
//

import UIKit
import Alamofire

class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailPopularity: UILabel!
    @IBOutlet weak var detailRuntime: UILabel!
    @IBOutlet weak var detailOverview: UITextView!
    
    var itemId: Int!
    var isMovie: Bool!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        

       /* detailName.text = movie.title
        detailRating.text = String(movie.vote_average)
        detailPopularity.text = String(movie.popularity)
        detailOverview.text = movie.overview
        detailRuntime.text = "0"*/


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
