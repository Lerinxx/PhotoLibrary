import UIKit
import SnapKit

class LibraryViewController: UIViewController {
    
    private let addPhotoBtn: AddPhotoBtn = {
       let btn = AddPhotoBtn()
        return btn
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
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
