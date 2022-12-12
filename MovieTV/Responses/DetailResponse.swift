//
//  DetailResponse.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 29.11.2022.
//

import Foundation

struct DetailItem: Decodable {
    let adult: Bool
    let backdrop_path: String
    // let belongs_to_collection: Bool?
    let budget: Int
    let genres: [Genre]
    let homepage: String
    let id: Int
    let imdb_id: String
    let original_language: String
    let original_title: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let production_companies: [ProductionCompanies]
    let production_countries: [ProductionCountries]
    let release_date: String
    let revenue: Int
    let runtime: Int
    let spoken_languages: [SpokenLanguages]
    let status: String
    let tagline: String
    let title: String
    let video: Bool
    let vote_average: Float
    let vote_count: Int
}


struct Genre: Decodable {
    let id: Int
    let name: String
}

struct ProductionCompanies: Decodable {
    let id: Int
    //  let logo_path: String
    let name: String
    let origin_country: String
    
}

struct ProductionCountries: Decodable {
    let iso_3166_1: String
    let name: String
}

struct SpokenLanguages: Decodable {
    let english_name: String
    // let iso_3166_1: String
    let name: String
}
