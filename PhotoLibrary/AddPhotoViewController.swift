import UIKit
import SnapKit

class AddPhotoViewController: UIViewController {
    private var savedDate: Date?
    
    private let backBtn: BackBtn = {
        let btn = BackBtn()
        return btn
    }()
    
    private let likeBtn: LikeBtn = {
        let btn = LikeBtn()
        return btn
    }()
    
    private let topView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let mainView: UIView = {
        let view = UIView()
        return view
    }()
    
    private let photoView: PhotoView = {
        let view = PhotoView()
        return view
    }()
    
    private let dateLabel: DateLabel = {
        let label = DateLabel()
        return label
    }()
    
    private let textField: DescriptionTextField = {
        let textField = DescriptionTextField()
        return textField
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configKeyboardChanges()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.addSubview(backBtn)
        topView.addSubview(likeBtn)
        view.addSubview(mainView)
        mainView.addSubview(photoView)
        mainView.addSubview(dateLabel)
        mainView.addSubview(textField)
        
        topView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide.snp.top)
            make.height.equalTo(100)
        }
        backBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(25)
            make.top.equalToSuperview().offset(35)
        }
        likeBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-25)
            make.top.equalToSuperview().offset(35)
        }
        mainView.snp.makeConstraints { make in
            make.top.equalTo(topView.snp.bottom)
            make.bottom.equalToSuperview()
            make.width.equalToSuperview()
        }
        photoView.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(photoView.snp.width)
            make.centerX.equalToSuperview()
            make.top.equalToSuperview().offset(40)
        }
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(photoView.snp.width)
            make.bottom.equalTo(photoView.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        textField.snp.makeConstraints { make in
            make.width.equalTo(photoView.snp.width)
            make.height.equalTo(50)
            make.top.equalTo(photoView.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        photoView.imageChangedCallback = { [weak self] in
            guard let self = self else { return }
            self.savedDate = Date()
            if let date = self.savedDate {
                self.dateLabel.updateDate(with: date)
            }
        }
        
        let backAction = UIAction { _ in
            self.backBtnPressed()
        }
        backBtn.addAction(backAction, for: .touchUpInside)
        
        let likeAction = UIAction { _ in
            self.likeBtnPressed()
        }
        likeBtn.addAction(likeAction, for: .touchUpInside)
    }
    
    private func configKeyboardChanges() {
        let tapRecognizer = UITapGestureRecognizer(target: self, action: #selector(tapDetected))
        view.addGestureRecognizer(tapRecognizer)
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardChangedFrame),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardChangedFrame),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    @objc func tapDetected() {
        view.endEditing(true)
    }
    
    @objc func keyboardChangedFrame(_ notification: Notification) {
        guard let info = notification.userInfo,
              let duration = (info[UIResponder.keyboardAnimationDurationUserInfoKey] as? NSNumber)?.doubleValue,
              let frame = (info[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        
        var offset: CGFloat = 0
        if notification.name == UIResponder.keyboardWillHideNotification {
            offset = 0
        } else if notification.name == UIResponder.keyboardWillShowNotification {
            offset = -frame.height
        }
        
        mainView.snp.updateConstraints { make in
            make.top.equalTo(topView.snp.bottom).offset(offset)
            make.bottom.equalToSuperview().offset(offset)
        }
        
        UIView.animate(withDuration: duration) {
            self.view.layoutIfNeeded()
        }
    }
    
    private func backBtnPressed() {
        if let image = photoView.image, let date = savedDate {
            guard let imageName = StorageManager.shared.saveImage(image) else { return }
            let text = textField.text ?? ""
            let imageObject = UserImage(imageName: imageName, text: text, date: date, isLiked: likeBtn.isSelected)
            StorageManager.shared.saveImage(imageObject)
            
            let controller = PhotoViewController()
            navigationController?.pushViewController(controller, animated: true)
        } else {
            navigationController?.popToRootViewController(animated: true)
        }
    }
    
    private func likeBtnPressed() {
        likeBtn.toggleLike()
    }
}
