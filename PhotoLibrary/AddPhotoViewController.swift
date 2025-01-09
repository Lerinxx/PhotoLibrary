import UIKit
import SnapKit

class AddPhotoViewController: UIViewController {
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        
        view.addSubview(topView)
        topView.addSubview(backBtn)
        topView.addSubview(likeBtn)
        view.addSubview(mainView)
        mainView.addSubview(photoView)
        mainView.addSubview(dateLabel)
        
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
            make.top.equalToSuperview().offset(100)
        }
        dateLabel.snp.makeConstraints { make in
            make.width.equalTo(photoView.snp.width)
            make.bottom.equalTo(photoView.snp.top).offset(-16)
            make.centerX.equalToSuperview()
        }
        
        photoView.imageChangedCallback = { [weak self] in
            self?.dateLabel.updateDate()
            self?.dateLabel.isHidden = false
        }
    }
}
