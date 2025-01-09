import UIKit
import SnapKit

final class PhotoView: UIView {
    
    var imageChangedCallback: (() -> Void)?
    
    private let imageView: UIImageView = {
       let view = UIImageView()
        view.alpha = 0
        view.contentMode = .scaleAspectFill
        view.clipsToBounds = true
        view.layer.cornerRadius = 13
        return view
    }()
    
    private let plusImage: UIImageView = {
        let view = UIImageView()
        view.image = Constants.plusImage
        return view
    }()
    
    private let loadPhotoLabel: UILabel = {
       let label = UILabel()
        label.text = Constants.loadPhotoLabel
        label.textAlignment = .center
        label.font = Constants.bodyFont
        label.textColor = Constants.lightGrayColor
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        configUI()
        configTapGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configUI() {
        self.backgroundColor = Constants.pinkColor
        self.layer.cornerRadius = 13
        
        addSubview(plusImage)
        addSubview(loadPhotoLabel)
        addSubview(imageView)
        
        plusImage.snp.makeConstraints { make in
            make.width.equalTo(80)
            make.height.equalTo(plusImage.snp.width)
            make.center.equalToSuperview()
        }
        loadPhotoLabel.snp.makeConstraints { make in
            make.width.equalToSuperview().multipliedBy(0.8)
            make.top.equalTo(plusImage.snp.bottom).offset(16)
            make.centerX.equalToSuperview()
        }
        imageView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
    }
    
    private func configTapGesture() {
        self.isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(viewTapped))
        self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func viewTapped() {
        showPickerAlert()
    }
    
    private func showPickerAlert() {
        guard let parentViewController = self.parentViewController else { return }
        let alert = UIAlertController(title: "Choose image source", message: nil, preferredStyle: .actionSheet)
        let cameraAction = UIAlertAction(title: "Camera", style: .default) { _ in
            self.showPicker(with: .camera, from: parentViewController)
        }
        let photoLibraryAction = UIAlertAction(title: "Photo Library", style: .default) {_ in
            self.showPicker(with: .photoLibrary, from: parentViewController)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(cameraAction)
        alert.addAction(photoLibraryAction)
        alert.addAction(cancelAction)
        parentViewController.present(alert, animated: true)
    }
    
    private func showPicker(with source: UIImagePickerController.SourceType, from viewController: UIViewController) {
        let picker = UIImagePickerController()
        guard UIImagePickerController.isSourceTypeAvailable(source) else { return }
        picker.sourceType = source
        picker.allowsEditing = true
        picker.delegate = self
        viewController.present(picker, animated: true)
    }
}

extension PhotoView : UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        var chosenImage = UIImage()
        
        if let image = info[.editedImage] as? UIImage {
            chosenImage = image
        } else if let image = info[.originalImage] as? UIImage {
            chosenImage = image
        }
        imageView.image = chosenImage
        imageView.alpha = 1
        imageChangedCallback?()
        picker.dismiss(animated: true)
    }
}

extension UIView {
    var parentViewController: UIViewController? {
        var parentResponder: UIResponder? = self
        while parentResponder != nil {
            parentResponder = parentResponder?.next
            if let viewController = parentResponder as? UIViewController {
                return viewController
            }
        }
        return nil
    }
}
