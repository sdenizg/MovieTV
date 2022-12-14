//
//  MovieCastResponse.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 7.12.2022.
//

import Foundation

struct MovieCastResponse: Decodable {
    let id: Int
    let cast: [MovieCast]
    
}

struct MovieCast: Decodable {
   // let adult: Bool
    let gender: Int
    let id: Int
    let known_for_department: String
    let name: String
    let original_name: String
    let popularity: Double
    let profile_path : String
    let cast_id: Int
    let character: String
    let credit_id: String
    let order: Int
}
