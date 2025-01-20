import UIKit
import SnapKit

final class LikeBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        var config = UIButton.Configuration.plain()
        config.image = Constants.likeBtn
        config.baseBackgroundColor = .clear
        self.configuration = config
        
        snp.makeConstraints { make in
            make.width.equalTo(50)
            make.height.equalTo(50)
        }
    }
    
    private func toggleLikeUI() {
        var config = UIButton.Configuration.plain()
        config.image = self.isSelected ? Constants.likeBtnFilled : Constants.likeBtn
        config.baseBackgroundColor = .clear
        self.configuration = config
    }
    
    func setLikeState(_ liked: Bool) {
        self.isSelected = liked
        toggleLikeUI()
    }
    
    func toggleLike() {
        self.isSelected.toggle()
        toggleLikeUI()
    }
}
