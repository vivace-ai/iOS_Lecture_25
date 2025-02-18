import SwiftUI

struct QuizOptionButton: View {
    let text: String
    let isSelected: Bool
    let isCorrect: Bool
    let showingAnswer: Bool
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Text(text)
                .font(.title3)
                .padding()
                .frame(maxWidth: .infinity)
                .background(backgroundColor)
                .foregroundColor(.white)
                .cornerRadius(10)
                .animation(.easeInOut, value: showingAnswer)
        }
        .padding(.horizontal)
        .disabled(showingAnswer)
    }
    
    private var backgroundColor: Color {
        if !showingAnswer {
            return Color.blue.opacity(0.6)
        }
        
        if isCorrect {
            return .green
        }
        
        if isSelected {
            return .red
        }
        
        return Color.blue.opacity(0.6)
    }
}

#Preview {
    VStack {
        QuizOptionButton(
            text: "테스트 옵션",
            isSelected: false,
            isCorrect: true,
            showingAnswer: false,
            action: {}
        )
        
        QuizOptionButton(
            text: "선택된 옵션",
            isSelected: true,
            isCorrect: false,
            showingAnswer: true,
            action: {}
        )
    }
    .padding()
} 