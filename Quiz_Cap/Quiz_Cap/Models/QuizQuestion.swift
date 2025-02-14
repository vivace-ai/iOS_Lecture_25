//
//  QuizQuestion.swift
//  Quiz_Cap
//
//  Created by Kim Young Hee on 1/20/25.
//

// QuizQuestion.swift

import SwiftUI

struct QuizQuestion: Identifiable, Codable {
    let id: String
    let question: String
    let emoji: String
    let options: [String]
    let correctAnswer: String
}

// MARK: - Quiz Question Extension
extension QuizQuestion {
    static let example = QuizQuestion(
        id: "1",
        question: "서울은 어느 나라의 수도인가요?",
        emoji: "🌏",
        options: ["한국 🌸", "일본 🍵", "중국 🐲", "베트남 🌿"],
        correctAnswer: "한국 🌸"
    )
}

#Preview {
    Text(QuizQuestion.example.question)
        .padding()
}

