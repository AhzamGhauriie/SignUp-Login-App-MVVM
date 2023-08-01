//
//  LogInViewModel.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 30/06/2023.
//


import Foundation

//MARK: - Protocols
protocol LoginViewDelegate: AnyObject {
    func login(message: String)
    func error(message: String)
}

class LogInViewModel: BaseViewModel {
    
    // MARK: - Variables:
    private var authenticationRepository: AuthRepository = AuthRepository()
    
    var email: TextBoxViewModel!
    var password: TextBoxViewModel!
    weak var delegate: LoginViewDelegate!
    
    // MARK: - initilizer:
    init(binding : LoginViewDelegate) {
        super.init()
        self.delegate = binding
    }
    
    // MARK: - SignIn User
    func signinUser(params: SigninParams) {
        guard self.isValidate() else {
            return
        }
        signInPressed(params: params)
    }
    
    // MARK: - Functions:
    // MARK: - Login api calling:
    func signInPressed(params: SigninParams) {
        self.isLoading = true
        
        let dict: [String: Any] =  ["email": params.email, "password": params.password]
        
        authenticationRepository.login(dic: dict, completion:  { user  in
            self.delegate.login(message: "Logged in Successfully!")
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
        return true
    }
}

struct SigninParams {
    let email, password: String
}
