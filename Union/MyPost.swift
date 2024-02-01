//
//  MyPost.swift
//  Union
//
//  Created by JehyeongPark on 10/23/23.
//

import UIKit

class MyPost: UIViewController {

    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var navigationBar: UINavigationItem!
    @IBOutlet weak var myPostTableView: UITableView!
    
    private var listMainVM: ListViewModel!
    
    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag
    var hasNextPage: Bool = true // 마지막 페이지 인지 체크 하는 flag
    
    let cellName = "MyPostTableViewCell"
    let cellReuseIdentifier = "MyPostCell"
    
    var pagingNum: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setup()
        
        myPostTableView.delegate = self
        myPostTableView.dataSource = self
        
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.backward"), for: .normal)
        button.setTitle("Back", for: .normal)
        button.addTarget(self, action: #selector(back), for: .touchUpInside)
        button.sizeToFit()
        
        let newBackButton = UIBarButtonItem(customView: button)
        
        self.navigationItem.leftBarButtonItem = newBackButton        
    }
    
    @objc func back(sender: UIBarButtonItem) {
        let mainView = storyboard!.instantiateViewController(identifier: "MainList")
        mainView.modalPresentationStyle = .fullScreen
        self.navigationController?.show(mainView, sender: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setup()
    }
    
    private func setup() {
        
        let email = appDelegate?.userEmail
        
        let encoder = JSONEncoder()
        let param = MyPostList(requestData: data(unionBoardSubject: "", unionBoardContent: "", email: email!), paging: paging(number: pagingNum, size: 20))
        
        let paramData = try? encoder.encode(param)
        
        let url = URL(string: "http://43.201.53.148:8080/union/api/union/board/getPagingList")!
        ListService().getMainList(url: url, param: paramData!, pagingNum: pagingNum) { //1
            (responseList) in
            
            if responseList == nil {
                self.hasNextPage = false
            }

            if let responseList = responseList {
                self.listMainVM = ListViewModel(responseList: responseList) //2
            }
            
            DispatchQueue.main.async {
                self.isPaging = false
                self.myPostTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "MyPostDetail" {
            if let destination = segue.destination as? ListDetail {
                if let selectedIndex = self.myPostTableView.indexPathForSelectedRow?.row {
                    
                    let target = listMainVM.listAtIndex(selectedIndex)
                    
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "yyyy-MM-dd"
                    
                    let groupOfPerson: String = "\(String(target.people!)) 명"
                    
                    destination.prepareSegue = segue.identifier
                    
                    destination.prepareBoardId = target.boardId
                    destination.prepareType = target.type
                    destination.preparePeople = groupOfPerson
                    destination.prepareProceedType = target.progressType
                    destination.prepareProceedPeriod = target.progressMonth
                    destination.preparePosition = target.position
                    destination.prepareContact = target.contact
                    destination.prepareDetail = target.detail
                    destination.prepareEndDate = target.endDate
                    destination.prepareTitle = target.title
                    destination.prepareStack = target.stack
                    destination.prepareRegistrant = target.registrant
                }
            }
        }
    }

}

extension MyPost: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listMainVM.numberOfRowsInSection(section)
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listMainVM == nil ? 0 : self.listMainVM.numberOfSections
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? MyPostTableViewCell
        else {fatalError("no matched MyPostTableViewCell identifier")}

        let listVM = self.listMainVM.listAtIndex(indexPath.row)
        cell.myPostType?.text = listVM.type
        cell.myPostTitle?.text = listVM.title
        cell.myPostStack?.text = listVM.stack
        cell.myPostRegistrant?.text = listVM.registrant
        cell.myPostEndDate?.text = listVM.endDate
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 186.0
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if myPostTableView.contentOffset.y > (myPostTableView.contentSize.height - myPostTableView.bounds.size.height) {

            if isPaging == false &&  hasNextPage {
                beginPaging()
            }
        }
    }
    
    func beginPaging() {
        
        isPaging = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.pagingNum += 1
            self.setup()
        }
    }
}
