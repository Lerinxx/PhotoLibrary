import UIKit

class PhotoViewController: UIViewController {
    
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

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        let images = StorageManager.shared.loadImages()
        if let lastImage = images.last,
           let image = StorageManager.shared.loadImage(fileName: lastImage.imageName) {
            photoView.image = image
            textField.text = lastImage.text
            dateLabel.updateDate(with: lastImage.date)
        }
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
            make.top.equalTo(additionalSafeAreaInsets.top).offset(35)
            make.height.equalTo(140)
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
            make.top.equalToSuperview().offset(50)
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
    }
    

}
