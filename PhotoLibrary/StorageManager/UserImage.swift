import UIKit

final class UserImage: Codable {
    var imageName: String
    var text: String?
    var date: Date
    
    init(imageName: String, text: String? = nil, date: Date) {
        self.imageName = imageName
        self.text = text
        self.date = date
    }
}
