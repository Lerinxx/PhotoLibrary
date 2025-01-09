import UIKit
import SnapKit

final class ArrowBtn: UIButton {
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        setImage(Constants.arrowBtn, for: .normal)
        snp.makeConstraints { make in
            make.width.equalTo(70)
            make.height.equalTo(70)
        }
    }
}
