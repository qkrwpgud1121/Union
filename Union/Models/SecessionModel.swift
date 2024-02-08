//
//  secessionModel.swift
//  Union
//
//  Created by JehyeongPark on 2/8/24.
//

import Foundation

// MARK: - Secession request
struct secessionRequest: Codable {
    let email: String
    let password: String
}

// MARK: - Secession response
struct secessionResponse: Codable {
    let resultCode: String
    let resultMessage: String
}
