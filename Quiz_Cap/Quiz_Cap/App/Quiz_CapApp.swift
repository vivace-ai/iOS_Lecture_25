//
//  Quiz_CapApp.swift
//  Quiz_Cap
//
//  Created by Kim Young Hee on 1/20/25.
//



import SwiftUI

@main
struct Quiz_CapApp: App {
    @StateObject private var quizViewModel = QuizViewModel()
    
    var body: some Scene {
        WindowGroup {
            QuizView()
                .environmentObject(quizViewModel)
        }
    }
}

