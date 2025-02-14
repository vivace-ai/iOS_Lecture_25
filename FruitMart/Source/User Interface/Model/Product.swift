//
//  Product.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.

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
  Product(name: "나는야 무화과", imageName: "fig", price: 3100, description: "소화가 잘되고 변비에 좋은 달달한 국내산 무화과에요. 고기와 찰떡궁합!"),
  Product(name: "유기농 아보카도", imageName: "avocado", price: 2900, description: "미네랄도 풍부하고, 요리 장식과 소스로도 좋은 아보카도입니다"),
  Product(name: "바나나 안 바나나", imageName: "banana", price: 2400, description: "달콤한 맛의 바나나. 이렇게 맛있으니 내가 바나나 안 바나나?", isFavorite: true),
  Product(name: "아임 파인애플", imageName: "pineapple", price: 3000, description: "소화와 피로회복, 비타민까지! 파인애플로 맛과 영양까지 한번에!"),
  Product(name: "시원한 수박", imageName: "watermelon", price: 3500, description: "아이들이 너무나 좋아하는 시원하고 달콤한 하우스 수박이에요", isFavorite: true),
  Product(name: "베리베리 블루베리", imageName: "blueberry", price: 2300, description: "타임지 선정 10대 파워 푸드. 신이 내린 선물이라 불리는 블루베리에요"),
]

