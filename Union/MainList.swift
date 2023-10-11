//
//  MainList.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/19.
//

import UIKit
import SideMenu

class MainList: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tapBar: UITabBar!
    
    @IBOutlet var bannerCollectionView: UICollectionView!
    @IBOutlet weak var listTableView: UITableView!
    @IBOutlet weak var profile: UIButton!
    
    // 현재페이지 체크 변수 (자동 스크롤할 때 필요)
    var nowPage: Int = 0

    // 데이터 배열
    let dataArray: Array<UIImage> = [UIImage(named: "img1.png")!, UIImage(named: "img2.png")!, UIImage(named: "img3.png")!]
    
    let list = List.data
    let cellSpacingHeight: CGFloat = 1
    let cellName = "MainTableViewCell"
    let cellReuseIdentifier = "offerCell"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        profile.layer.cornerRadius = profile.frame.width / 2
        profile.layer.borderWidth = 2
        profile.layer.borderColor = UIColor.gray.cgColor
        profile.clipsToBounds = true
        
        self.navigationController?.interactivePopGestureRecognizer?.isEnabled = false
        
        bannerCollectionView.delegate = self
        bannerCollectionView.dataSource = self
        
        bannerTimer()
        
        listTableView.delegate = self
        listTableView.dataSource = self
        listTableView.rowHeight = 100
        
        tapBar.selectedItem = tapBar.items?.first
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationItem.hidesBackButton = true
    }
    
    // Section 당 Row의 수
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    // Section의 수
    func numberOfSections(in tableView: UITableView) -> Int {
        return list.count
    }
    
    // 각 Section 사이의 간격 설정
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = listTableView.dequeueReusableCell(withIdentifier: cellReuseIdentifier, for: indexPath) as! MainTableViewCell
        let target = list[indexPath.section]
        
        let dateFormat = DateFormatter()
        dateFormat.dateFormat = "yyyy-MM-dd"
        
        cell.type?.text = target.type
        cell.title?.text = target.title
        cell.stack?.text = target.stack
        cell.registrant?.text = target.registrant
        cell.endDate?.text = dateFormat.string(from: target.endDate)
        
        return cell
    }
    
    private func registerXib() {
        let nibName = UINib(nibName: cellName, bundle: nil)
        listTableView.register(nibName, forCellReuseIdentifier: cellReuseIdentifier)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "detail" {
            if let destination = segue.destination as? ListDetail {
                if let selectedIndex = self.listTableView.indexPathForSelectedRow?.section {
                    
                    let target = list[selectedIndex]
                    
                    let dateFormat = DateFormatter()
                    dateFormat.dateFormat = "yyyy-MM-dd"
                    
                    destination.prepareType = target.type
                    destination.preparePeople = target.people
                    destination.prepareProceedType = target.proceedType
                    destination.prepareProceedPeriod = target.proceedPeriod
                    destination.preparePosition = target.position
                    destination.prepareContact = target.contact
                    destination.prepareDetail = target.detail
                    destination.prepareEndDate = dateFormat.string(from: target.endDate)
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
        
        registerXib()
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
