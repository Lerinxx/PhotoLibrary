import UIKit

final class UserImage: Codable {
    var imageName: String
    
    init(imageName: String) {
        self.imageName = imageName
    }
}
