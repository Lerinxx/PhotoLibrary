import UIKit

enum Direction: Int {
    case right = 1
    case left = -1
}

final class PhotoFlipper {
    private var images: [UserImage]
    private var currentIndex: Int
    
    init() {
        self.images = StorageManager.shared.loadImages()
        self.currentIndex = images.count - 1
    }
    
    func getCurrentImage() -> UserImage? {
        guard !images.isEmpty else { return nil }
        return images[currentIndex]
    }
    
    func flipImage(to direction: Direction) -> UserImage? {
        guard !images.isEmpty else { return nil }
        currentIndex += direction.rawValue
        if currentIndex > images.count - 1 {
            currentIndex = 0
        } else if currentIndex < 0 {
            currentIndex = images.count - 1
        }
        return getCurrentImage()
    }
}
