import UIKit
import SnapKit

class LibraryViewController: UIViewController {
    
    private let addPhotoBtn: AddPhotoBtn = {
       let btn = AddPhotoBtn()
        return btn
    }()
    
    // change later
    private let viewBtn: UIButton = {
        let btn = UIButton()
        btn.backgroundColor = Constants.pinkColor
        btn.setTitleColor(.black, for: .normal)
        btn.setTitle("View photos", for: .normal)
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        
        // change later
        view.addSubview(viewBtn)
        viewBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.height.equalTo(50)
            make.centerX.equalToSuperview()
            make.bottom.equalToSuperview().offset(-50)
        }
        let viewAction = UIAction { _ in
            self.viewBtnPressed()
        }
        viewBtn.addAction(viewAction, for: .touchUpInside)
    }
    
    //change later
    private func viewBtnPressed() {
        let controller = PhotoViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func configUI() {
        view.backgroundColor = .white
        view.addSubview(addPhotoBtn)
        
        addPhotoBtn.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.9)
            make.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
            make.centerX.equalToSuperview()
        }
        
        let nextControllerAction = UIAction { _ in
            self.addPhotoBtnPressed()
        }
        addPhotoBtn.addAction(nextControllerAction, for: .touchUpInside)
    }
    
    private func addPhotoBtnPressed() {
        let controller = AddPhotoViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
}
