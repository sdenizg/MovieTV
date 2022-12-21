import Foundation

struct DetailItem: Decodable {
    let id: Int?
    let originalTitle: String?
    let originalName: String?
    let overview: String
    let popularity: Double
    let posterPath: String
    let runtime: Int?
    var episodeRunTime: Int?
    let voteAverage: Float
    
    enum CodingKeys: String, CodingKey {
        case originalTitle = "original_title"
        case posterPath = "poster_path"
        case episodeRunTime = "episode_run_time"
        case voteAverage = "vote_average"
        case id
        case overview
        case popularity
        case runtime
        case originalName = "original_name"
    }
}
