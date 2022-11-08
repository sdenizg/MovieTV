//
//  NetworkManager.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 5.11.2022.
//

import Foundation

class NetworkManager {
    
    func fetchData(at url: URL, completion: @escaping (Result<MovieResponse, Error>) -> Void) {
        let urlSession = URLSession(configuration: URLSessionConfiguration.default)
        urlSession.dataTask(with: url) { (data, response, error) in
          if let error = error {
            completion(.failure(error))
          }

          if let data = data {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print(json)
            let movieResponse = try JSONDecoder().decode(MovieResponse.self, from: data)
              completion(.success(movieResponse))
            } catch let decoderError {
              // print(decoderError)
              completion(.failure(decoderError))
            }
          }
        }.resume()
      }
    
    
}
