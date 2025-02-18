//
//  ResultView.swift
//  Quiz_Cap
//
//  Created by Kim Young Hee on 1/20/25.
//

import SwiftUI

struct ResultView: View {
    let score: Int
    let totalQuestions: Int
    let resetAction: () -> Void
    
    var body: some View {
        VStack(spacing: 20) {
            Text("퀴즈 완료!")
                .font(.largeTitle)
                .bold()
            
            Text("🎉")
                .font(.system(size: 80))
            
            Text("최종 점수")
                .font(.title)
            
            Text("\(score) / \(totalQuestions)")
                .font(.title)
                .bold()
            
            Button(action: resetAction) {
                Text("다시 시작하기")
                    .font(.title3)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.top, 30)
        }
    }
}
