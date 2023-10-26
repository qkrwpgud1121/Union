//
//  NewPost.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/25.
//

import UIKit

class NewPost: UIViewController {
    
    @IBOutlet weak var btnCategory: UIButton!
    @IBOutlet weak var btnPerson: UIButton!
    @IBOutlet weak var btnMethod: UIButton!
    @IBOutlet weak var btnPeriod: UIButton!
    @IBOutlet weak var btnStack: UIButton!
    @IBOutlet weak var btnPosition: UIButton!
    @IBOutlet weak var stackView: UIView!
    @IBOutlet weak var positionView: UIView!
    @IBOutlet weak var contact: UITextField!
    @IBOutlet weak var postTitle: UITextField!
    @IBOutlet weak var postDetail: UITextView!
    @IBOutlet weak var endDatePidker: UIDatePicker!
    
    var segueType = ""
    var segueBoardId = ""
    var segueContect = ""
    var segueTitle = ""
    var segueDetail = ""
    var segueStack = ""
    var seguePosition = ""
    
    var type: String = "프로젝트"
    var person: Int = 1
    var method: String = "온라인,오프라인"
    var period: String = "미정"
    var endDate: String = ""
    
    var stackArray: [String] = []
    var stackIndex: [Int] = []
    var positionArray: [String] = []
    var positionIndex: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboar()
        self.setKeyboardObserver()
        
        if segueType == "modify" {
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy-MM-dd"
            let date = dateFormatter.date(from: endDate)
            endDatePidker.date = date!
            contact.text = segueContect
            postTitle.text = segueTitle
            postDetail.text = segueDetail
            
            let stack = segueStack.split(separator:", ")
            var stackIndex: Int = 0
            for stacks in stack {
                self.addTag(div: 0 ,index: stackIndex, type: String(stacks))
                stackIndex+=1
            }
            
            let position = seguePosition.split(separator: ", ")
            var positionIndex: Int = 0
            for positions in position {
                self.addTag(div: 1 ,index: positionIndex, type: String(positions))
                positionIndex+=1
            }
        } else {
            let currentDate = Date()
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyyMMdd"
            endDate = dateFormatter.string(from: currentDate)
        }
        
        
        setCategory()
        
        setPerson()
        
        setMethod()
        
        setPeriod()
        
        setStack()
        
