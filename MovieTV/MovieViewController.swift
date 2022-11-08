//
//  MovieViewController.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 18.10.2022.
//

import UIKit

class MovieViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
   
    
    @IBOutlet weak var mySegmentedCntrl: UISegmentedControl!
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        fetchPopularMovies()
    }
    
    func fetchPopularMovies() {
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
    }
    
        
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            3
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! MovieTableViewCell
            
            cell.movieName.text = "Yes Man"
            
            return cell
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
