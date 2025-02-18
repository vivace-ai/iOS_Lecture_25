//
//  RecipeView.swift
//  FruitMart
//
//  Created by Giftbot on 2020/03/02.
//  Copyright © 2020 Giftbot. All rights reserved.
//

/*
 [파일 역할]
 이 파일은 과일을 활용한 레시피를 소개하는 화면을 구현합니다.
 - 레시피 이미지와 정보 표시
 - 좌우 스와이프로 레시피 전환
 - 애니메이션 효과를 통한 부드러운 전환
 - 현재 레시피 위치 인디케이터 표시
 
 [주요 기능]
 - 레시피 슬라이드 쇼 구현
 - 그라데이션 배경 효과
 - 레시피 전환 애니메이션
 - 진행 상태 표시 바
*/

import SwiftUI

/// 레시피 화면을 구성하는 메인 뷰 구조체
struct RecipeView: View {
    /// 현재 표시 중인 레시피 인덱스
    @State private var currentIndex = 0
    /// 표시할 레시피 데이터 배열
    private let recipes = recipeSamples
    
    // MARK: - View Body
    
    var body: some View {
        // 전체 레이아웃을 수직으로 구성
        VStack(alignment: .leading) {
            title           // 상단 타이틀
            Spacer()
            recipePicker    // 레시피 선택기
            Spacer()
            recipeName      // 레시피 이름
            recipeIndicator // 진행 상태 바
        }
        // 전체 화면 크기 설정
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        // 여백 설정
        .padding(.horizontal)
        .padding(.bottom, 30)
        .padding(.top, 80)
        // 배경 그라데이션 적용
        .background(backgroundGradient)
        // 상단 SafeArea 무시
        .edgesIgnoringSafeArea(.top)
    }
}

// MARK: - Private Extensions
private extension RecipeView {
    // MARK: View Components
    
    /// 상단 타이틀 영역
    var title: some View {
        VStack {
            // 메인 타이틀
            Text("과일을 활용한\n신나는 요리")
                .font(.system(size: 42)).fontWeight(.thin)
                .foregroundColor(.white)
                .padding(.vertical)
            
            // 서브 타이틀
            Text("토마토와 함께 하는 금주의 레시피")
                .font(.headline).fontWeight(.thin)
                .foregroundColor(.white)
        }
    }
    
    /// 레시피 선택 영역
    var recipePicker: some View {
        HStack {
            // 이전 레시피 버튼
            Button(action: { self.changeIndex(-1) }) {
                Text("＜")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
            
            Spacer()
            
            // 현재 레시피 이미지
            ResizedImage(recipes[currentIndex].imageName,
                       contentMode: .fit)
                .padding(.horizontal)
                .transition(.stripes())
                .id(currentIndex)
            
            Spacer()
            
            // 다음 레시피 버튼
            Button(action: { self.changeIndex(1) }) {
                Text(">")
                    .font(.largeTitle)
                    .foregroundColor(.white)
            }
        }
    }
    
    /// 레시피 이름 표시
    var recipeName: some View {
        Text(recipes[currentIndex].name)
            .font(.headline)
            .fontWeight(.medium)
            .foregroundColor(.white)
            .animation(nil)
    }
    
    /// 진행 상태 인디케이터
    var recipeIndicator: some View {
        GeometryReader {
            // 배경 바
            Rectangle()
                .fill(Color.white.opacity(0.4))
                .frame(width: $0.size.width)
                .overlay(self.currentIndicator(proxy: $0),
                         alignment: .leading)
        }
        .frame(height: 2)
        .padding(.top)
        .padding(.bottom, 32)
    }
    
    /// 현재 위치 인디케이터 생성
    func currentIndicator(proxy: GeometryProxy) -> some View {
        let pastelYellow = Color(hex: "#fffa77")
        // 전체 너비를 레시피 개수로 나눔
        let width = proxy.size.width / CGFloat(recipes.count)
        return pastelYellow
            .frame(width: width)
            .offset(x: width * CGFloat(currentIndex), y: 0)
    }
    
    /// 배경 그라데이션
    var backgroundGradient: some View {
        let colors = [Color(hex: "#f56161"), Color(hex: "#fc9c79")]
        let gradient = Gradient(colors: colors)
        return LinearGradient(
            gradient: gradient,
            startPoint: .topLeading,
            endPoint: .bottomTrailing
        )
    }
    
    // MARK: Actions
    
    /// 레시피 인덱스 변경 메서드
    /// - Parameter num: 변경할 인덱스 값 (+1 또는 -1)
    func changeIndex(_ num: Int) {
        // 애니메이션과 함께 인덱스 변경
        withAnimation(.easeInOut(duration: 0.6)) {
            currentIndex = (currentIndex + recipes.count + num) % recipes.count
        }
    }
}


// MARK: - Preview
/// SwiftUI 프리뷰를 위한 구조체
struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        Preview(source: RecipeView())
    }
}
