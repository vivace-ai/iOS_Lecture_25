//
//  QuizView.swift
//  Quiz_Cap
//
//  Created by Kim Young Hee on 1/20/25.
//

// QuizView.swift

import SwiftUI

struct QuizView: View {
    @StateObject private var quizViewModel = QuizViewModel()
    
    var body: some View {
        ZStack {
            if quizViewModel.showingResults {
                ResultView(score: quizViewModel.score, totalQuestions: quizViewModel.questions.count) {
                    quizViewModel.resetQuiz()
                }
            } else {
                if let currentQuestion = quizViewModel.currentQuestion {
                    VStack {
                        QuizProgressView(
                            current: quizViewModel.currentIndex + 1,
                            total: quizViewModel.questions.count
                        )
                        .padding()
                        
                        Text(currentQuestion.question)
                            .font(.title)
                            .padding()
                        
                        Text(currentQuestion.emoji)
                            .font(.system(size: 80))
                            .padding()
                        
                        ForEach(currentQuestion.options, id: \.self) { option in
                            QuizOptionButton(
                                text: option,
                                isSelected: quizViewModel.selectedAnswer == option,
                                isCorrect: option == currentQuestion.correctAnswer,
                                showingAnswer: quizViewModel.showFeedback
                            ) {
                                if !quizViewModel.showFeedback {
                                    quizViewModel.checkAnswer(option)
                                }
                            }
                        }
                        
                        if quizViewModel.showFeedback {
                            Text(quizViewModel.isCorrect ? "정답입니다! 👏" : "틀렸습니다 😢")
                                .font(.title2)
                                .foregroundColor(quizViewModel.isCorrect ? .green : .red)
                                .padding()
                        }
                        
                        Text("Score: \(quizViewModel.score)")
                            .font(.headline)
                            .padding()
                    }
                    .animation(.default, value: quizViewModel.currentIndex)
                } else {
                    Text("퀴즈를 불러오는 중...")
                }
            }
        }
    }
}

#Preview {
    QuizView()
}
