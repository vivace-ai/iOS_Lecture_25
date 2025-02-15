//
//  ContentView.swift
//  VStackAlignment
//
//  Created by Kim Young Hee on 2/15/25.
//

import SwiftUI

import SwiftUI

struct ContentView: View {
    var body: some View {
        VStack(spacing: 20) {
            Text("VStack")
                .font(.largeTitle)
            
            Text("정렬")
                .font(.title)
                .foregroundColor(.gray)
            
            Text("기본적으로 VStack 내의 뷰들은 중앙 정렬됩니다.")
                .multilineTextAlignment(.center)
            
            VStack(alignment: .leading, spacing: 40) {
                Text("왼쪽 정렬")
                    .font(.title)
                Divider()
                Image(systemName: "arrow.left")
            }
            .padding()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.orange)
            )
            .padding()
            
            VStack(alignment: .trailing, spacing: 40) {
                Text("오른쪽 정렬")
                    .font(.title)
                Divider()
                Image(systemName: "arrow.right")
            }
            .padding()
            .foregroundColor(.white)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .foregroundColor(.blue)
            )
            .padding()
            
            Text("초기화 구문에서 정렬을 설정하세요.")
                .foregroundColor(.purple)
        }
    }
}

#Preview {
    ContentView()
}
