//
//  Recipe.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 과일마트 앱의 레시피 정보를 관리하는 간단한 모델을 구현합니다.
 - 레시피의 기본 정보(이름, 이미지) 관리
 - 샘플 레시피 데이터 제공
 
 [주요 기능]
 - 레시피 데이터 모델 정의
 - 미리 정의된 레시피 샘플 제공
*/

import SwiftUI

/// 레시피 정보를 관리하는 모델 구조체
struct Recipe {
    /// 레시피의 이름
    let name: String
    
    /// 레시피 이미지의 에셋 이름
    let imageName: String
}

/// 개발 및 테스트용 레시피 샘플 데이터
let recipeSamples = [
    // 토마토 치즈 베네딕트 레시피
    Recipe(
        name: "토마토 치즈 베네딕트",     // 레시피 이름
        imageName: "recipe01"          // 이미지 식별자
    ),
    // 스테이크 레시피
    Recipe(
        name: "구운 토마토와 등심 스테이크", // 레시피 이름
        imageName: "recipe02"          // 이미지 식별자
    ),
    // 스파게티 레시피
    Recipe(
        name: "볼로네이즈 스파게티",      // 레시피 이름
        imageName: "recipe03"          // 이미지 식별자
    ),
    // 치즈 샐러드 레시피
    Recipe(
        name: "크림 치즈 샐러드",        // 레시피 이름
        imageName: "recipe04"          // 이미지 식별자
    ),
    // 토마토 샐러드 레시피
    Recipe(
        name: "토마토 바질페스토 샐러드",  // 레시피 이름
        imageName: "recipe05"          // 이미지 식별자
    ),
]