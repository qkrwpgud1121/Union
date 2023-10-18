//
//  ListMode.swift
//  Union
//
//  Created by JehyeongPark on 10/16/23.
//

import Foundation

struct ListMain: Decodable {
    let resultCode: String?
    let resultMessage: String?
    let responseData: responseData
}

struct responseData: Decodable {
    let list: [DetailList]?
//    let paging: paging
}

struct DetailList: Decodable {
    let title: String?
    let detail: String?
    
    enum CodingKeys: String, CodingKey {
        case title = "unionBoardSubject"
        case detail = "unionBoardContent"
    }
}

//struct paging: Codable {
//    let number: Int
//    let size: Int
//    let totalElements: Int
//    let totalPages: Int
//    let sortProp: String
//    let direction: String
//    let empty: Bool
//    let offset: Int
//}

