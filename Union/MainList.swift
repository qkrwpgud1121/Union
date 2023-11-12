//
//  MainList.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/19.
//

import UIKit
import SideMenu

class MainList: UIViewController, UITabBarDelegate{
    
    let appDelegate = UIApplication.shared.delegate as? AppDelegate
    
    @IBOutlet weak var tapBar: UITabBar!
    
    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var profile: UIButton!
    @IBOutlet weak var search: UIButton!
    @IBOutlet weak var searchTextfield: UITextField!
    
    // 현재페이지 체크 변수 (자동 스크롤할 때 필요)
    var nowPage: Int = 0
    var pagingNum: Int = 0
    
    var isPaging: Bool = false // 현재 페이징 중인지 체크하는 flag
    var hasNextPage: Bool = true // 마지막 페이지 인지 체크 하는 flag
    
    // 데이터 배열
    let dataArray: Array<UIImage> = [UIImage(named: "img1.png")!, UIImage(named: "img2.png")!, UIImage(named: "img3.png")!]
    
    private var listMainVM: ListViewModel!
    
    let cellSpacingHeight: CGFloat = 1
    let cellName = "MainTableViewCell"
    let cellReuseIdentifier = "offerCell"
    
    var requestGroupType: String = "프로젝트"
    var searchString: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        profile.layer.cornerRadius = profile.frame.width / 2
        profile.layer.borderWidth = 2
        profile.layer.borderColor = UIColor.gray.cgColor
        profile.clipsToBounds = true
        
        setProfile()
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        bannerTimer()
        
        searchTextfield.layer.cornerRadius = searchTextfield.frame.height / 2
        searchTextfield.layer.borderWidth = 1
        searchTextfield.layer.borderColor = UIColor.systemBlue.cgColor
        searchTextfield.addLeftPadding()
        
        setup(search: searchString)
        
        listTableView.delegate = self
        listTableView.dataSource = self
        
        tapBar.delegate = self
        tapBar.selectedItem = tapBar.items?.first
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
        
        setProfile()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        setProfile()
    }
    
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if item.tag == 1 {
            requestGroupType = "프로젝트"
            pagingNum = 0
            hasNextPage = true
        } else {
            requestGroupType = "스터디"
            pagingNum = 0
            hasNextPage = true
        }
        setup(search: searchString)
    }
    
    private func setup(search: String) {

        let encoder = JSONEncoder()
        let param = MainListParam(requestData: mainRequest(groupType: requestGroupType ,unionBoardSubject: search, unionBoardContent: search), paging: pagingRequest(number: pagingNum, size: 20))
        
        let paramData = try? encoder.encode(param)
        
        let url = URL(string: "http://localhost:8080/union/api/union/board/getPagingList")!
        ListService().getMainList(url: url, param: paramData!, pagingNum: pagingNum) {
            (responseList) in
            
            if responseList == nil {
                self.hasNextPage = false
            }
            
            if let responseList = responseList {
                self.listMainVM = ListViewModel(responseList: responseList)
            }
            
            DispatchQueue.main.async {
                self.isPaging = false
                self.listTableView.reloadData()
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let destination = segue.destination as? ListDetail {
                if let selectedIndex = self.listTableView.indexPathForSelectedRow?.row {
                    
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
    
    // 2초마다 실행되는 타이머
    func bannerTimer() {
        let _: Timer = Timer.scheduledTimer(withTimeInterval: 5, repeats: true) { (Timer) in
            self.bannerMove()
        }
    }
    // 배너 움직이는 매서드
    func bannerMove() {
        // 현재페이지가 마지막 페이지일 경우
        if nowPage == dataArray.count-1 {
            // 맨 처음 페이지로 돌아감
            bannerCollectionView.scrollToItem(at: NSIndexPath(item: 0, section: 0) as IndexPath, at: .right, animated: true)
            nowPage = 0
            return
        }
        // 다음 페이지로 전환
        nowPage += 1
        bannerCollectionView.scrollToItem(at: NSIndexPath(item: nowPage, section: 0) as IndexPath, at: .right, animated: true)
    }
    
    func setProfile() {
        
        if appDelegate?.userProfile != "" {
            
            let i = URL(fileURLWithPath: appDelegate?.userProfile ?? "")
            let data = try! Data(contentsOf: i)
            let image = UIImage(data: data)
            self.profile.setImage(image, for: .normal)
        }
    }
    
    @IBAction func search(_ sender: UIButton) {
        
        if self.searchTextfield.isHidden {
            self.searchTextfield.isHidden = false
        } else {
            if self.searchTextfield.text == "" {
                searchString = ""
                pagingNum = 0
                hasNextPage = true
                setup(search: searchString)
                self.searchTextfield.isHidden = true
            } else {
                searchString = self.searchTextfield.text!
                pagingNum = 0
                hasNextPage = true
                setup(search: searchString)
            }
        }
        
    }

}

extension MainList: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    //컬렉션뷰 개수 설정
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    //컬렉션뷰 셀 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = bannerCollectionView.dequeueReusableCell(withReuseIdentifier: "BannerCell", for: indexPath) as! BannerCell
        cell.imgView.image = dataArray[indexPath.row]
        return cell
    }
    
    // UICollectionViewDelegateFlowLayout 상속
    //컬렉션뷰 사이즈 설정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: bannerCollectionView.frame.size.width  , height:  bannerCollectionView.frame.height)
    }
    
    //컬렉션뷰 감속 끝났을 때 현재 페이지 체크
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        nowPage = Int(scrollView.contentOffset.x) / Int(scrollView.frame.width)
    }
}

extension MainList: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listMainVM.numberOfRowsInSection(section)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.listMainVM == nil ? 0 : self.listMainVM.numberOfSections
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as? MainTableViewCell
        else {fatalError("no matched MainTableViewCell identifier")}
        
        let listVM = self.listMainVM.listAtIndex(indexPath.row)
        
        cell.type?.text = listVM.type
        cell.endDate?.text = listVM.endDate
        cell.title?.text = listVM.title
        cell.registrant?.text = listVM.registrant
        cell.stack?.text = listVM.stack
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 186.0
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if listTableView.contentOffset.y > (listTableView.contentSize.height - listTableView.bounds.size.height) {

            if isPaging == false &&  hasNextPage {
                beginPaging()
            }
        }
    }
    
    func beginPaging() {
        
        isPaging = true
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
            self.pagingNum += 1
            self.setup(search: self.searchString)
        }
    }
}
 
