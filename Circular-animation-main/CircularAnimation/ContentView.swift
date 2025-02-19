//
//  ContentView.swift
//  CircularAnimation
//
//  Created by 김영희 on 2025-02-18
//
//  파일 설명:
//  CircularAnimation 앱의 메인 뷰를 구현한 파일입니다.
//  원형 그라데이션 애니메이션을 구현하여 시각적으로 매력적인 인터페이스를 제공합니다.
//
//  주요 기능:
//  - 그라데이션이 적용된 원형 애니메이션
//  - 다중 레이어 구조의 시각적 효과
//  - 블러 및 그림자 효과를 통한 깊이감 표현
//

import SwiftUI

/// 앱의 메인 인터페이스를 정의하는 뷰 구조체
struct ContentView: View {
    /// 애니메이션의 현재 상태를 추적하는 상태 변수
    /// true일 때 애니메이션이 활성화되며, false일 때 초기 상태
    @State private var animate = false
    
    /// 뷰의 본문을 정의하는 계산 프로퍼티
    /// ZStack을 사용하여 여러 레이어의 원형 요소들을 중첩
    var body: some View {
        ZStack {
            // MARK: - 배경 레이어
            /// 앱의 기본 배경색을 설정하고 안전 영역을 무시하여 전체 화면을 채움
            Color.black
                .edgesIgnoringSafeArea(.all)
            
            // MARK: - 외부 원형 레이어
            /// 가장 바깥쪽 원형 레이어로, 두꺼운 선과 블러 효과를 적용
            /// - 선의 두께: 12포인트
            /// - 블러 반경: 20포인트
            /// - 노란색 그림자 효과 추가
            Circle()
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.orange, .yellow, .green, .cyan, .blue, .purple]),
                        startPoint: UnitPoint(x: animate ? 0.5 : -1, y: animate ? 0.5 : -0.5),
                        endPoint: UnitPoint(x: animate ? 2 : 0.5, y: animate ? 1.5 : 0.5)
                    ),
                    lineWidth: 12
                )
                .frame(width: 255, height: 255)
                .blur(radius: 20)
                .shadow(color: .yellow, radius: 16, x: 16, y: 16)
            
            // MARK: - 중간 원형 레이어
            /// 중간 레이어의 원형으로, 얇은 선으로 구성
            /// - 선의 두께: 5포인트
            /// - 그라데이션 애니메이션이 적용됨
            Circle()
                .stroke(
                    LinearGradient(
                        gradient: Gradient(colors: [.orange, .yellow, .green, .cyan, .blue, .purple]),
                        startPoint: UnitPoint(x: animate ? 0.5 : -1, y: animate ? 0.5 : -0.5),
                        endPoint: UnitPoint(x: animate ? 2 : 0.5, y: animate ? 1.5 : 0.5)
                    ),
                    lineWidth: 5
                )
                .frame(width: 255, height: 255)
                .onAppear {
                    // 뷰가 나타날 때 자동으로 애니메이션 시작
                    // 3초 동안 선형 애니메이션을 적용하고 자동으로 반복
                    withAnimation(.linear(duration: 3.0).repeatForever(autoreverses: true)) {
                        animate = true
                    }
                }
            
            // MARK: - 내부 원형 레이어
            /// 가장 안쪽의 원형으로, 그라데이션으로 채워진 중심부
            /// - 검정색에서 약간 밝은 회색으로 이어지는 그라데이션
            /// - 위에서 아래로 향하는 방향성
            Circle()
                .fill(
                    LinearGradient(
                        gradient: Gradient(colors: [Color.black, Color(white: 0.15)]),
                        startPoint: .top,
                        endPoint: .bottom
                    )
                )
                .frame(width: 250, height: 250)
        }
    }
}

/// SwiftUI 프리뷰 프로바이더
/// 개발 중 실시간으로 뷰의 모습을 확인할 수 있게 함
#Preview {
    ContentView()
}
