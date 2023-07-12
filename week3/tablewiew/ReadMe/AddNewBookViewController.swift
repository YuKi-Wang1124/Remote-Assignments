import UIKit

class AddNewBookViewController: UITableViewController {
    
    
    
    
    @IBOutlet weak var bookTitleTextField: UITextField!
    @IBOutlet weak var bookAuthorTextField: UITextField!
    @IBOutlet weak var newBookImageView: UIImageView!
    
    @IBAction func openCarmera(_ sender: Any) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.isSourceTypeAvailable(.camera) ? .camera : .photoLibrary
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true)
    }
    
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
    
  
    
}

extension AddNewBookViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let selectedImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newBookImageView.image = selectedImage
        } else { return }
        dismiss(animated: true)
    }
}

extension AddNewBookViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == bookTitleTextField {
            return bookAuthorTextField.becomeFirstResponder()
        } else {
            return bookTitleTextField.resignFirstResponder()
        }
    }
}
