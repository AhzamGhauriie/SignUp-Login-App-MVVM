//
//  ForgotViewModel.swift
//  DayCareApp
//
//  Created by Ahzam Ghori on 01/07/2023.
//

import Foundation

//MARK: - Protocols
protocol ForgotViewDelegate: AnyObject {
    func forgot(message: String)
    func forgotError(message: String)
}

class ForgotViewModel: BaseViewModel {
    
    // MARK: - Variables:
    private var authenticationRepository: AuthRepository = AuthRepository()
    
    var email: TextBoxViewModel!
    weak var delegate: ForgotViewDelegate!
    
    // MARK: - initilizer:
    init(binding : ForgotViewDelegate) {
        super.init()
        self.delegate = binding
    }
    
    // MARK: - SignIn User
    func forgot(params: forgotParams) {
        guard self.isValidate() else {
            return
        }
        forgotPressed(params: params)
    }
    
    // MARK: - Functions:
    // MARK: - Login api calling:
    func forgotPressed(params: forgotParams) {
        
        self.isLoading = true
        
        let dict: [String: Any] =  ["email": params.email]
        
        authenticationRepository.forgot(dic: dict, completion:  { user  in
            self.delegate.forgot(message: "Email Sent Successfully!")
        }, errorCompletion: { errorBlock, message in
            self.isLoading = false
        })
    }
    
    // TextFields Validation:
    private func isValidate() -> Bool{
        if !email.validate() {
            return false
        }
        return true
    }
}

struct forgotParams {
    var email: String
}
