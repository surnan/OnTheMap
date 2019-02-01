//
//  ViewController.swift
//  OnTheMap
//
//  Created by admin on 1/31/19.
//  Copyright © 2019 admin. All rights reserved.
//

import UIKit

class LoginController: UIViewController {
    
    let customFontSize: CGFloat = 25
    
    
    lazy var emailTextField: UITextField = {
        return setupTextField(placeholder: "Email", size: customFontSize)
    }()
    
    
    lazy var passwordTextField: UITextField = {
        return setupTextField(placeholder: "Password", size: customFontSize)
    }()
    
    
    var loginButton: UIButton = {
        var button = UIButton()
        button.backgroundColor = UIColor.darkOrange
        button.setTitle("Login", for: .normal)
        return button
    }()
    

    
    private func setupUI(){
        let loginStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 5
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        emailTextField.text = "4suresh@gmail.com"
        passwordTextField.text = "atDZ8=Gm%=VU"
        
        [emailTextField, passwordTextField, loginButton].forEach{loginStack.addArrangedSubview($0)}
        [emailTextField, passwordTextField, loginButton].forEach{$0.heightAnchor.constraint(equalToConstant: customFontSize * 2)}
        
        view.addSubview(loginStack)
        NSLayoutConstraint.activate([
            loginStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            ])
        
        
        loginButton.addTarget(self, action: #selector(handleLoginButton(_:)), for: .touchUpInside)
        
        //        ParseClient.getAllStudents(completion: handleTaskForGetResponse(completion:error:))
    }
    
    func handleTaskForGetResponse(completion: AllStudents?, error: Error?){
        print("HI")
    }
    
    
    //MARK:- Actions
    @objc func handleLoginButton(_ sender: UIButton){
        //check that username & password aren't blank
        
        UdacityClient.authenticateSession(name: emailTextField.text!, password: passwordTextField.text!) { (response) in
            if response {
                DispatchQueue.main.async {
                    self.navigationController?.pushViewController(MainTabBarController(), animated: false)
                }
            } else {
                DispatchQueue.main.async {
                    let alertController = UIAlertController(title: "Login Error", message: "Invalid combination for name and password", preferredStyle: .alert)
                    alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self.present(alertController, animated: true)
                }
            }
        }
        
    }

//MARK:- UI Type Definitions
func setupTextField(placeholder: String, size: CGFloat)-> UITextField{
    let _textField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.greyOrange
        textField.clearsOnBeginEditing = true
        let textAttributes: [NSAttributedString.Key: Any] = [
            NSAttributedString.Key.strokeColor : UIColor.white,
            NSAttributedString.Key.foregroundColor : UIColor.white,
            NSAttributedString.Key.font: UIFont(name: "Georgia", size: size) as Any
        ]
        textField.defaultTextAttributes = textAttributes
        textField.attributedText = NSMutableAttributedString(string: placeholder, attributes: textAttributes)
        textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
        return textField
    }()
    return _textField
}
    
    
    
    //MARK:- Swift Override Functions
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.solidOrange
        setupUI()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = true
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        navigationController?.navigationBar.isHidden = false
    }
}
