//
//  AuthRepositoryModel.swift
//  WIT
//
//  Created by iOS Developer-APPS on 17/05/2021.
//

import Foundation

struct Token: Decodable {
     var access_token : String?
}

struct ForgotPassword: Decodable {
    var message: String?

    enum CodingKeys: String, CodingKey {
        case message = "message"
    }
}


