import Foundation

struct TVShowsResponse: Decodable {
    let results: [TVItem]
    
    enum TVShowsResponseCodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TVShowsResponseCodingKeys.self)
        results = try container.decode([TVItem].self, forKey: .results)
    }
}
struct TVItem: Decodable {
    let posterPath: String
    let id: Int
    let originalName: String
    let popularity: Double
    let voteAverage: Float
    let firstAirDate: String
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case originalName = "original_name"
        case firstAirDate = "first_air_date"
        case voteAverage = "vote_average"
        case id
        case popularity
    }
}
