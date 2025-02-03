import UIKit
import SnapKit

class PasscodeViewController: UIViewController {
    
    private var currentPasscode: String = ""
    private var repeatedPasscode: String = ""
    private var isMatch = false
    private let maxPasscodeLength = 4
    var keyboardType: UIKeyboardType = .numberPad
    
    private let iconImageView: UIImageView = {
        let view = UIImageView()
        view.image = Constants.lockImage
        return view
    }()
    
    private let passcodeLabel: UILabel = {
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
        checkForPassword()
    }
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        view.addSubview(topContainerView)
        topContainerView.addSubview(iconImageView)
        topContainerView.addSubview(passcodeLabel)
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
        passcodeLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.centerX.equalToSuperview()
            make.top.equalTo(iconImageView.snp.bottom).offset(40)
        }
        passcodeStackView.snp.makeConstraints { make in
            make.centerX.equalToSuperview()
            make.top.equalTo(passcodeLabel.snp.bottom).offset(24)
        }
    }
    
    private func checkForPassword() {
        if let savedPassword = StorageManager.shared.loadPassword() {
            isMatch = true
            repeatedPasscode = savedPassword
            passcodeLabel.text = Constants.enterPasscodeText
        } else {
            isMatch = false
        }
        becomeFirstResponder()
    }
    
    private func handlePasscodeCompletion() {
        if isMatch {
            if currentPasscode == repeatedPasscode {
                navigateToNextController()
            } else {
                showPasswordMatchAlert()
                resetInput()
            }
        } else {
            repeatedPasscode = currentPasscode
            isMatch = true
            passcodeLabel.text = Constants.confirmPasscodeText
            resetInput()
        }
    }
    
    private func resetInput() {
        currentPasscode = ""
        passcodeStackView.updateDots(filledCount: 0)
    }
    
    private func navigateToNextController() {
        StorageManager.shared.savePassword(password: currentPasscode)
        let nextController = LibraryViewController()
        navigationController?.pushViewController(nextController, animated: true)
    }
}

extension PasscodeViewController: UIKeyInput, UITextInputTraits {
    
    var hasText: Bool {
        return !currentPasscode.isEmpty
    }
    
    func insertText(_ text: String) {
        guard currentPasscode.count < maxPasscodeLength else { return }
        currentPasscode.append(text)
        passcodeStackView.updateDots(filledCount: currentPasscode.count)
        
        if currentPasscode.count == maxPasscodeLength {
            handlePasscodeCompletion()
        }
    }
    
    func deleteBackward() {
        guard !currentPasscode.isEmpty else { return }
        currentPasscode.removeLast()
        passcodeStackView.updateDots(filledCount: currentPasscode.count)
    }
}
