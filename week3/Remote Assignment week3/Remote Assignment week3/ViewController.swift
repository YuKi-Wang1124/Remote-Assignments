import UIKit

class ViewController: UIViewController {
    
    let titleLabel = UILabel()
    let loginRegisterSegment = CustomSegmentControl(items: ["Log In", "Sign up"])
    let button = UIButton()
    
    let accountStackView = UIStackView()
    let passwordStackView = UIStackView()
    let checktackView = UIStackView()
    let grayStackView = UIStackView()
    let grayView = UIView()
    
    let accountLabel = UILabel()
    let passwordLabel =  UILabel()
    let checkLabel = UILabel()
    
    var accountTextField = UITextField()
    var passwordTextField = UITextField()
    var checkTextField = UITextField()

    var alert = UIAlertController()
    var alertAction = UIAlertAction()
    
    let tapGesture = UITapGestureRecognizer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                    
        accountTextField.tag = 1
        passwordTextField.tag = 2
        checkTextField.tag = 3
        accountTextField.delegate = self
        passwordTextField.delegate = self
        checkTextField.delegate = self
        
        view.addGestureRecognizer(tapGesture)
        
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
        
        if loginRegisterSegment.selectedSegmentIndex == 0 {
            if accountTextField.text?.trimmingCharacters(in: .whitespaces) == "appworks_school" && passwordTextField.text?.trimmingCharacters(in: .whitespaces) == "1234" {
                presentAlert(title: "Success", message: "Log in Successfully!")
            } else {
                presentAlert(title: "Error", message: "Login fail")
            }
        } else if loginRegisterSegment.selectedSegmentIndex == 1 {
            if checkTextField.text == "" {
                presentAlert(title: "Error", message: "Check Password should not be empty.")
            } else if passwordTextField.text?.trimmingCharacters(in: .whitespaces) != checkTextField.text?.trimmingCharacters(in: .whitespaces) {
                presentAlert(title: "Error", message: "Signup Fail \n Check Password is not equal to Psaaword.")
            } else {
                presentAlert(title: "Success", message: "Sign up successfully!")
            }
        }
    }
                
    @objc func changeSelection(_ sender: UISegmentedControl!) {
        switch sender.selectedSegmentIndex {
        case 0:
            checkLabel.textColor = .gray
            checkTextField.backgroundColor = .gray
            checkTextField.isUserInteractionEnabled = false
            
            accountTextField.text = ""
            passwordTextField.text = ""
            checkTextField.text = ""
            
        case 1:
            checkLabel.textColor = .black
            checkTextField.backgroundColor = .white
            checkTextField.isUserInteractionEnabled = true
            
            grayView.tag = 4
            
            accountTextField.text = ""
            passwordTextField.text = ""
            checkTextField.text = ""
            
        default:
            fatalError()
        }
    }
    
    @objc func hideKeyboard() {
        accountTextField.resignFirstResponder()
        passwordTextField.resignFirstResponder()
        checkTextField.resignFirstResponder()
    }
    
    func presentAlert(title: String, message: String, preferredStyle: UIAlertController.Style = .alert) {
        alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alertAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(alertAction)
        present(alert, animated: true)
    }
    
    func setUI() {
        let autolayoutObjects = [titleLabel, button, accountLabel, passwordLabel, checkLabel, accountTextField, passwordTextField, checkTextField, accountStackView, passwordStackView, checktackView, grayStackView, grayView]
        
        for i in autolayoutObjects {
            i.translatesAutoresizingMaskIntoConstraints = false
        }
        
        titleLabel.text = "AppWorks School"
        titleLabel.font = UIFont.systemFont(ofSize: 40)
        titleLabel.textColor = .black
        
        grayView.backgroundColor = .systemGray3
        
        button.setTitle("Button", for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black
        
        configureStackView()
        
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        view.addSubview(loginRegisterSegment)
        view.addSubview(grayView)
        view.addSubview(button)
        
        setConstraint()
    }
    
    func configureStackView() {
        accountLabel.text = "Account"
        accountTextField.backgroundColor = .white
        accountTextField.borderStyle = .roundedRect
        accountStackView.alignment = .fill
        accountStackView.axis = .horizontal
        accountStackView.addArrangedSubview(accountLabel)
        accountStackView.addArrangedSubview(accountTextField)
        
        passwordLabel.setContentHuggingPriority(.required, for: .horizontal)
        passwordLabel.setContentCompressionResistancePriority(.required, for: .horizontal)
        passwordLabel.text = "Password"
        passwordTextField.backgroundColor = .white
        passwordTextField.borderStyle = .roundedRect
        passwordStackView.alignment = .fill
        passwordStackView.axis = .horizontal
        passwordStackView.addArrangedSubview(passwordLabel)
        passwordStackView.addArrangedSubview(passwordTextField)
        
        checkLabel.text = "Check"
        checkLabel.textColor = .gray
        checkTextField.backgroundColor = .gray
        checkTextField.borderStyle = .roundedRect
        checkTextField.isUserInteractionEnabled = false
        checktackView.alignment = .fill
        checktackView.axis = .horizontal
        checktackView.addArrangedSubview(checkLabel)
        checktackView.addArrangedSubview(checkTextField)
        
        grayStackView.distribution = .fillEqually
        grayStackView.axis = .vertical
        grayStackView.spacing = 8
        
        grayStackView.addArrangedSubview(accountStackView)
        grayStackView.addArrangedSubview(passwordStackView)
        grayStackView.addArrangedSubview(checktackView)
        
        grayView.addSubview(grayStackView)
    }
    
    func setConstraint() {
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
                
                passwordLabel.trailingAnchor.constraint(equalTo: passwordTextField.leadingAnchor, constant: -8),
                accountTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
                checkTextField.leadingAnchor.constraint(equalTo: passwordTextField.leadingAnchor),
                
                button.topAnchor.constraint(equalTo: grayView.bottomAnchor, constant: 50),
                button.widthAnchor.constraint(equalToConstant: 235),
                button.heightAnchor.constraint(equalToConstant: 30),
                button.centerXAnchor.constraint(equalTo: view.safeAreaLayoutGuide.centerXAnchor),
            ]
        )
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
