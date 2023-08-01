//
//  SignUpViewModel.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 01/07/2023.
//

import Foundation


// MARK: - Protocols
protocol SignUpViewDelegate: AnyObject {
    func signUp(message: String)
    func signUperror(message: String)
}

class SignUpViewModel: BaseViewModel {
    
    // MARK: - Variables:
    private var authenticationRepository: AuthRepository = AuthRepository()
    
    var email: TextBoxViewModel!
    var password: TextBoxViewModel!
    var confirmPassword: TextBoxViewModel!
    weak var delegate: SignUpViewDelegate!
    
    // MARK: - initilizer:
    init(binding : SignUpViewDelegate) {
        super.init()
        self.delegate = binding
    }
    
    // MARK: - SignIn User
    func signupUser(params: SignupParams) {
        guard self.isValidate() else {
            return
        }
        
        if params.password != params.confirmPassword {
            self.delegate.signUperror(message: "Password and Confirm Password Doesnot Match!")
            return
        }
        signUpPressed(params: params)
    }
    
    // MARK: - Functions:
    // MARK: - Login api calling:
    func signUpPressed(params: SignupParams) {
       self.isLoading = true
        
        let dict: [String: Any] =  ["email": params.email, "password": params.password]
        
        authenticationRepository.signUp(dic: dict, completion:  { user  in
            self.delegate.signUp(message: "Sign up Successfully!")
        }, errorCompletion: { errorBlock, message in
            self.isLoading = false
        })
    }
    
    // TextFields Validation:
    private func isValidate() -> Bool{
        if !email.validate() {
            return false
        }
        if !password.validate() {
            return false
        }
        if !confirmPassword.validate() {
            return false
        }
        return true
    }
}

struct SignupParams {
    let email, password, confirmPassword: String
}
