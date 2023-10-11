//
//  listData.swift
//  Union
//
//  Created by JehyeongPark on 2023/08/28.
//

import Foundation

struct List {
    let type: String
    let people: String
    let proceedType: String
    let proceedPeriod: String
    let stack: String
    let endDate: Date
    let position: String
    let contact: String
    let title: String
    let detail: String
    let registrant: String
}

extension List {
    static var data = [
        List(type: "프로젝트", people: "4명", proceedType: "온라인", proceedPeriod: "4개월", stack: "iOS, Swift, Object-c", endDate: NSDate() as Date, position: "iOS, AOS", contact: "qkrwpgud1121@gmail.com", title: "앱 개발 프로젝트 인원 모집", detail: "프로젝트 소개 및 내용 ", registrant: "박제형"),
        List(type: "스터디", people: "3명", proceedType: "오프라인", proceedPeriod: "3개월", stack: "Java, TypeScript, MySQL", endDate: NSDate() as Date, position: "프런트앤드, 백앤드, 기획자", contact: "qkrwpgud1121@naver.com", title: "웹 스터디 모집", detail: "안녕하세요! 자주적인 사람들이 모여 서로 이끌어주는 [가티]팀 입니다. 저희 가티는 자기개발 목적으로 1차 프로젝트를 진행하였고, 팀원 이탈 없이 수익화 목적으로 2차 프로젝트 진행 중 입니다 레저 스포츠를 즐기는 이용자들의 각각 특성을 고려한 매칭 서비스 이며, 중고거래 서비스는 많지만 물건의 정보와 전문성이 떨어지는 입문용 장비들이 대다수입니다 입문 단계를 넘어 심화 단계에 있는 이용자들의 거래가 원활히 이루어질 수 있도록 스포츠 특화 중고거래 서비스를 제공하고자 합니다. ● 팀 구성 현재 팀 구성은 기획1 디자인1 마케팅1 백엔드3 프론트2 이며, 프론트엔드 한분 모집중입니다. ● 협업툴 피그마 잔디 지라 노션 게더 깃헙 ● 모집 포지션 RN 프론트엔드 ● 수익분배/회의일정 수익은 기본 1/n이며, 회의와 오프라인 만남은 협의 후 결정 됩니다 ● 이런분이면 좋겠어요 저희 팀 인재상이 서로 좋은 영향을 미칠수 있는 사람이다 보니 저희 팀에는 이기적인 분이 없으며, 본인이 맡은 역할 외에도 추가 제안을 하는 열정과 노력이 가득하기 때문에 단순 개인의 이익만을 쫓아 팀 분위기를 흐리는 분은 정중히 사양합니다. 수익화도 물론 중요하지만 그보다 더 중요한것은 모든 팀원들의 성장입니다! 감사합니다:)", registrant: "최준형")
    ]
    
}
