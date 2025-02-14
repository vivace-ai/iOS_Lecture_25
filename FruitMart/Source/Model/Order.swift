//
//  Order.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 과일마트 앱의 주문 정보를 관리하는 모델을 구현합니다.
 - 주문 정보(ID, 상품, 수량, 가격) 관리
 - 주문 ID 자동 생성 및 관리
 - 주문 데이터의 영구 저장 지원
 
 [주요 기능]
 - 주문 데이터 모델 정의
 - 순차적 주문 ID 생성
 - 주문 총액 계산
 - UserDefaults를 통한 마지막 주문 ID 저장
*/

import Foundation

/// 사용자의 주문 정보를 관리하는 모델 구조체
struct Order {
    /// 순차적인 주문 ID를 생성하는 시퀀스
    /// 마지막 주문 ID에 1을 더한 값부터 시작하여 1씩 증가
    static var orderSequence = sequence(first: lastOrderID + 1) { $0 + 1 }
    
    /// 마지막 주문 ID를 UserDefaults에 저장/로드하는 정적 프로퍼티
    static var lastOrderID: Int {
        // UserDefaults에서 마지막 주문 ID 읽기
        get { UserDefaults.standard.integer(forKey: "LastOrderID") }
        // UserDefaults에 마지막 주문 ID 저장
        set { UserDefaults.standard.set(newValue, forKey: "LastOrderID") }
    }
    
    // MARK: - Properties
    
    /// 주문의 고유 식별자
    let id: Int
    
    /// 주문한 상품 정보
    let product: Product
    
    /// 주문 수량
    let quantity: Int
    
    /// 주문 총액을 계산하는 읽기 전용 계산 프로퍼티
    /// 상품 가격과 주문 수량을 곱하여 계산
    var price: Int {
        product.price * quantity
    }
}

// MARK: - Protocol Extensions

/// JSON 형식으로 데이터를 저장하고 불러올 수 있도록 Codable 프로토콜 채택
extension Order: Codable {}

/// SwiftUI List 등에서 식별 가능하도록 Identifiable 프로토콜 채택
extension Order: Identifiable {}
