//
//  ProfileModel.swift
//  Union
//
//  Created by JehyeongPark on 10/27/23.
//

import Foundation

// MARK: - 프로필 조회
struct ProfileRequest: Encodable {
    let email: String
}

struct profileResponse: Decodable {
    let resultCode: String
    let resultMessage: String
    let responseData: userProfile
}

struct userProfile: Decodable {
    let email: String
    let name: String
    let hopeJob: String?
    let career: String?
    let introduction: String?
    let portfolioLink: String?
    let profileImageName: String?
    let profileImagePath: String?
}

// MARK: - 프로필 저장

struct saveProfileRequest: Encodable {
    let email: String
    let name: String
    let hopeJob: String
    let career: String
    let introduction: String
    let portfolioLink: String
//    let profileImageName: String
//    let profileImagePath: String
}

struct saveProfileResponse: Decodable {
    let resultCode: String?
    let resultMessage: String?
    let responseData: String?
}
