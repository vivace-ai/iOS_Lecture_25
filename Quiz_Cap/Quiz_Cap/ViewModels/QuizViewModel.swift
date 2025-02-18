//
//  QuizViewModel.swift
//  Quiz_Cap
//
//  Created by Kim Young Hee on 1/20/25.
//

import Foundation

class QuizViewModel: ObservableObject {
    @Published var currentQuestion: QuizQuestion?
    @Published var questions: [QuizQuestion] = []
    @Published var currentIndex = 0
    @Published var score = 0
    @Published var showFeedback = false
    @Published var isCorrect = false
    @Published var showingResults = false
    @Published var selectedAnswer: String?
    
    init() {
        loadQuizData()
    }
    
    private func loadQuizData() {
        if let url = Bundle.main.url(forResource: "quiz_questions", withExtension: "json"),
           let data = try? Data(contentsOf: url) {
            do {
                let decoder = JSONDecoder()
                let quizData = try decoder.decode([QuizQuestion].self, from: data)
                self.questions = quizData
                if !questions.isEmpty {
                    self.currentQuestion = questions[0]
                }
            } catch {
                print("Error decoding JSON: \(error)")
            }
        }
    }
    
    func checkAnswer(_ answer: String) {
        guard let currentQuestion = currentQuestion else { return }
        selectedAnswer = answer
        isCorrect = answer == currentQuestion.correctAnswer
        
        if isCorrect {
            score += 1
        }
        
        showFeedback = true
        
        // 1.5초 후에 다음 문제로 이동
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.5) {
            self.showFeedback = false
            self.moveToNextQuestion()
        }
    }
    
    private func moveToNextQuestion() {
        if currentIndex < questions.count - 1 {
            currentIndex += 1
            self.currentQuestion = questions[currentIndex]
            self.selectedAnswer = nil
        } else {
            showingResults = true
        }
    }
    
    func resetQuiz() {
        currentIndex = 0
        score = 0
        showingResults = false
        selectedAnswer = nil
        if !questions.isEmpty {
            currentQuestion = questions[0]
        }
    }
}
