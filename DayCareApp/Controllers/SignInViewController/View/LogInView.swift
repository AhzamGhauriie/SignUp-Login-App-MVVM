//
//  LogInView.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 28/06/2023.
//

import UIKit

class LogInView: BaseView {
    
    // MARK: - Variables
    @IBOutlet weak var userNameTF: CustomTextBox!
    @IBOutlet weak var passwordTF: CustomTextBox!
    @IBOutlet weak var logInBtn: FilledButton!
    @IBOutlet weak var signUpBtn: BorderButton!
    
    var signupParams: SigninParams {
        return SigninParams(email: userNameTF.textField.text ?? "", password: passwordTF.textField.text ?? "")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = LogInViewModel(binding: self)
        setupView()
    }
    
    // MARK: Setup Button
    private func setupView(){
        bindSignupViewModel()
        setTextFields()
        addGradient()
        logInBtn.setTitle("Log in", for: .normal)
        signUpBtn.setTitle("Sign up", for: .normal)
    }
    
    // MARK: Setup views
    private func setTextFields(){
        self.userNameTF.setTextFieldView(placeholder: "Email Address", imageName: "", placeHolderColor: UIColor.lightGray, validation: .email)
        self.passwordTF.setTextFieldView(placeholder: "Password", imageName: "", placeHolderColor: UIColor.lightGray, validation: .password)
        signUpBtn.layer.cornerRadius = 25
    }
    
    // MARK: - Bind ViewModels
    private func bindSignupViewModel() {
        (viewModel as! LogInViewModel).email = userNameTF.viewModel
        (viewModel as! LogInViewModel).password = passwordTF.viewModel
    }
    
    // MARK: - Login Tapped
    @IBAction func loginTapped(_ sender: FilledButton) {
        (viewModel as! LogInViewModel).signinUser(params: signupParams)
    }
    
    // MARK: - Signup Tapped
    @IBAction func signUpTapped(_ sender: BorderButton) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "SignUpVC") as? SignUpVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
    
    // MARK: - Forgot Tapped
    @IBAction func forgotTapped(_ sender: Any) {
        let vc = UIStoryboard.init(name: "Main", bundle: Bundle.main).instantiateViewController(withIdentifier: "ForgotVC") as? ForgotVC
        self.navigationController?.pushViewController(vc!, animated: true)
    }
}

// MARK: - Login View Model Delegate
extension LogInView: LoginViewDelegate {
    func error(message: String) {
        Helper.getInstance.showAlert(title: "Error", message: message)
    }
    
    func login(message: String) {
        Helper.getInstance.showAlert(title: "Success", message: message)
    }
}

// MARK: - Extension Gradient / Alert
extension LogInView {
    private func addGradient() {
        view.backgroundColor = .clear
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "White")!.cgColor, UIColor(named: "Yellow")!.cgColor]
        gradientLayer.locations = [0.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

