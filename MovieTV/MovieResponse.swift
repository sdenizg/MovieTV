//
//  MovieResponse.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 15.11.2022.
//

import Foundation

import Foundation

struct MovieResponse: Decodable {
    let page: Int
    let results: [MovieItem]
    let total_results: Int
    let total_pages: Int
    
}

struct MovieItem: Decodable {
    let poster_path: String
    let adult: Bool
    let overview: String
    let release_date: String
    let genre_ids = [Int]()
    let id: Int
    let original_title: String
    let original_language : String
    let title: String
    let backdrop_path: String
    let popularity: Double
    let vote_count: Int
    let video: Bool
    let vote_average: Float
}
