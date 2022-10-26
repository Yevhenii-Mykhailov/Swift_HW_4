
import Foundation

//MARK: Task 4, 5
struct GenreModel: Codable {
    let genres: [Genre]
}

struct Genre: Codable {
    let id: Int
    let name: String
}
