import UIKit
import SnapKit

class PasscodeViewController: UIViewController {
    
//    private var currentPasscode: String = ""
//    private let maxPasscodeLength = 4
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = Constants.lockImage
        return view
    }()
    
    private let createPasscodeLabel: UILabel = {
        let label = UILabel()
        label.font = Constants.bodyFont
        label.text = Constants.createPasscodeText
        label.textColor = .black
        label.textAlignment = .center
        return label
    }()
    
    private let passcodeStackView: PasscodeStackView = {
        let view = PasscodeStackView()
        return view
    }()
    
    private let topContainerView: UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        view.addSubview(topContainerView)
        topContainerView.addSubview(iconImageView)
        topContainerView.addSubview(createPasscodeLabel)
        topContainerView.addSubview(passcodeStackView)
        
        topContainerView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalToSuperview().multipliedBy(0.3)
        }
        iconImageView.snp.makeConstraints { make in
            make.height.equalTo(90)
            make.width.equalTo(iconImageView.snp.height)
            make.centerX.equalToSuperview()
            make.top.equalTo(topContainerView.snp.top).offset(30)
        }
        createPasscodeLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(40)
        }
        passcodeStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(createPasscodeLabel.snp.bottom).offset(24)
        }
    }
}
