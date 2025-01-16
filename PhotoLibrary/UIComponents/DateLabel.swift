import UIKit
import SnapKit

final class DateLabel: UILabel {
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.textAlignment = .center
        self.font = Constants.bodyFont
        self.textColor = .black
        self.isHidden = true
    }
    
    func updateDate(with date: Date) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .none
        self.text = dateFormatter.string(from: date)
        self.isHidden = false
    }
}
