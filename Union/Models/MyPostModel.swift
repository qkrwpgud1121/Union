//
//  MyPostModel.swift
//  Union
//
//  Created by JehyeongPark on 10/23/23.
//

import Foundation

struct MyPostList: Codable {
    var requestData: data
}

struct data: Codable {
    var unionBoardSubject: String
    var unionBoardContent: String
    var email: String
}

struct MyPostModify {
    var unionBoardId: String
    var unionBoardSubject: String
    var unionBoardContent: String
}

struct MyPostDelete: Codable {
    var unionBoardId: String
    var email: String
    var token: String
}

struct MyPostResponse: Decodable {
    var resultCode: String
    var resultMessage: String
}
