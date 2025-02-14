//
//  Product.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 과일마트 앱의 상품 정보를 정의하는 핵심 모델을 구현합니다.
 - 상품의 기본 정보(이름, 이미지, 가격, 설명) 관리
 - 상품의 즐겨찾기 상태 관리
 - JSON 데이터 변환 지원
 - 샘플 데이터 제공
 
 [주요 기능]
 - 상품 데이터 모델 정의
 - Codable을 통한 데이터 직렬화
 - Identifiable을 통한 고유 식별
 - 샘플 데이터 생성
*/

import Foundation

/// 상품의 정보를 저장하고 관리하는 모델 구조체
struct Product {
    /// 상품의 고유 식별자 - UUID를 사용하여 유일성 보장
    let id: UUID = UUID()
    
    /// 상품의 이름
    let name: String
    
    /// 상품 이미지의 에셋 이름
    let imageName: String
    
    /// 상품의 가격 (원화)
    let price: Int
    
    /// 상품에 대한 상세 설명
    let description: String
    
    /// 즐겨찾기 상태 - 기본값은 false
    var isFavorite: Bool = false
    
    /// JSON 인코딩/디코딩에 사용될 키 정의
    /// - id 프로퍼티는 제외하고 나머지만 JSON으로 변환
    private enum CodingKeys: CodingKey {
        case name, imageName, price, description, isFavorite
    }
}

// MARK: - Protocol Extensions

/// JSON 변환을 위한 Codable 프로토콜 채택
extension Product: Codable {}

/// SwiftUI List 등에서 식별을 위한 Identifiable 프로토콜 채택
extension Product: Identifiable {}

/// 상품 비교를 위한 Equatable 프로토콜 채택
extension Product: Equatable {}

// MARK: - Sample Data

/// 개발 및 테스트용 샘플 상품 데이터
let productSamples = [
    // 무화과 상품 데이터
    Product(
        name: "나는야 무화과",           // 상품명
        imageName: "fig",              // 이미지 이름
        price: 3100,                   // 가격
        description: "소화가 잘되고 변비에 좋은 달달한 국내산 무화과에요. 고기와 찰떡궁합!"  // 설명
    ),
    
    // 바나나 상품 데이터 (즐겨찾기 설정됨)
    Product(
        name: "바나나 안 바나나",         // 상품명
        imageName: "banana",           // 이미지 이름
        price: 2400,                   // 가격
        description: "달콤한 맛의 바나나. 이렇게 맛있으니 내가 바나나 안 바나나?",  // 설명
        isFavorite: true              // 즐겨찾기 상태
    )
]

