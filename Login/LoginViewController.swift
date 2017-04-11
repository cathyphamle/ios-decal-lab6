//
//  LoginViewController.swift
//  Login
//
//  Created by Paige Plander on 4/5/17.
//  Copyright © 2017 Paige Plander. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    // Constants used in the LoginViewController
    struct Constants {
        static let backgroundColor: UIColor = UIColor(hue: 0.5389, saturation: 1, brightness: 0.92, alpha: 1.0)
        static let invalidEmailTitle = "Invalid username or password"
        static let invalidEmailMessage = "Please try again"
    }

    // TODO: instantiate the views needed for your project
    let loginLabel = UILabel(frame: CGRect(x: 130, y: 50,  width: UIScreen.main.bounds.width - 40,  height: 200))
    let loginText = UITextField(frame: CGRect(x: 10, y: 50,  width: 250,  height: 20) )
    let passwordText = UITextField(frame: CGRect(x: 10, y: 100,  width: 150,  height: 20))
    
    
    var button : UIButton = {
        let loginButton = UIButton()
        
        loginButton.setTitle("Login", for: .normal)
        loginButton.backgroundColor = Constants.backgroundColor
        loginButton.layer.cornerRadius = 10
        loginButton.layer.masksToBounds = true
        
        return loginButton
    }()
    
    var login : UIView = {
        let uiLoginView = UIView()
        
        uiLoginView.backgroundColor = .white
        uiLoginView.layer.cornerRadius = 10
        uiLoginView.layer.masksToBounds = true
        
        return uiLoginView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = Constants.backgroundColor
        view.addSubview(loginLabel)
        view.addSubview(login)
        login.addSubview(loginText)
        login.addSubview(passwordText)
        login.addSubview(button)
        
        loginLabel.text = "Login View Controller"
        loginLabel.textColor = .white
        
        login.frame = CGRect(x: 0, y: 0,  width: UIScreen.main.bounds.width - 16,  height: 200)
        login.center = view.center

        loginText.text = "berkeley.edu account"
        passwordText.text = "Password"
        
        
        button.frame = CGRect(x: 150, y: 150, width: 100, height: 20)
        button.centerXAnchor.constraint(equalTo: login.centerXAnchor)
        button.addTarget(self, action: #selector(validate), for: .touchDown)
        
        // TODO: Add your views either as subviews of `view` or subviews of each other using `addSubview`
        
        // TODO: layout your views using frames or AutoLayout
    }
    
    // TODO: create an IBAction for your login button
    @IBAction func validate(sender: UIButton) {
        let log = loginText.text
        let pas = passwordText.text
        authenticateUser(username: log, password: pas)
    }
    
    
    
    /// YOU DO NOT NEED TO MODIFY ANY OF THE CODE BELOW (but you will want to use `authenticateUser` at some point)
    
    // Model class to handle checking if username/password combinations are valid.
    // Usernames and passwords can be found in the Lab6Names.csv file
    let loginModel = LoginModel(filename: "Lab6Names")

    /// Imageview for login success image (do not need to modify)
    let loginSuccessView = UIImageView(image: UIImage(named: "oski"))
    
    /// If the provided username/password combination is valid, displays an
    /// image (in the "loginSuccessView" imageview). If invalid, displays an alert
    /// telling the user that the login was unsucessful.
    /// You do not need to edit this function, but you will want to use it for the lab.
    ///
    /// - Parameters:
    ///   - username: the user's berkeley.edu address
    ///   - password: the user's first name (what a great password!)
    func authenticateUser(username: String?, password: String?) {
        
        // if username / password combination is invalid, present an alert
        if !loginModel.authenticate(username: username, password: password) {
            loginSuccessView.isHidden = true
            let alert = UIAlertController(title: Constants.invalidEmailTitle, message: Constants.invalidEmailMessage, preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Dismiss", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
            
        // If username / password combination is valid, display success image
        else {
            if !loginSuccessView.isDescendant(of: view) {
                view.addSubview(loginSuccessView)
                loginSuccessView.contentMode = .scaleAspectFill
            }
            
            loginSuccessView.isHidden = false
            
            // Constraints for the login success view
            loginSuccessView.translatesAutoresizingMaskIntoConstraints = false
            loginSuccessView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            loginSuccessView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            loginSuccessView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            loginSuccessView.heightAnchor.constraint(equalToConstant: view.frame.height/4).isActive = true
        }
    }
}
