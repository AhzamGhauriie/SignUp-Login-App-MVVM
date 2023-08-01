//
//  File.swift
//  WIT
//
//  Created by iOS Developer-APPS on 17/05/2021.
//

import Foundation


class AuthRepository: BaseRepository {
    
    //MARK: - Variables:
    private var AuthRDS: AuthRemoteDataSource!
    
    //initilizer:
    override init() {
        super.init()
        AuthRDS = AuthRemoteDataSource()
    }
    
    //MARK: - Login
    func login(dic:[String:Any], completion: @escaping (String?) -> (), errorCompletion: @escaping (ServerErrorResponse?, String?) -> () ) {
        
        AuthRDS.login(dic: dic) {
            (succes, failure) in
            
            guard failure == nil else {
                self.switchFailure(failure!, errorCompletion: errorCompletion)
                return
            }
            
            DispatchQueue.main.async {
                completion(succes)
            }
        }
    }
    
    //MARK: - SignUp:
    func signUp(dic: [String: Any], completion: @escaping (String?) -> (), errorCompletion: @escaping(ServerErrorResponse?, String?) -> ()) {
        
        AuthRDS.signUp(dic: dic) { (succes, failure) in
            
            guard failure == nil else {
                self.switchFailure(failure!, errorCompletion: errorCompletion)
                return
            }
            
            DispatchQueue.main.async {
                completion(succes)
            }
        }
    }
    
    //MARK: - Forgot:
    func forgot(dic:[String:Any], completion: @escaping (String?) -> (), errorCompletion: @escaping (ServerErrorResponse?, String?) -> ()) {
        
        AuthRDS.forgot(dic: dic) { (succes, failure) in
            
            guard failure == nil else {
                self.switchFailure(failure!, errorCompletion: errorCompletion)
                return
            }
            
            DispatchQueue.main.async {
                completion(succes)
            }
        }
    }
}
