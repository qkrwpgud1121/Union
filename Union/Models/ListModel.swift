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
    let type: String?
    let endDate: String?
    let title: String?
    let detail: String?
    let registrant: String?
    
    enum CodingKeys: String, CodingKey {
        case type = "progressType"
        case endDate = "deadline"
        case title = "unionBoardSubject"
        case detail = "unionBoardContent"
        case registrant = "name"
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

