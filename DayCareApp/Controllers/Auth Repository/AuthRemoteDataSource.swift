//
//  AuthRemoteDataSource.swift
//  WIT
//
//  Created by iOS Developer-APPS on 17/05/2021.
//

import Foundation

struct AuthRemoteDataSource {
    
    // MARK: - Login
    func login(dic:[String:Any], completion: @escaping (String?,Failure?) -> ()) {
        
        Router.APIRouter(endPoint: .login, parameters: dic, method: .post) { response in
            switch response {
            case .success(_):
                let succes = "Success"
                completion(succes,nil)
            case .failure(let failure):
                completion(nil,failure)
            }
        }
    }
    
    // MARK: - SignUp:
    func signUp(dic: [String: Any], completion: @escaping (String?, Failure?) -> ()){
        
        Router.APIRouter(endPoint: .login, parameters: dic, method: .post) { response in
            switch response {
            case .success(_):
                let succes = "Signup Success"
                completion(succes,nil)
            case .failure(let failure):
                completion(nil,failure)
            }
        }
    }
    
    // MARK: - Forgot:
    func forgot(dic: [String:Any], completion: @escaping (String?,Failure?) -> ()) {
        
        Router.APIRouter(endPoint: .forgotPassword, parameters: dic, method: .post) { response in
            switch response {
            case .success(_):
                let succes = "Forgot Success"
                completion(succes,nil)
            case .failure(let failure):
                completion(nil,failure)
            }
        }
    }
}
