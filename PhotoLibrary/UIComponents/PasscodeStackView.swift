import UIKit
import SnapKit

final class PasscodeStackView: UIStackView {
    private var dots = [UIView]()
    
    init(dotCount: Int = 4, dotSize: CGFloat = 20, spacing: CGFloat = 14) {
        super.init(frame: .zero)
        configDots(count: dotCount, size: dotSize, spacing: spacing)
    }
    
    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configDots(count: Int, size: CGFloat, spacing: CGFloat) {
        axis = .horizontal
        distribution = .equalSpacing
        alignment = .center
        self.spacing = spacing
        
        for _ in 0..<count {
            let dot = UIView()
            dot.layer.cornerRadius = size / 2
            dot.layer.borderWidth = 2
            dot.layer.borderColor = UIColor.black.cgColor
            dot.backgroundColor = .clear
            addArrangedSubview(dot)
            dots.append(dot)
            dot.snp.makeConstraints { make in
                make.width.height.equalTo(size)
            }
        }
    }
    
    func updateDots(filledCount: Int) {
        for (index, dot) in dots.enumerated() {
            dot.backgroundColor = index < filledCount ? .black : .clear
        }
    }
}