        setPosition()
        
    }
    
    @IBAction func saveNewPost(_ sender: UIBarButtonItem) {
        
        
        
        if stackArray.isEmpty {
            newPostAlert(message: "필요 스택", resutlCode: "1")
        } else if positionArray.isEmpty {
            newPostAlert(message: "희망 포지션", resutlCode: "1")
        } else if contact.text!.isEmpty {
            newPostAlert(message: "연락처", resutlCode: "1")
        } else if postTitle.text!.isEmpty {
            newPostAlert(message: "제목", resutlCode: "1")
        } else if postDetail.text!.isEmpty {
            newPostAlert(message: "내용", resutlCode: "1")
        } else {
            
            let encoder = JSONEncoder()
            let requestData = requestParam(unionBoardId: segueBoardId ,unionBoardSubject: postTitle.text!, unionBoardContent: postDetail.text!, email: userEmail, name: "JJJ", groupType: type, numberOfGroup: person, progressType: method, progressMonth: period, deadline: endDate, contactInformation: contact.text!, stacks: stackArray, groupPositions: positionArray)
            let param = try? encoder.encode(requestData)
                
            var requestURL: String = ""
            if segueType == "modify" {
                requestURL = "http://localhost:8080/union/api/union/board/modify"
            } else {
                requestURL = "http://localhost:8080/union/api/union/board/write"
            }
            let url = URL(string: requestURL)
            ListDetailService().setListDetail(url: url!, param: param!) { //1
                (decoded) in
                
                let resultMessage = decoded.resultMessage
                
                if resultMessage == "SUCCESS" {
                    DispatchQueue.main.async{
                        do{
                            let alert = UIAlertController(title: "", message: "신규 작성 되었습니다.", preferredStyle: .alert)
                            
                            let sucess = UIAlertAction(title: "확인", style: .default){_ in
                                let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
                                let mainView = storyboard.instantiateViewController(identifier: "MainList")
                                mainView.modalPresentationStyle = .fullScreen
                                self.navigationController?.show(mainView, sender: nil)
                            }
                            
                            alert.addAction(sucess)
                            self.present(alert, animated: true)
                        }
                    }
                }
            }
        }
    }
    
    func setCategory() {
        
        let project = UIAction(title: "프로젝트", state: .on , handler: {_ in self.type = "프로젝트"})
        let study = UIAction(title: "스터디", state: .on , handler: {_ in self.type = "스터디"})
        
        if type == "스터디"{
            let buttonMenu = UIMenu(title: "모집 구분", children: [study, project])
            btnCategory.menu?.index(ofAccessibilityElement: 1)
            btnCategory.menu = buttonMenu
            btnCategory.changesSelectionAsPrimaryAction = true
        } else {
            let buttonMenu = UIMenu(title: "모집 구분", children: [project, study])
            btnCategory.menu?.index(ofAccessibilityElement: 1)
            btnCategory.menu = buttonMenu
            btnCategory.changesSelectionAsPrimaryAction = true
        }
        
    }
    
    func setPerson() {
        
        let one = UIAction(title: "1명", state: .on , handler: {_ in self.person = 1})
        let two = UIAction(title: "2명", state: .on , handler: {_ in self.person = 2})
        let three = UIAction(title: "3명", state: .on , handler: {_ in self.person = 3})
        let four = UIAction(title: "4명", state: .on , handler: {_ in self.person = 4})
        let five = UIAction(title: "5명", state: .on , handler: {_ in self.person = 5})
        let six = UIAction(title: "6명", state: .on , handler: {_ in self.person = 6})
        let seven = UIAction(title: "7명", state: .on , handler: {_ in self.person = 7})
        let eight = UIAction(title: "8명", state: .on , handler: {_ in self.person = 8})
        let nine = UIAction(title: "9명", state: .on , handler: {_ in self.person = 9})
        let ten = UIAction(title: "10명 이상", state: .on , handler: {_ in self.person = 10})
    
        switch person {
        case 2:
            let buttonMenu = UIMenu(title: "모집 인원", children: [two, one, three, four, five, six, seven, eight, nine, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        case 3:
            let buttonMenu = UIMenu(title: "모집 인원", children: [three, one, two, four, five, six, seven, eight, nine, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        case 4:
            let buttonMenu = UIMenu(title: "모집 인원", children: [four, one, two, three, five, six, seven, eight, nine, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        case 5:
            let buttonMenu = UIMenu(title: "모집 인원", children: [five, one, two, three, four, six, seven, eight, nine, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        case 6:
            let buttonMenu = UIMenu(title: "모집 인원", children: [six, one, two, three, four, five, seven, eight, nine, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        case 7:
            let buttonMenu = UIMenu(title: "모집 인원", children: [seven, one, two, three, four, five, six, eight, nine, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        case 8:
            let buttonMenu = UIMenu(title: "모집 인원", children: [eight, one, two, three, four, five, six, seven, nine, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        case 9:
            let buttonMenu = UIMenu(title: "모집 인원", children: [nine, one, two, three, four, five, six, seven, eight, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        case 10:
            let buttonMenu = UIMenu(title: "모집 인원", children: [ten, one, two, three, four, five, six, seven, eight, nine])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        default:
            let buttonMenu = UIMenu(title: "모집 인원", children: [one, two, three, four, five, six, seven, eight, nine, ten])
            btnPerson.menu = buttonMenu
            btnPerson.changesSelectionAsPrimaryAction = true
        }
        
        
    }
    
    func setMethod() {
        
        let all = UIAction(title: "온라인,오프라인", state: .on , handler: {_ in self.method = "온라인,오프라인"})
        let online = UIAction(title: "온라인", state: .on , handler: {_ in self.method = "온라인"})
        let offline = UIAction(title: "오프라인", state: .on , handler: {_ in self.method = "오프라인"})

        switch method {
        case "오프라인":
            let buttonMenu = UIMenu(title: "진행 방식", children: [offline, all, online])

            btnMethod.menu = buttonMenu
            btnMethod.changesSelectionAsPrimaryAction = true
        case "온라인":
            let buttonMenu = UIMenu(title: "진행 방식", children: [online, all, offline])

            btnMethod.menu = buttonMenu
            btnMethod.changesSelectionAsPrimaryAction = true
        default:
            let buttonMenu = UIMenu(title: "진행 방식", children: [all, online, offline])

            btnMethod.menu = buttonMenu
            btnMethod.changesSelectionAsPrimaryAction = true
        }
        
    }
    
    func setPeriod() {
        
        let none = UIAction(title: "미정", state: .on , handler: {_ in self.period = "미정"})
        let one = UIAction(title: "1개월", state: .on , handler: {_ in self.period = "1개월"})
        let two = UIAction(title: "2개월", state: .on , handler: {_ in self.period = "2개월"})
        let three = UIAction(title: "3개월", state: .on , handler: {_ in self.period = "3개월"})
        let four = UIAction(title: "4개월", state: .on , handler: {_ in self.period = "4개월"})
        let five = UIAction(title: "5개월", state: .on , handler: {_ in self.period = "5개월"})
        let six = UIAction(title: "6개월", state: .on , handler: {_ in self.period = "6개월"})
        let long = UIAction(title: "장기", state: .on , handler: {_ in self.period = "장기"})

        switch period {
        case "1개월":
            let buttonMenu = UIMenu(title: "진행 방식", children: [one, none, two, three, four, five, six, long])

            btnPeriod.menu = buttonMenu
            btnPeriod.changesSelectionAsPrimaryAction = true
        case "2개월":
            let buttonMenu = UIMenu(title: "진행 방식", children: [two, none, one,  three, four, five, six, long])

            btnPeriod.menu = buttonMenu
            btnPeriod.changesSelectionAsPrimaryAction = true
        case "3개월":
            let buttonMenu = UIMenu(title: "진행 방식", children: [three, none, one, two, four, five, six, long])

            btnPeriod.menu = buttonMenu
            btnPeriod.changesSelectionAsPrimaryAction = true
        case "4개월":
            let buttonMenu = UIMenu(title: "진행 방식", children: [four, none, one, two, three, five, six, long])

            btnPeriod.menu = buttonMenu
            btnPeriod.changesSelectionAsPrimaryAction = true
        case "5개월":
            let buttonMenu = UIMenu(title: "진행 방식", children: [five, none, one, two, three, four, six, long])

            btnPeriod.menu = buttonMenu
            btnPeriod.changesSelectionAsPrimaryAction = true
        case "6개월":
            let buttonMenu = UIMenu(title: "진행 방식", children: [six, none, one, two, three, four, five, long])

            btnPeriod.menu = buttonMenu
            btnPeriod.changesSelectionAsPrimaryAction = true
        case "장기":
            let buttonMenu = UIMenu(title: "진행 방식", children: [long, none, one, two, three, four, five, six])

            btnPeriod.menu = buttonMenu
            btnPeriod.changesSelectionAsPrimaryAction = true
        default:
            let buttonMenu = UIMenu(title: "진행 방식", children: [none, one, two, three, four, five, six, long])

            btnPeriod.menu = buttonMenu
            btnPeriod.changesSelectionAsPrimaryAction = true
        }
    }
    
    func setStack() {
        
        let div: Int = 0
        
        let JavaScript = UIAction(title: "JavaScript" , handler: {_ in self.addTag(div: div ,index: 0, type: "JavaScript")})
        let TypeScript = UIAction(title: "TypeScript" , handler: {_ in self.addTag(div: div ,index: 1, type: "TypeScript")})
        let React = UIAction(title: "React" , handler: {_ in self.addTag(div: div ,index: 2, type: "React")})
        let Vue = UIAction(title: "Vue" , handler: {_ in self.addTag(div: div ,index: 3, type: "Vue")})
        let Node = UIAction(title: "Node.js", handler: {_ in self.addTag(div: div ,index: 4, type: "Node")})
        let Next = UIAction(title: "Next.js" , handler: {_ in self.addTag(div: div ,index: 5, type: "Next")})
        let Nest = UIAction(title: "Nest.js" , handler: {_ in self.addTag(div: div ,index: 6, type: "Nest")})
        let Spring = UIAction(title: "Spring", handler: {_ in self.addTag(div: div ,index: 7, type: "Spring")})
        let Java = UIAction(title: "Java", handler: {_ in self.addTag(div: div ,index: 8, type: "Java")})
        let Express = UIAction(title: "Express",  handler: {_ in self.addTag(div: div ,index: 9, type: "Express")})
        let Go = UIAction(title: "Go",  handler: {_ in self.addTag(div: div ,index: 10, type: "Go")})
        let C = UIAction(title: "C",  handler: {_ in self.addTag(div: div ,index: 11, type: "C")})
        let Python = UIAction(title: "Python",  handler: {_ in self.addTag(div: div ,index: 12, type: "Python")})
        let Django = UIAction(title: "Django",  handler: {_ in self.addTag(div: div ,index: 13, type: "Django")})
        let Swift = UIAction(title: "Swift",  handler: {_ in self.addTag(div: div ,index: 14, type: "Swift")})
        let Kotlin = UIAction(title: "Kotlin",  handler: {_ in self.addTag(div: div ,index: 15, type: "Kotlin")})
        let MySQL = UIAction(title: "MySQL", handler: {_ in self.addTag(div: div ,index: 16, type: "MySQL")})
        let MongoDB = UIAction(title: "MongoDB",  handler: {_ in self.addTag(div: div ,index: 17, type: "MongoDB")})
        let php = UIAction(title: "php", handler: {_ in self.addTag(div: div ,index: 18, type: "php")})
        let GraphQL = UIAction(title: "GraphQL",  handler: {_ in self.addTag(div: div ,index: 19, type: "GraphQL")})
        let Firebase = UIAction(title: "Firebase",  handler: {_ in self.addTag(div: div ,index: 20, type: "Firebase")})
        let ReactNative = UIAction(title: "ReactNative",  handler: {_ in self.addTag(div: div ,index: 21, type: "ReactNative")})
        let Unity = UIAction(title: "Unity",  handler: {_ in self.addTag(div: div ,index: 22, type: "Unity")})
        let Flutter = UIAction(title: "Flutter", handler: {_ in self.addTag(div: div ,index: 23, type: "Flutter")})
        let AWS = UIAction(title: "AWS", handler: {_ in self.addTag(div: div ,index: 24, type: "AWS")})
        let Kubernetes = UIAction(title: "Kubernetes", handler: {_ in self.addTag(div: div ,index: 25, type: "Kubernetes")})
        let Docker = UIAction(title: "Docker", handler: {_ in self.addTag(div: div ,index: 26, type: "Docker")})
        let Git = UIAction(title: "Git", handler: {_ in self.addTag(div: div ,index: 27, type: "Git")})
        let Figma = UIAction(title: "Figma", handler: {_ in self.addTag(div: div ,index: 28, type: "Figma")})
        let Zeplin = UIAction(title: "Zeplin", handler: {_ in self.addTag(div: div ,index: 29, type: "Zeplin")})
        
        let buttonMenu = UIMenu(title: "프로젝트 사용 스택", children: [JavaScript, TypeScript, React, Vue, Node, Next, Nest, Spring, Java, Express, Go, C, Python, Django, Swift, Kotlin, MySQL, php, MongoDB, GraphQL, Firebase, ReactNative, Unity, Flutter, AWS, Kubernetes, Docker, Git, Figma, Zeplin])

        btnStack.menu = buttonMenu
        btnStack.changesSelectionAsPrimaryAction = false
    }
    
    @IBAction func endDate(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: sender.date)
        endDate = date
    }
    
    func setPosition() {
        
        let div: Int = 1
        
        let all = UIAction(title: "전체", handler: {_ in print("all")})
        let frontend = UIAction(title: "프런트엔드", handler: {_ in self.addTag(div: div ,index: 0, type: "프런드엔드")})
        let backend = UIAction(title: "백엔드", handler: {_ in self.addTag(div: div ,index: 1, type: "백엔드")})
        let designer = UIAction(title: "디자이너", handler: {_ in self.addTag(div: div ,index: 2, type: "디자이너")})
        let iOS = UIAction(title: "iOS", handler: {_ in self.addTag(div: div ,index: 3, type: "iOS")})
        let AOS = UIAction(title: "안드로이드", handler: {_ in self.addTag(div: div ,index: 4, type: "AOS")})
        let devops = UIAction(title: "DevOps", handler: {_ in self.addTag(div: div ,index: 5, type: "DevOps")})
        let PM = UIAction(title: "PM", handler: {_ in self.addTag(div: div ,index: 6, type: "PM")})
        let planner = UIAction(title: "기획자", handler: {_ in self.addTag(div: div ,index: 7, type: "기획자")})
        
        let buttonMenu = UIMenu(title: "프로젝트 모집 포지션", children: [all, frontend, backend, designer, iOS, AOS, devops, PM, planner])

        btnPosition.menu = buttonMenu
        btnPosition.changesSelectionAsPrimaryAction = false
    }
    
    func addTag(div: Int, index: Int, type: String) {
        
        if div == 0 {
            if !stackIndex.contains(index) {
                stackIndex.append(index)
                stackArray.append(type)
                createTagCloud(OnView: self.stackView, withArray: stackArray as [AnyObject], div: div)
            }
        } else {
            if !positionIndex.contains(index) {
                positionIndex.append(index)
                positionArray.append(type)
                createTagCloud(OnView: self.positionView, withArray: positionArray as [AnyObject], div: div)
            }
        }
        
    }
    
    func createTagCloud(OnView view: UIView, withArray data:[AnyObject], div: Int) {
        
        for tempView in view.subviews {
            if tempView.tag != 0 {
                tempView.removeFromSuperview()
            }
        }
        
        var xPos:CGFloat = 0.0
        var ypos: CGFloat = 0.0
        var tag: Int = 1
        
        for str in data  {
            let startstring = str as! String
            let width = startstring.widthOfString(usingFont: UIFont(name:"verdana", size: 10.0)!)
            let checkWholeWidth = CGFloat(xPos) + CGFloat(width) + CGFloat(13.0) + CGFloat(25.5 )
            if checkWholeWidth > UIScreen.main.bounds.size.width - 30.0 {
                xPos = 15.0
                ypos = ypos + 29.0 + 8.0
            }
            
            let button = UIButton(type: .custom)
            button.frame = CGRect(x: xPos, y: ypos, width: width + 17.0 + 5.0, height: 15.0)
            button.backgroundColor = UIColor.lightGray
            button.setTitle(startstring, for: .normal)
            button.titleLabel?.font = UIFont.systemFont(ofSize: 10)
            button.layer.cornerRadius = 7.5
            button.setImage(UIImage(systemName: "xmark", withConfiguration: UIImage.SymbolConfiguration(scale: .small)), for: .normal)
            button.tintColor = UIColor.white
            button.semanticContentAttribute = .forceRightToLeft
            button.tag = tag
            
            if div == 0 {
                button.addTarget(self, action: #selector(removeStackTag(_:)), for: .touchUpInside)
            } else {
                button.addTarget(self, action: #selector(removePosTag(_:)), for: .touchUpInside)
            }
            
            xPos = CGFloat(xPos) + CGFloat(width) + CGFloat(17.0) + CGFloat(10.0)
            view.addSubview(button)
            tag = tag  + 1
        }
    }
    
    @objc func removeStackTag(_ sender: AnyObject) {
        
        stackArray.remove(at: (sender.tag - 1))
        stackIndex.remove(at: (sender.tag - 1))
        createTagCloud(OnView: self.stackView, withArray: stackArray as [AnyObject], div: 0)
    }
    
    @objc func removePosTag(_ sender: AnyObject) {
        
        positionArray.remove(at: (sender.tag - 1))
        positionIndex.remove(at: (sender.tag - 1))
        createTagCloud(OnView: self.positionView, withArray: positionArray as [AnyObject], div: 1)
    }
    
    func newPostAlert(message: String, resutlCode: String) {
        
        var message = message
        
        if resutlCode != "0" {
            message = "\(message)을 입력해 주세요."
        }
        
        let alert = UIAlertController(title: message, message: "", preferredStyle: .alert)
        let ok = UIAlertAction(title: "확인", style: .default){_ in
            let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
            let mainView = storyboard.instantiateViewController(identifier: "MainList")
            mainView.modalPresentationStyle = .fullScreen
            self.navigationController?.show(mainView, sender: nil)
        }
        alert.addAction(ok)
        self.present(alert, animated: true)
    }
    
}

extension String {
    
    func widthOfString(usingFont font: UIFont) -> CGFloat {
        let fontAttributes = [NSAttributedString.Key.font: font]
        let size = self.size(withAttributes: fontAttributes)
        return size.width
    }
}
