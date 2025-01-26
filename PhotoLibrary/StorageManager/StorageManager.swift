import UIKit

enum Key: String {
    case userImage = "userImage"
    case password = "password"
}

final class StorageManager {
    static let shared = StorageManager()
    private init() { }
    
    func saveImage(_ image: UserImage) {
        var images = loadImages()
        if let index = images.firstIndex(where: { $0.imageName == image.imageName }) {
            images[index] = image
        } else {
            images.append(image)
        }
        
        UserDefaults.standard.set(encodable: images, for: Key.userImage.rawValue)
    }
    
    func loadImages() -> [UserImage] {
        let images = UserDefaults.standard.value([UserImage].self, forKey: Key.userImage.rawValue)
        return images ?? []
    }
    
    func saveImage(_ image: UIImage) -> String? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
              let data = image.pngData() else { return nil }
        
        let fileName = UUID().uuidString
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        do {
            try data.write(to: fileURL)
            return fileName
        } catch let error {
            print(error.localizedDescription)
            return nil
        }
    }
    
    func loadImage(fileName: String) -> UIImage? {
        guard let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else {
            return nil
        }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        return UIImage(contentsOfFile: fileURL.path)
    }
    
    func savePassword(password: String) {
        UserDefaults.standard.set(password, forKey: Key.password.rawValue)
    }
    
    func loadPassword() -> String? {
        return UserDefaults.standard.string(forKey: Key.password.rawValue)
    }
}

extension UserDefaults {
    func set<T: Encodable>(encodable: T, for key: String) {
        if let data = try? JSONEncoder().encode(encodable) {
            set(data, forKey: key)
        }
    }
    
    func value<T: Decodable>(_ type: T.Type, forKey key: String) -> T? {
        if let data = object(forKey: key) as? Data,
           let value = try? JSONDecoder().decode(type, from: data) {
            return value
        }
        return nil
    }
}
