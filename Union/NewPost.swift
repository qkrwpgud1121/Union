//
//  NewPost.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/25.
//

import UIKit

class NewPost: UIViewController {
    
    @IBOutlet weak var category: UIButton!
    @IBOutlet weak var person: UIButton!
    @IBOutlet weak var method: UIButton!
    @IBOutlet weak var period: UIButton!
    @IBOutlet weak var stack: UIButton!
    @IBOutlet weak var position: UIButton!
    
    var stackArray: [Int] = []
    var positionArray: [Int] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.hideKeyboar()
        self.setKeyboardObserver()
        
        setCategory()
        
        setPerson()
        
        setMethod()
        
        setPeriod()
        
        setStack()
        
        setPosition()
        
    }
    
    @IBAction func saveNewPost(_ sender: UIBarButtonItem) {
        
    }
    
    func setCategory() {
        
        let project = UIAction(title: "프로젝트", state: .on , handler: {_ in print("project")})
        let study = UIAction(title: "스터디", state: .on , handler: {_ in print("study")})

        let buttonMenu = UIMenu(title: "모집 구분", children: [project, study])

        category.menu = buttonMenu
        category.changesSelectionAsPrimaryAction = true
    }
    
    func setPerson() {
        
        let none = UIAction(title: "미정", state: .on , handler: {_ in print("none")})
        let one = UIAction(title: "1명", state: .on , handler: {_ in print("one")})
        let two = UIAction(title: "2명", state: .on , handler: {_ in print("two")})
        let three = UIAction(title: "3명", state: .on , handler: {_ in print("three")})
        let four = UIAction(title: "4명", state: .on , handler: {_ in print("four")})
        let five = UIAction(title: "5명", state: .on , handler: {_ in print("five")})
        let six = UIAction(title: "6명", state: .on , handler: {_ in print("six")})
        let seven = UIAction(title: "7명", state: .on , handler: {_ in print("seven")})
        let eight = UIAction(title: "8명", state: .on , handler: {_ in print("eight")})
        let nine = UIAction(title: "9명", state: .on , handler: {_ in print("nine")})
        let ten = UIAction(title: "10명 이상", state: .on , handler: {_ in print("ten")})

        let buttonMenu = UIMenu(title: "모집 인원", children: [none, one, two, three, four, five, six, seven, eight, nine, ten])

        person.menu = buttonMenu
        person.changesSelectionAsPrimaryAction = true
    }
    
    func setMethod() {
        
        let all = UIAction(title: "전체", state: .on , handler: {_ in print("all")})
        let online = UIAction(title: "온라인", state: .on , handler: {_ in print("online")})
        let offline = UIAction(title: "오프라인", state: .on , handler: {_ in print("offline")})

        let buttonMenu = UIMenu(title: "진행 방식", children: [all, online, offline])

        method.menu = buttonMenu
        method.changesSelectionAsPrimaryAction = true
    }
    
    func setPeriod() {
        
        let none = UIAction(title: "미정", state: .on , handler: {_ in print("all")})
        let one = UIAction(title: "1개월", state: .on , handler: {_ in print("one")})
        let two = UIAction(title: "2개월", state: .on , handler: {_ in print("two")})
        let three = UIAction(title: "3개월", state: .on , handler: {_ in print("three")})
        let four = UIAction(title: "4개월", state: .on , handler: {_ in print("four")})
        let five = UIAction(title: "5개월", state: .on , handler: {_ in print("five")})
        let six = UIAction(title: "6개월", state: .on , handler: {_ in print("six")})
        let long = UIAction(title: "장기", state: .on , handler: {_ in print("long")})

        let buttonMenu = UIMenu(title: "진행 방식", children: [none, one, two, three, four, five, six, long])

        period.menu = buttonMenu
        period.changesSelectionAsPrimaryAction = true
    }
    
    func setStack() {
        
        let div: Int = 0
        
        let JavaScript = UIAction(title: "JavaScript" , handler: {_ in self.checkArray(div: div ,index: 0)})
        let TypeScript = UIAction(title: "TypeScript" , handler: {_ in self.checkArray(div: div ,index: 1)})
        let React = UIAction(title: "React" , handler: {_ in self.checkArray(div: div ,index: 2)})
        let Vue = UIAction(title: "Vue" , handler: {_ in self.checkArray(div: div ,index: 3)})
        let Node = UIAction(title: "Node.js", handler: {_ in self.checkArray(div: div ,index: 4)})
        let Next = UIAction(title: "Next.js" , handler: {_ in self.checkArray(div: div ,index: 5)})
        let Nest = UIAction(title: "Nest.js" , handler: {_ in self.checkArray(div: div ,index: 6)})
        let Spring = UIAction(title: "Spring", handler: {_ in self.checkArray(div: div ,index: 7)})
        let Java = UIAction(title: "Java", handler: {_ in self.checkArray(div: div ,index: 8)})
        let Express = UIAction(title: "Express",  handler: {_ in self.checkArray(div: div ,index: 9)})
        let Go = UIAction(title: "Go",  handler: {_ in self.checkArray(div: div ,index: 10)})
        let C = UIAction(title: "C",  handler: {_ in self.checkArray(div: div ,index: 11)})
        let Python = UIAction(title: "Python",  handler: {_ in self.checkArray(div: div ,index: 12)})
        let Django = UIAction(title: "Django",  handler: {_ in self.checkArray(div: div ,index: 13)})
        let Swift = UIAction(title: "Swift",  handler: {_ in self.checkArray(div: div ,index: 14)})
        let Kotlin = UIAction(title: "Kotlin",  handler: {_ in self.checkArray(div: div ,index: 15)})
        let MySQL = UIAction(title: "MySQL", handler: {_ in self.checkArray(div: div ,index: 16)})
        let MongoDB = UIAction(title: "MongoDB",  handler: {_ in self.checkArray(div: div ,index: 17)})
        let php = UIAction(title: "php", handler: {_ in self.checkArray(div: div ,index: 18)})
        let GraphQL = UIAction(title: "GraphQL",  handler: {_ in self.checkArray(div: div ,index: 19)})
        let Firebase = UIAction(title: "Firebase",  handler: {_ in self.checkArray(div: div ,index: 20)})
        let ReactNative = UIAction(title: "ReactNative",  handler: {_ in self.checkArray(div: div ,index: 21)})
        let Unity = UIAction(title: "Unity",  handler: {_ in self.checkArray(div: div ,index: 22)})
        let Flutter = UIAction(title: "Flutter", handler: {_ in self.checkArray(div: div ,index: 23)})
        let AWS = UIAction(title: "AWS", handler: {_ in self.checkArray(div: div ,index: 24)})
        let Kubernetes = UIAction(title: "Kubernetes", handler: {_ in self.checkArray(div: div ,index: 25)})
        let Docker = UIAction(title: "Docker", handler: {_ in self.checkArray(div: div ,index: 26)})
        let Git = UIAction(title: "Git", handler: {_ in self.checkArray(div: div ,index: 27)})
        let Figma = UIAction(title: "Figma", handler: {_ in self.checkArray(div: div ,index: 28)})
        let Zeplin = UIAction(title: "Zeplin", handler: {_ in self.checkArray(div: div ,index: 29)})
        
        let buttonMenu = UIMenu(title: "프로젝트 사용 스택", children: [JavaScript, TypeScript, React, Vue, Node, Next, Nest, Spring, Java, Express, Go, C, Python, Django, Swift, Kotlin, MySQL, php, MongoDB, GraphQL, Firebase, ReactNative, Unity, Flutter, AWS, Kubernetes, Docker, Git, Figma, Zeplin])

        stack.menu = buttonMenu
        stack.changesSelectionAsPrimaryAction = false
    }
    
    @IBAction func endDate(_ sender: UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyyMMdd"
        let date = dateFormatter.string(from: sender.date)
        print(date)
    }
    
    func setPosition() {
        
        let div: Int = 1
        
        let all = UIAction(title: "전체", handler: {_ in print("all")})
        let frontend = UIAction(title: "프런드엔드", handler: {_ in self.checkArray(div: div ,index: 0)})
        let backend = UIAction(title: "백엔드", handler: {_ in self.checkArray(div: div ,index: 1)})
        let designer = UIAction(title: "디자이너", handler: {_ in self.checkArray(div: div ,index: 2)})
        let iOS = UIAction(title: "iOS", handler: {_ in self.checkArray(div: div ,index: 3)})
        let AOS = UIAction(title: "안드로이드", handler: {_ in self.checkArray(div: div ,index: 4)})
        let devops = UIAction(title: "DevOps", handler: {_ in self.checkArray(div: div ,index: 5)})
        let PM = UIAction(title: "PM", handler: {_ in self.checkArray(div: div ,index: 6)})
        let planner = UIAction(title: "기획자", handler: {_ in self.checkArray(div: div ,index: 7)})
        
        let buttonMenu = UIMenu(title: "프로젝트 모집 포지션", children: [all, frontend, backend, designer, iOS, AOS, devops, PM, planner])

        position.menu = buttonMenu
        position.changesSelectionAsPrimaryAction = false
    }
    
    func checkArray(div: Int, index: Int){
        
        if div == 0 {
            if !self.stackArray.contains(index) {
                self.stackArray.append(index)
                print(self.stackArray)
            }
        } else {
            if !self.positionArray.contains(index) {
                self.positionArray.append(index)
                print(self.positionArray)
            }
        }
    }
    
}
