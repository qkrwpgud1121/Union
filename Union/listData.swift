//
//  listData.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/28.
//

import Foundation

struct List {
    let type: String
    let endDate: Date
    let title: String
    let stack: String
    let registrant: String
}

extension List {
    static var data = [
        List(type: "프로젝트", endDate: NSDate() as Date, title: "테스트", stack: "iOS, Swift, Object-c", registrant: "박제형"),
        List(type: "스터디", endDate: NSDate() as Date, title: "테스트", stack: "iOS, Swift, Object-c", registrant: "채준관")
    ]
    
}
