import UIKit
import SnapKit

class LibraryViewController: UIViewController {
    
    private var photos: [UserImage] = []
    private var isShowingLiked = false
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = .zero
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(PhotoCell.self, forCellWithReuseIdentifier: PhotoCell.identifier)
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let addPhotoBtn: AddPhotoBtn = {
        let btn = AddPhotoBtn()
        return btn
    }()
    
    private let seeFavorBtn: UIButton = {
        let btn = UIButton()
        btn.setTitle(Constants.seeFavorText, for: .normal)
        btn.backgroundColor = Constants.pinkColor
        btn.titleLabel?.font = Constants.bodyFont
        btn.layer.cornerRadius = 13
        btn.titleLabel?.textAlignment = .center
        btn.setTitleColor(.black, for: .normal)
        return btn
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadImages()
    }
    
    private func configUI() {
        view.backgroundColor = .white
        view.addSubview(addPhotoBtn)
        view.addSubview(seeFavorBtn)
        view.addSubview(collectionView)
        
        addPhotoBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(100)
            make.top.equalTo(self.view.safeAreaLayoutGuide.snp.top).offset(20)
        }
        seeFavorBtn.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(50)
            make.top.equalTo(addPhotoBtn.snp.bottom).offset(10)
        }
        collectionView.snp.makeConstraints { make in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(seeFavorBtn.snp.bottom).offset(15)
            make.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-15)
        }
        
        let nextControllerAction = UIAction { _ in
            self.addPhotoBtnPressed()
        }
        let seeFavorAction = UIAction { _ in
            self.seeFavorBtnPressed()
        }
        addPhotoBtn.addAction(nextControllerAction, for: .touchUpInside)
        seeFavorBtn.addAction(seeFavorAction, for: .touchUpInside)
    }
    
    private func loadImages() {
        let allPhotos = StorageManager.shared.loadImages()
        photos = isShowingLiked ? allPhotos.filter { $0.isLiked } : allPhotos
        collectionView.reloadData()
    }
    
    private func addPhotoBtnPressed() {
        let controller = AddPhotoViewController()
        navigationController?.pushViewController(controller, animated: true)
    }
    
    private func seeFavorBtnPressed() {
        isShowingLiked.toggle()
        seeFavorBtn.setTitle(isShowingLiked ? Constants.showAllText : Constants.seeFavorText, for: .normal)
        loadImages()
    }
}

extension LibraryViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return photos.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let item = collectionView.dequeueReusableCell(withReuseIdentifier: PhotoCell.identifier, for: indexPath) as? PhotoCell else {
            return UICollectionViewCell()
        }
        item.configCell(with: photos[indexPath.item])
        return item
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let side = (collectionView.bounds.size.width - 10 * 2) / 3
        return CGSize(width: side, height: side)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedImage = photos[indexPath.item]
        let photoController = PhotoViewController(passedImage: selectedImage)
        navigationController?.pushViewController(photoController, animated: true)
    }
}
