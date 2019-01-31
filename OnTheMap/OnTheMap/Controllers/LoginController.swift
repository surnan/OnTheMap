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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.solidOrange
        setupUI()
    }
    
    private func setupUI(){
        let loginStack: UIStackView = {
            let stack = UIStackView()
            stack.axis = .vertical
            stack.spacing = 5
            stack.translatesAutoresizingMaskIntoConstraints = false
            return stack
        }()
        
        [emailTextField, passwordTextField, loginButton].forEach{loginStack.addArrangedSubview($0)}
        
        view.addSubview(loginStack)
        [emailTextField, passwordTextField, loginButton].forEach{$0.heightAnchor.constraint(equalToConstant: customFontSize*2)}
        
        NSLayoutConstraint.activate([
            loginStack.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            loginStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            loginStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            ])
    }
    
    
    func setupTextField()-> UITextField{
        let _textField: UITextField = {
            let textField = UITextField()
            textField.backgroundColor = UIColor.greyOrange
            textField.clearsOnBeginEditing = true
            let textAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.strokeColor : UIColor.white,
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Georgia", size: customFontSize) as Any
            ]
            textField.defaultTextAttributes = textAttributes
            textField.attributedText = NSMutableAttributedString(string: "Password", attributes: textAttributes)
            textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            return textField
        }()
        return _textField
    }
    
    
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
    
    
    func setupTextField(placeholder: String)-> UITextField{
        let _textField: UITextField = {
            let textField = UITextField()
            textField.backgroundColor = UIColor.greyOrange
            textField.clearsOnBeginEditing = true
            let textAttributes: [NSAttributedString.Key: Any] = [
                NSAttributedString.Key.strokeColor : UIColor.white,
                NSAttributedString.Key.foregroundColor : UIColor.white,
                NSAttributedString.Key.font: UIFont(name: "Georgia", size: customFontSize) as Any
            ]
            textField.defaultTextAttributes = textAttributes
            textField.attributedText = NSMutableAttributedString(string: placeholder, attributes: textAttributes)
            textField.layer.sublayerTransform = CATransform3DMakeTranslation(10, 0, 0)
            return textField
        }()
        return _textField
    }
}
