import UIKit
import SnapKit

final class PhotoCell: UICollectionViewCell {
    
    static var identifier: String { "\(Self.self)" }
    
    private let photoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        return view
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        contentView.addSubview(photoView)
        photoView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    func configCell(with model: UserImage) {
        photoView.image = StorageManager.shared.loadImage(fileName: model.imageName)
    }
}


