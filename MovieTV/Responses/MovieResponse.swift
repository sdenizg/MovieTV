import Foundation

struct MovieResponse: Decodable {
    let results: [MovieItem]
    
    enum MovieResponseCodingKeys: String, CodingKey {
        case results
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: MovieResponseCodingKeys.self)
        results = try container.decode([MovieItem].self, forKey: .results)
    }
}

struct MovieItem: Decodable {
    let posterPath: String
    let releaseDate: String?
    let id: Int
    let title: String
    let popularity: Double
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case voteAverage = "vote_average"
        case id
        case title
        case popularity
    }
    
}
