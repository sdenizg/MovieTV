//
//  MovieViewController.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 18.10.2022.
//

import UIKit
import Alamofire

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    var items: [MovieItem] = []
    
    @IBAction func mySegmentedCntrl(_ sender: Any) {
        
        //enum
        
    }
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
         fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
        let request = AF.request("https://api.themoviedb.org/3/movie/popular?api_key=2dbd75835d31fe29e22c5fcc1f402b7c&language=en-US&page=1")
        request.responseJSON { (data) in
          print(data)
        }
        request.responseDecodable(of: MovieResponse.self) { (response) in
          guard let popularMovies = response.value else { return }
            print(popularMovies)
            self.items = popularMovies.results
            self.tableView.reloadData()
            
        }
    }
      
    
    
    
    /*func fetchPopularMovies() {
        let networkManager = NetworkManager()
        let apiKey = "2dbd75835d31fe29e22c5fcc1f402b7c"
        let urlString =
    "https://api.themoviedb.org/3/movie/popular?api_key=\(apiKey)&language=en-US&page=1"
        let url = URL(string: urlString)
        networkManager.fetchData(at: url!) { result in
            switch result {
            case .success(let movieResponse):
                break
            case .failure(let error):
                break
            }
        }
    } */
    
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            items.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
                        
            cell.movieName.text = items[indexPath.row].title
            cell.movieViewNum.text = String(items[indexPath.row].popularity)
            cell.movieDate.text = items[indexPath.row].release_date
            cell.movieRating.text = String(items[indexPath.row].vote_average)
            //cell.movieImg.image = UIImage(named: items[indexPath.row].poster_path)!
            
            return cell
        }
    
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            performSegue(withIdentifier: "showDetailsMovie", sender: self)
          
        }
    
        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if let destination = segue.destination as? DetailViewController {
                destination.items = 
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
