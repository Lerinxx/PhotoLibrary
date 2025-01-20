import UIKit

final class UserImage: Codable {
    var imageName: String
    var text: String?
    var date: Date
    var isLiked: Bool
    
    init(imageName: String, text: String? = nil, date: Date, isLiked: Bool = false) {
        self.imageName = imageName
        self.text = text
        self.date = date
        self.isLiked = isLiked
    }
}
