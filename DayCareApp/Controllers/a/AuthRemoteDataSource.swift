//
//  AuthRemoteDataSource.swift
//  WIT
//
//  Created by iOS Developer-APPS on 17/05/2021.
//

import Foundation

struct AuthRemoteDataSource {
    
    //Login
    func login(dic:[String:Any], completion: @escaping (Token?,Failure?) -> ()) {
        
        Router.APIRouter(endPoint: .login, parameters: dic, method: .post) { response in
            switch response {
            case .success(let success):
                guard let token = try? JSONDecoder().decode(Token.self, from: success.data) else {
                    completion(nil, Failure(message: "Unable to parse token.", state: .unknown, data: nil, code: nil))
                    return
                }
                completion(token,nil)
            case .failure(let failure):
                completion(nil,failure)
            }
        }
    }
//    //Forgot Password:
//    func forgotPassword(dic: [String:Any], completion: @escaping (ForgotPassword?,Failure?) -> ()) {
//
//        Router.APIRouter(endPoint: .forgotPassword, parameters: dic, method: .post) { response in
//            switch response {
//            case .success(let success):
//                guard let response = try? JSONDecoder().decode(ForgotPassword.self, from: success.data) else {
//                    completion(nil, Failure(message: "Unable to parse response.", state: .unknown, data: nil, code: nil))
//                    return
//                }
//                completion(response,nil)
//            case .failure(let failure):
//                completion(nil,failure)
//
//            }
//        }
//    }
//
//    // Create New Password:
//    func createNewPassword(dic: [String: Any], completion: @escaping (ServerMessageResponse?, Failure?) -> ()){
//
//        Router.APIRouter(endPoint: .getUser, parameters: dic,method: .post) { response in
//            switch response{
//            case .success(let success):
//                guard let response = try? JSONDecoder().decode(ServerMessageResponse.self, from: success.data) else {
//                    completion(nil,Failure(message: "Unable to parse response", state: .unknown, data: nil, code: nil))
//                    return
//                }
//                completion(response,nil)
//            case.failure(let failure):
//                completion(nil,failure)
//            }
//        }
//    }
//
//    // Terms of Use & Forgot Password:
//    func termsOfUseAndPrivacyPolicy(appInfo : String ,completion: @escaping (TermsOfUse?,Failure?) -> ()) {
//        let appendingURL = "?type=\(appInfo)"
//
//        Router.APIRouter(endPoint: .termsOfUseAndPrivacyPolicy,appendingURL: appendingURL, parameters: nil, method: .get) { response in
//            switch response {
//            case .success(let success):
//                guard let response = try? JSONDecoder().decode(TermsOfUse.self, from: success.data) else {
//                    completion(nil, Failure(message: "Unable to parse response.", state: .unknown, data: nil, code: nil))
//                    return
//                }
//                completion(response,nil)
//            case .failure(let failure):
//                completion(nil,failure)
//            }
//        }
//    }
}
