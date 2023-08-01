//
//  ForgotVC.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 28/06/2023.
//

import UIKit

class ForgotVC: BaseView {
    
    @IBOutlet weak var userNameTF: CustomTextBox!
    @IBOutlet weak var submitBtn: FilledButton!
    
    var forgotParam: forgotParams {
        return forgotParams(email: userNameTF.textField.text ?? "")
    }
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.viewModel = ForgotViewModel(binding: self)
        setupView()
    }
    
    
    // MARK: Setup Button
    private func setupView(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        bindSignupViewModel()
        setTextFields()
        addGradient()
        submitBtn.setTitle("Submit", for: .normal)
    }
    
    // MARK: Setup views
    private func setTextFields(){
        self.userNameTF.setTextFieldView(placeholder: "Email Address", imageName: "", placeHolderColor: UIColor.lightGray, validation: .email)
        
    }
    
    // MARK: - Bind ViewModels
    private func bindSignupViewModel() {
        (viewModel as! ForgotViewModel).email = userNameTF.viewModel
    }
    
    @IBAction func submit(_ sender: FilledButton) {
        (viewModel as! ForgotViewModel).forgot(params: forgotParam)
        
    }
    
    @IBAction func back(_ sender: FilledButton) {
        self.navigationController?.popViewController(animated: true)
    }
}

// MARK: - Forgot View Model Delegate
extension ForgotVC: ForgotViewDelegate {
    func forgot(message: String) {
        Helper.getInstance.showAlert(title: "Success", message: message)
    }
    
    func forgotError(message: String) {
        Helper.getInstance.showAlert(title: "Error", message: message)
    }
}

// MARK: - Extension Gradient / Alert
extension ForgotVC {
    private func addGradient() {
        view.backgroundColor = .white
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor(named: "White")!.cgColor, UIColor(named: "Yellow")!.cgColor]
        gradientLayer.locations = [0.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.frame = view.frame
        view.layer.insertSublayer(gradientLayer, at: 0)
    }
}

extension String {
    var isValidEmail: Bool {
        NSPredicate(format: "SELF MATCHES %@", "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}").evaluate(with: self)
    }
}
