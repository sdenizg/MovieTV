import Foundation

struct DetailItem: Decodable {
    let id: Int?
    let original_title: String?
    let original_name: String?
    let overview: String
    let popularity: Double
    let poster_path: String
    let runtime: Int?
    var episode_run_time: Int?
    let vote_average: Float
    let vote_count: Int
}
