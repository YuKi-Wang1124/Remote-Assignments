

import UIKit

class AddNewBookTableViewController: UITableViewController {
    let book: Book

    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookAuthorTextField: UITextField!
    @IBOutlet weak var newBookImageView: UIImageView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        newBookImageView.layer.cornerRadius = 16
    }

    @IBAction func getBookTitle(_ sender: UITextField) {
//        self.book.title = sender.text!
    }

    @IBAction func getAuthorName(_ sender: UITextField) {
//        self.book.author = sender.text!
    }
    
    @IBAction func openCarmera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
}

extension AddNewBookTableViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newBookImageView.image = selectedImage
            Library.saveImage(selectedImage, forBook: book)
        } else { return }
        dismiss(animated: true)
    }
}

extension AddNewBookTableViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bookTitleTextField {
            return bookAuthorTextField.becomeFirstResponder()
        } else {
            return bookTitleTextField.resignFirstResponder()
        }
    }
}
