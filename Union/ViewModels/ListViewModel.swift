//
//  ListViewModel.swift
//  Union
//
//  Created by JehyeongPark on 10/18/23.
//

import Foundation

struct ListViewModel {
    let responseList: [DetailList]
}

extension ListViewModel {
    var numberOfSections: Int {
        return 1
    }

    func numberOfRowsInSection(_ section: Int) -> Int {
        return self.responseList.count
    }

    func listAtIndex(_ index: Int) -> ListMainViewModel {
        let list = self.responseList[index]
        return ListMainViewModel(list)
    }
}

struct ListMainViewModel {
    private let DetailList: DetailList
}

extension ListMainViewModel {
    init(_ DetailList: DetailList) {
        self.DetailList = DetailList
    }
}

extension ListMainViewModel {
    var boardId: String? {
        return self.DetailList.boardId
    }
    var type: String? {
        return self.DetailList.type
    }
    var endDate: String? {
        let date = DetailList.endDate
        let year = date!.prefix(4)
        let startIndex = date!.index(date!.startIndex, offsetBy: 4)
        let endIndex = date!.index(date!.endIndex, offsetBy: -3)
        let month = date![startIndex...endIndex]
        let day = date!.suffix(2)
        let endDate = "\(year)-\(month)-\(day)"
        return endDate
    }
    var title: String? {
        return self.DetailList.title
    }
    var detail: String? {
        return self.DetailList.detail
    }
    var people: Int? {
        return self.DetailList.people
    }
    var progressType: String? {
        return self.DetailList.progressType
    }
    var progressMonth: String? {
        return self.DetailList.progressMonth
    }
    var contact: String? {
        return self.DetailList.contact
    }
    var stack: String? {
        let stack = DetailList.stack.joined(separator: ", ")
        return stack
    }
    var position: String? {
        let position = DetailList.position.joined(separator: ", ")
        return position
    }
    var registrant: String? {
        return self.DetailList.registrant
    }
}
