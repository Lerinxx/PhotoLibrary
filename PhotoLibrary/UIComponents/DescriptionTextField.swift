import UIKit

final class DescriptionTextField: UITextField {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.placeholder = Constants.placeholderText
        self.font = Constants.textFieldFont
        self.textColor = .black
        self.borderStyle = .line
        self.textAlignment = .center
    }
}
