import Foundation

struct CastResponse: Decodable {
    let id: Int?
    let cast: [Cast]
    
    enum CastResponseCodingKeys: String, CodingKey {
        case id
        case cast
    }
}

struct Cast: Decodable {
    let id: Int?
    let originalName: String?
    let profilePath : String?
    let character: String
    
    enum CodingKeys: String, CodingKey {
        case originalName = "original_name"
        case profilePath = "profile_path"
        case id
        case character
    }
}
