import UIKit

final class AddPhotoBtn: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        var config = UIButton.Configuration.plain()
        config.image = Constants.photoImage
        config.title = Constants.loadPhotoLabel
        config.imagePadding = 25
        config.imagePlacement = .leading
        config.baseForegroundColor = .black
        config.attributedTitle = AttributedString(
            Constants.loadPhotoLabel,
            attributes: AttributeContainer([.font: Constants.bodyFont as Any])
        )
        
        self.backgroundColor = Constants.pinkColor
        self.titleLabel?.font = Constants.bodyFont
        self.layer.cornerRadius = 13
        self.configuration = config
    }
}
