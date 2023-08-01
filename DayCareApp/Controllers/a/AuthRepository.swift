//
//  File.swift
//  WIT
//
//  Created by iOS Developer-APPS on 17/05/2021.
//

import Foundation
import Reachability

class AuthRepository: BaseRepository {
    
    //MARK:- Variables:
    private var AuthRDS: AuthRemoteDataSource!
    
    //initilizer:
    override init() {
        super.init()
        AuthRDS = AuthRemoteDataSource()
    }
    
    //Login & Get Access Token:
    func login(dic:[String:Any], completion: @escaping (Token?) -> (), errorCompletion: @escaping (ServerErrorResponse?, String?) -> () ) {
        
        AuthRDS.login(dic: dic) {
            (token, failure) in
            
            guard failure == nil else {
                self.switchFailure(failure!, errorCompletion: errorCompletion)
                return
            }
            Router.configuration = RouterConfiguration.init(baseURL: Environment.baseUrl, authorizationToken: token?.access_token)
            self.AuthLDS.saveToken(token!)
            completion(token)
        }
    }
   
    //Forgot Password:
    func forgotPassword(dic:[String:Any], completion: @escaping (ForgotPassword?) -> (), errorCompletion: @escaping (ServerErrorResponse?, String?) -> ()) {
        
        AuthRDS.forgotPassword(dic: dic) {
            (response, failure) in
            
            guard failure == nil else {
                self.switchFailure(failure!, errorCompletion: errorCompletion)
                return
            }
            completion(response)
        }
    }
    
    //Create New Password:
    func createNewPassword(dic: [String: Any], completion: @escaping (ServerMessageResponse?) -> (), errorCompletion: @escaping
                            (ServerErrorResponse?, String?) -> ()) {
        AuthRDS.createNewPassword(dic: dic) { (response, failure) in
            guard failure == nil else{
                self.switchFailure(failure!, errorCompletion: errorCompletion)
                return
            }
            completion(response)
        }
    }
}
