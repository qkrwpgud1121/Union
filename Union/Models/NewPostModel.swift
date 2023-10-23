//
//  NewPostModel.swift
//  Union
//
//  Created by JehyeongPark on 10/20/23.
//

import Foundation

struct requestParam: Codable {
//    "regDt" : null,
//      "regDay" : null,
//      "modDt" : null,
//      "unionBoardId" : null,
    var unionBoardSubject: String
    var unionBoardContent: String
    var email: String
    var name: String
    var groupType: String
    var numberOfGroup: Int
    var progressType: String
    var progressMonth: String
//      "progressStartDay" : null,
//      "progressEndDay" : null,
//      "stack" : null,
    var deadline: String
//      "groupPosition" : null,
    var contactInformation: String
//      "deleteYn" : null,
    var stacks: [String]
    var groupPositions: [String]
//    var stackList: Array<Any>
//    var groupPositionList: Array<Any>

}
