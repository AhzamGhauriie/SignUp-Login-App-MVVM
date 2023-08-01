//
//  SignUpVc.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 28/06/2023.
//

import UIKit

class SignUpVC: BaseView {
    
    @IBOutlet weak var userNameTF: CustomTextBox!
    @IBOutlet weak var passwordTF: CustomTextBox!
    @IBOutlet weak var confirmPasswordTF: CustomTextBox!
    @IBOutlet weak var logInBtn: BorderButton!
    @IBOutlet weak var signUpBtn: FilledButton!
    
    var signupParams: SignupParams {
        return SignupParams(email: userNameTF.textField.text ?? "", password: passwordTF.textField.text ?? "", confirmPassword: confirmPasswordTF.textField.text ?? "")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        addGradient()
        self.viewModel = SignUpViewModel(binding: self)
        setupView()
    }
    
    // MARK: Setup Button
    private func setupView(){
        bindSignupViewModel()
        setTextFields()
        logInBtn.setTitle("Log in", for: .normal)
        signUpBtn.setTitle("Sign up", for: .normal)
        self.navigationItem.setHidesBackButton(true, animated: true)
    }
    
    // MARK: Setup views
    private func setTextFields(){
        self.userNameTF.setTextFieldView(placeholder: "Email Address", imageName: "", placeHolderColor: UIColor.lightGray, validation: .email)
        self.passwordTF.setTextFieldView(placeholder: "Password", imageName: "", placeHolderColor: UIColor.lightGray, validation: .password)
        self.confirmPasswordTF.setTextFieldView(placeholder: "Confirm Password", imageName: "", placeHolderColor: UIColor.lightGray, validation: .password)
        
        signUpBtn.layer.cornerRadius = 25
    }
    
    // MARK: - Bind ViewModels
    private func bindSignupViewModel() {
        (viewModel as! SignUpViewModel).email = userNameTF.viewModel
        (viewModel as! SignUpViewModel).password = passwordTF.viewModel
        (viewModel as! SignUpViewModel).confirmPassword = confirmPasswordTF.viewModel
    }
    
    @IBAction func loginTapped(_ sender: FilledButton) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func signUpTapped(_ sender: BorderButton) {
        (viewModel as! SignUpViewModel).signupUser(params: signupParams)
    }
    
    @IBAction func guestTapped(_ sender: Any) {  }
}

// MARK: - Signup View Model Delegate
extension SignUpVC: SignUpViewDelegate {
    func signUp(message: String) {
        Helper.getInstance.showAlert(title: "Success", message: message)
    }
    
    func signUperror(message: String) {
        Helper.getInstance.showAlert(title: "Error", message: message)
    }
}

// MARK: - Extension Gradient / Alert
extension SignUpVC {
    func addGradient() {
       
       // basic setup
       view.backgroundColor = .white
       
       // Create a new gradient layer
       let gradientLayer = CAGradientLayer()
       // Set the colors and locations for the gradient layer
       gradientLayer.colors = [UIColor(named: "White")!.cgColor, UIColor(named: "Yellow")!.cgColor]
       gradientLayer.locations = [0.0]
       
       // Set the start and end points for the gradient layer
       gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
       gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
       
       // Set the frame to the layer
       gradientLayer.frame = view.frame
       
       // Add the gradient layer as a sublayer to the background view
       view.layer.insertSublayer(gradientLayer, at: 0)
   }
}
