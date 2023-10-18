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
    var title: String? {
        return self.DetailList.title
    }
    var detail: String? {
        return self.DetailList.detail
    }
}
