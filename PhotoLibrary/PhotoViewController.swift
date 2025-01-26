import UIKit

class PhotoViewController: UIViewController {
    private let photoFlipper = PhotoFlipper()
    
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
    
    private let photoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
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
    
    private let leftBtn: FlipBtn = {
        let btn = FlipBtn()
        return btn
    }()
    
    private let rightBtn: FlipBtn = {
        let btn = FlipBtn()
        btn.transform = CGAffineTransform(scaleX: -1, y: 1)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        setDefaultImage()
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
        mainView.addSubview(leftBtn)
        mainView.addSubview(rightBtn)
        
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
        leftBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25)
            make.left.equalTo(textField.snp.left)
        }
        rightBtn.snp.makeConstraints { make in
            make.bottom.equalToSuperview().offset(-25)
            make.right.equalTo(textField.snp.right)
        }
        
        let nextAction = UIAction { _ in
            self.rightBtnPressed()
        }
        let previousAction = UIAction { _ in
            self.leftBtnPressed()
        }
        let backAction = UIAction { _ in
            self.backBtnPressed()
        }
        let likeAction = UIAction { _ in
            self.likeBtnPressed()
        }
        
        rightBtn.addAction(nextAction, for: .touchUpInside)
        leftBtn.addAction(previousAction, for: .touchUpInside)
        backBtn.addAction(backAction, for: .touchUpInside)
        likeBtn.addAction(likeAction, for: .touchUpInside)
    }
    
    private func setDefaultImage() {
        let images = StorageManager.shared.loadImages()
        if let lastImage = images.last,
           let image = StorageManager.shared.loadImage(fileName: lastImage.imageName) {
            photoView.image = image
            textField.text = lastImage.text
            dateLabel.updateDate(with: lastImage.date)
            likeBtn.setLikeState(lastImage.isLiked)
        }
    }
    
    private func updateUIImage() {
        guard let currentImage = photoFlipper.getCurrentImage() else { return }
        if let image = StorageManager.shared.loadImage(fileName: currentImage.imageName) {
            photoView.image = image
        }
        dateLabel.updateDate(with: currentImage.date)
        textField.text = currentImage.text
        likeBtn.setLikeState(currentImage.isLiked)
    }
    
    private func rightBtnPressed() {
        if let _ = photoFlipper.flipImage(to: .right) {
            updateUIImage()
        }
    }
    
    private func leftBtnPressed() {
        if let _ = photoFlipper.flipImage(to: .left) {
            updateUIImage()
        }
    }
    
    private func backBtnPressed() {
        navigationController?.popViewController(animated: true)
    }
    
    private func likeBtnPressed() {
        likeBtn.toggleLike()
        if let currentImage = photoFlipper.getCurrentImage() {
            currentImage.isLiked = likeBtn.isSelected
            StorageManager.shared.saveImage(currentImage)
        }
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
    
    private func saveNewDescription() {
        if let currentImage = photoFlipper.getCurrentImage() {
            let newText = textField.text ?? ""
            if newText != currentImage.text {
                currentImage.text = newText
                StorageManager.shared.saveImage(currentImage)
            }
        }
    }
    
    @objc func tapDetected() {
        view.endEditing(true)
        saveNewDescription()
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
}
