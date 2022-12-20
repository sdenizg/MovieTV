import Foundation

struct TVShowsResponse: Decodable {
    let page: Int
    let results: [TVItem]
    let total_results: Int
    let total_pages: Int
}
struct TVItem: Decodable {
    let poster_path: String
    let overview: String
    let first_air_date: String
    let genre_ids = [Int]()
    let id: Int
    let origin_country = [String]()
    let original_name: String
    let original_language : String
    let backdrop_path: String?
    let popularity: Double
    let vote_count: Int
    let vote_average: Float
}
