//
//  EmptySearchView.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/20/25.
//

import SwiftUI

struct EmptySearchView: View {
    let searchText: String
    
    var body: some View {
        VStack(spacing: 16) {
            Image(systemName: "magnifyingglass")
                .font(.system(size: 50))
                .foregroundColor(.gray)
                .padding()
                .background(
                    Circle()
                        .fill(Color.gray.opacity(0.1))
                )
            
            Text("'\(searchText)'에 대한\n검색 결과가 없습니다")
                .font(.title3)
                .bold()
                .multilineTextAlignment(.center)
            
            Text("다른 검색어를 입력해보세요")
                .font(.subheadline)
                .foregroundColor(.gray)
        }
        .padding()
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

// Preview 수정
#Preview {
    EmptySearchView(searchText: "테스트") // searchText 매개변수 추가
}

//
//import SwiftUI
//
//struct EmptySearchView: View {
//    let searchText: String
//    
//    var body: some View {
//        VStack(spacing: 12) {
//            Image(systemName: "magnifyingglass")
//                .font(.system(size: 40))
//                .foregroundColor(.gray)
//            
//            Text("'\(searchText)'에 대한 검색 결과가 없습니다")
//                .font(.headline)
//            
//            Text("다른 검색어를 입력해보세요")
//                .font(.subheadline)
//                .foregroundColor(.gray)
//        }
//        .padding()
//    }
//}
//
//// Preview 수정
//#Preview {
//    EmptySearchView(searchText: "테스트") // searchText 매개변수 추가
//}
