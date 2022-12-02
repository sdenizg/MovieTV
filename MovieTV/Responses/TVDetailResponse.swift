//
//  TVDetailResponse.swift
//  MovieTV
//
//  Created by Ş. Deniz Geçginer on 30.11.2022.
//

import Foundation

struct TVDetailItem: Decodable {
   // let adult: Bool
  //  let backdrop_path: String
    let created_by: [CreatedBy]
    var episode_run_time: Int
    let first_air_date: String
    let genres: [Genres]
    let homepage: String
    let id: Int
    let in_production: Bool
    var languages = [String]()
    let last_air_date: String
    let last_episode_to_air: [LastEpisodeToAir]
    let name: String
    let next_episode_to_air: [NextEpisodeToAir]
    let networks: [Networks]
    let number_of_episodes: Int
    let number_of_seasons: Int
    var origin_country = [String]()
    let original_language: String
    let original_name: String
    let overview: String
    let popularity: Double
    let poster_path: String
    let production_companies: [ProductionCompany]
    let production_countries: [ProductionCountry]
    let seasons: [Seasons]
    let spoken_languages: [SpokenLanguage]
    let status: String
    let tagline: String
    let type: String
    let vote_average: Float
    let vote_count: Int
}


struct CreatedBy: Decodable {
    let id: Int
    let credit_id: String
    let name: String
    let gender: Int
    let profile_path: String
    
}

struct Genres: Decodable {
    let id: Int
    let name: String
}

struct LastEpisodeToAir: Decodable {
    let air_date: String
    let episode_number: Int
    let id: Int
    let name: String
    let overview: String
    let production_code: String
    let runtime: Int
    let season_number: Int
    let show_id: Int
    let still_path: String
    let vote_average: Float
    let vote_count: Int
    
}

struct NextEpisodeToAir: Decodable {
    let air_date: String
    let episode_number: Int
    let id: Int
    let name: String
    let overview: String
    let production_code: String
    let runtime: Int
    let season_number: Int
    let show_id: Int
    let still_path: String
    let vote_average: Float
    let vote_count: Int
    
}

struct Networks: Decodable {
    let id: Int
    let name: String
    let logo_path: String
    let origin_country: String
}

struct ProductionCompany: Decodable {
    let id: Int
    let logo_path: String
    let name: String
    let origin_country: String
    
}

struct ProductionCountry: Decodable {
    let iso_3166_1: String
    let name: String
}

struct Seasons: Decodable {
    let air_date: String
    let episode_count: Int
    let id: Int
    let name: String
    let iso_3166_1: String
    let overview: String
    let poster_path: String
    let season_number: Int
    
}

struct SpokenLanguage: Decodable {
    let english_name: String
    //let iso_639_1: Int
    let name: String
}

