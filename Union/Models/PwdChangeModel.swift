//
//  PwdChangeModel.swift
//  Union
//
//  Created by JehyeongPark on 11/14/23.
//

import Foundation

// MARK: - change password request
struct pwdChangeRequest: Codable {
    let email: String
    let password: String
    let newPassword: String
}

// MARK: - change password response
struct pwdChangeResponse: Codable {
    let resultCode: String
    let resultMessage: String
}
