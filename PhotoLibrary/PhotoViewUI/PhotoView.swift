import UIKit
import SnapKit

final class PhotoView: UIView {
    
    private let imageView: UIImageView = {
       let view = UIImageView()
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
        addSubview(imageView)
        imageView.backgroundColor = .lightGray
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
}
