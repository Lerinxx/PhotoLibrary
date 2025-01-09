import UIKit
import SnapKit

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
    
    private let flipLeftBtn: ArrowBtn = {
        let btn = ArrowBtn()
        return btn
    }()
    
    private let flipRightBtn: ArrowBtn = {
        let btn = ArrowBtn()
        btn.transform = CGAffineTransform(scaleX: -1, y: 1)
        return btn
    }()
    
    private let bottomView: UIView = {
       let view = UIView()
        return view
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
        view.addSubview(bottomView)
        bottomView.addSubview(flipLeftBtn)
        bottomView.addSubview(flipRightBtn)
        
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
        
        bottomView.snp.makeConstraints { make in
            make.width.equalToSuperview()
            make.bottom.equalTo(additionalSafeAreaInsets.bottom).offset(-20)
            make.height.equalTo(100)
        }
        
        flipLeftBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(20)
            make.centerY.equalToSuperview()
        }
        flipRightBtn.snp.makeConstraints { make in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview()
        }
    }
}
