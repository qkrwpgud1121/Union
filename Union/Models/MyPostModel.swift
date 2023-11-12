//
//  MyPostModel.swift
//  Union
//
//  Created by JehyeongPark on 10/23/23.
//

import Foundation

// MARK: - 리스트 조회 Request
struct MyPostList: Codable {
    var requestData: data
    var paging: paging
}

struct data: Codable {
    var unionBoardSubject: String
    var unionBoardContent: String
    var email: String
}

struct paging: Codable {
    let number: Int
    let size: Int
//    let totalElements: Int
//    let totalPages: Int
//    let sortProp: String
//    let direction: String
//    let empty: Bool
//    let offset: Int
}

// MARK: - 리스트 수정 Request
struct MyPostModify {
    var unionBoardId: String
    var unionBoardSubject: String
    var unionBoardContent: String
}

// MARK: - 리스트 삭제 Request
struct MyPostDelete: Codable {
    var unionBoardId: String
    var email: String
    var token: String
}

// MARK: - 리스트 조회 Response
struct MyPostResponse: Decodable {
    var resultCode: String
    var resultMessage: String
}
