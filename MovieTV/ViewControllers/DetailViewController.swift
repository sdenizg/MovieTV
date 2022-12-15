//
//  DetailViewController.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 31.10.2022.
//

import UIKit
import Alamofire
import Kingfisher

class DetailViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var tvCast: [TVCast] = []
    var movieCast: [MovieCast] = []
    
    var detailItems: DetailItem!
    var tvDetailItems: TVDetailItem!
    
    @IBOutlet weak var detailImg: UIImageView!
    @IBOutlet weak var detailName: UILabel!
    @IBOutlet weak var detailRating: UILabel!
    @IBOutlet weak var detailPopularity: UILabel!
    @IBOutlet weak var detailRuntime: UILabel!
    @IBOutlet weak var detailOverview: UILabel!
    
    
    var itemId: Int!
    var isMovie: Bool!
    var isTV: Bool!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
        if isMovie == true {
            fetchMovieDetails()
            MovieCastDetails()
            
        } else if isTV == true {
            fetchTVDetails()
            TVCastDetails()
        }
        
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
                detailRuntime.text = "\(String(detailItems.runtime)) min"
                
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
                detailRuntime.text = "\(String(tvDetailItems.episode_run_time)) min"

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
    
    
    
    func TVCastDetails() {
        let request = AF.request("https://api.themoviedb.org/3/tv/\(itemId!)/credits?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US")
        
        request.responseDecodable(of: TVCastResponse.self) { [self] (response) in
            
            switch response.result {
            case .success(_):
                guard let tvCastDetails = response.value else { return }
                print(tvCastDetails)
                self.tvCast = tvCastDetails.cast
                self.collectionView.reloadData()

                
            case .failure(let DecodingError):
                print(DecodingError)
            }
        }
    }
    
    func MovieCastDetails() {
        let request = AF.request("https://api.themoviedb.org/3/movie/\(itemId!)/credits?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US")
        
        request.responseDecodable(of: MovieCastResponse.self) { [self] (response) in
            
            switch response.result {
            case .success(_):
                guard let movieCastDetails = response.value else { return }
                print(movieCastDetails)
                self.movieCast = movieCastDetails.cast
                self.collectionView.reloadData()

                
            case .failure(let DecodingError):
                print(DecodingError)
            }
        }
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if isMovie == true {
            return movieCast.count
        } else if isTV == true {
            return tvCast.count
        } else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! CastCollectionViewCell
        if isMovie == true {
            cell.actName.text = movieCast[indexPath.item].original_name
            cell.charName.text = movieCast[indexPath.item].character
            
            cell.actImg.kf.indicatorType = .activity
            guard let profilePath = movieCast[indexPath.item].profile_path else {return cell}
            let imgURL = "https://image.tmdb.org/t/p/w500\(profilePath)"
            let url = URL(string: imgURL)
            cell.actImg.kf.setImage(with: url)
            return cell
            
        } else if isTV == true {
            cell.actName.text = tvCast[indexPath.item].original_name
            cell.charName.text = tvCast[indexPath.item].character
            
            cell.actImg.kf.indicatorType = .activity
            guard let tvProfilePath = tvCast[indexPath.item].profile_path else {return cell}
            let imgURL = "https://image.tmdb.org/t/p/w500\(tvProfilePath)"
            let url = URL(string: imgURL)
            cell.actImg.kf.setImage(with: url)
            return cell
            
        } else {
            print("error")
        }
        
        return cell
    }
    
    /*func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: UIScreen.main.bounds.width/3-16, height: UIScreen.main.bounds.width/3+30)
    } */
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}

