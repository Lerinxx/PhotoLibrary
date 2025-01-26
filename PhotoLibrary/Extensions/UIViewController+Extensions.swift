import UIKit

extension UIViewController {
    func showPasswordMatchAlert() {
        let alert = UIAlertController(title: "Wrong password", message: "Please try again", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
}

