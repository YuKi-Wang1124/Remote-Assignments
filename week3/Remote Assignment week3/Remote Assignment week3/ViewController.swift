import UIKit

class ViewController: UIViewController {
    
    let loginRegisterSegment = CustomSegmentControl(items: ["Log In", "Sign up"])
    let grayView = UIView()
    let button = UIButton()
    var checkLabel = UILabel()
    var accountTextField = UITextField()
    var passwordTextField = UITextField()
    var checkTextField = UITextField()
    let tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        accountTextField.delegate = self
        passwordTextField.delegate = self
        checkTextField.delegate = self
        
        setUI()
        loginRegisterSegment.addTarget(self, action: #selector(changeSelection(_:)), for: .valueChanged)
        button.addTarget(self, action: #selector(checkMember(_:)), for: .touchUpInside)
        tapGesture.addTarget(self, action: #selector(hideKeyboard))
    }
    
    @objc func checkMember(_ sender: UIButton) {
        if accountTextField.text == "" {
            presentAlert(title: "Error", message: "Account should not be empty.")
        }
        if passwordTextField.text == ""  {
            presentAlert(title: "Error", message: "Password should not be empty.")
        }
        switch loginRegisterSegment.selectedSegmentIndex {
        case 0:
            if accountTextField.text?.trimmingCharacters(in: .whitespaces) == "appworks_school"
                && passwordTextField.text?.trimmingCharacters(in: .whitespaces) == "1234" {
                presentAlert(title: "Success", message: "Log in Successfully!")
            } else {
                presentAlert(title: "Error", message: "Login fail")
            }
        case 1:
            if checkTextField.text == "" {
                presentAlert(title: "Error", message: "Check Password should not be empty.")
            } else if passwordTextField.text?.trimmingCharacters(in: .whitespaces) != checkTextField.text?.trimmingCharacters(in: .whitespaces) {
                presentAlert(title: "Error", message: "Signup Fail \n Check Password is not equal to Psaaword.")
            } else {
                presentAlert(title: "Success", message: "Sign up successfully!")
            }
        default:
            fatalError("Error")
        }
    }
                
    @objc func changeSelection(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            checkLabel.textColor = .gray
            checkTextField.backgroundColor = .gray
            checkTextField.isUserInteractionEnabled = false
            emptyTextField()
        case 1:
            checkLabel.textColor = .black
            checkTextField.backgroundColor = .white
            checkTextField.isUserInteractionEnabled = true
            grayView.tag = 4
            emptyTextField()
        default:
            fatalError()
        }
    }
    
    @objc func hideKeyboard() {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        checkTextField.resignFirstResponder()
    }
    
    func setUI() {
        grayView.backgroundColor = .systemGray3
        
        let titleLabel = createLabel(text: "AppWorks School", fontSize: 40)
        let accountLabel = createLabel(text: "Account")
        let passwordLabel = createLabel(text: "Password")
        checkLabel = createLabel(text: "Check", textColor: .gray)
        passwordLabel.setContentHuggingPriority(.required, for: .horizontal)
        passwordLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        
        accountTextField = setCustomTextField(textField: accountTextField, tag: 1)
        passwordTextField = setCustomTextField(textField: passwordTextField, tag: 2)
        checkTextField = setCustomTextField(textField: checkTextField, tag: 3)
        checkTextField.backgroundColor = .gray
        checkTextField.isUserInteractionEnabled = false
       
        button.setTitle("Button", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        
        var accountStackView = UIStackView()
        var passwordStackView = UIStackView()
        var checkstackView = UIStackView()
        let grayStackView = UIStackView()
        accountStackView = addHorizontalStackView(add: accountLabel, and: accountTextField, to: accountStackView)
        passwordStackView = addHorizontalStackView(add: passwordLabel, and: passwordTextField, to: passwordStackView)
        passwordStackView.spacing = 8
        checkstackView = addHorizontalStackView(add: checkLabel, and: checkTextField, to: checkstackView)
        grayStackView.distribution = .fillEqually
        grayStackView.axis = .vertical
        grayStackView.spacing = 8
        grayStackView.addArrangedSubview(accountStackView)
        grayStackView.addArrangedSubview(passwordStackView)
        grayStackView.addArrangedSubview(checkstackView)
        
        grayView.addSubview(grayStackView)
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(loginRegisterSegment)
        view.addSubview(grayView)
        view.addSubview(button)
        view.addGestureRecognizer(tapGesture)
        
        let autolayoutObjects = [titleLabel, button, accountStackView, passwordStackView, checkstackView, grayStackView, grayView, accountTextField, passwordTextField, checkTextField]
        autolayoutObjects.forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
        }
        
        NSLayoutConstraint.activate(
            [
                titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 80),
                titleLabel.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                
                loginRegisterSegment.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 70),
                loginRegisterSegment.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                loginRegisterSegment.widthAnchor.constraint(equalToConstant: 150),
                
                grayView.widthAnchor.constraint(equalToConstant: 255),
                grayView.heightAnchor.constraint(equalToConstant: 125),
                grayView.topAnchor.constraint(equalTo: loginRegisterSegment.bottomAnchor, constant: 40),
                grayView.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
                
                grayStackView.topAnchor.constraint(equalTo: grayView.topAnchor, constant: 8),
                grayStackView.bottomAnchor.constraint(equalTo: grayView.bottomAnchor, constant: -8),
                grayStackView.leadingAnchor.constraint(equalTo: grayView.leadingAnchor, constant: 8),
                grayStackView.trailingAnchor.constraint(equalTo:grayView.trailingAnchor, constant: -8),
                
                accountTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
                checkTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
                
                button.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 50),
                button.widthAnchor.constraint(equalToConstant: 235),
                button.heightAnchor.constraint(equalToConstant: 30),
                button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ]
        )
    }
    
    func createLabel(text: String, textColor: UIColor = .black, fontSize: CGFloat = 17) -> UILabel {
        let label = UILabel()
        label.text = text
        label.textColor = textColor
        label.font = UIFont.systemFont(ofSize: fontSize)
        
        return label
    }
    
    func setCustomTextField(textField: UITextField, tag: Int) -> UITextField {
        textField.backgroundColor = .white
        textField.borderStyle = .roundedRect
        textField.keyboardType = .asciiCapable
        textField.tag = tag
        
        return textField
    }
    
    func emptyTextField() {
        self.accountTextField.text = ""
        self.passwordTextField.text = ""
        self.checkTextField.text = ""
    }
    
    func addHorizontalStackView(add label: UILabel, and textField: UITextField, to stackView: UIStackView) -> UIStackView {
        stackView.alignment = .fill
        stackView.axis = .horizontal
        stackView.addArrangedSubview(label)
        stackView.addArrangedSubview(textField)
        
        return stackView
    }
    
    func presentAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert) {
        var alert = UIAlertController()
        var alertAction = UIAlertAction()
        alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertAction = UIAlertAction(title: "OK", style: .default, handler: { [self] _ in
            emptyTextField()
        })
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
}


extension ViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if let nextTextField = view.viewWithTag(textField.tag + 1) {
            textField.resignFirstResponder()
            nextTextField.becomeFirstResponder()
        }
        
        return true
    }
}

// 可用於確認 textfield 是否包含某些字元
extension UITextField {
    @discardableResult
    func textContained(in element: String) -> Bool {
        guard let textFieldText = self.text else { return false }
        
        let isContained = element.contains(textFieldText)
        if isContained { print("\(element) contains \(textFieldText)") }
        return  isContained
    }
}

