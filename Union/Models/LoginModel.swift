//
//  LoginModel.swift
//  Union
//
//  Created by JehyeongPark on 10/26/23.
//

import Foundation

struct loginRequest: Encodable {
    let email: String
    let password: String
}

struct loginResponse: Decodable {
    let resultCode: String
    let resultMessage: String
    let responseData: userInfo
}

struct userInfo: Decodable {
    let email: String
    let token: String
    let name: String
    let profileImageName: String?
    let profileImagePath: String?
}
