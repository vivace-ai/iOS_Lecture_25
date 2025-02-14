import SwiftUI

struct QuizProgressView: View {
    let current: Int
    let total: Int
    
    var body: some View {
        VStack(spacing: 8) {
            ProgressView(value: Double(current), total: Double(total))
                .tint(.blue)
                .padding(.horizontal)
            
            HStack {
                Text("문제")
                    .foregroundColor(.secondary)
                Text("\(current)/\(total)")
                    .bold()
            }
            .font(.caption)
        }
    }
}

#Preview {
    VStack {
        QuizProgressView(current: 3, total: 5)
        QuizProgressView(current: 1, total: 5)
        QuizProgressView(current: 5, total: 5)
    }
    .padding()
} 