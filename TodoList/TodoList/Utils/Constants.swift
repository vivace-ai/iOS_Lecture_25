import SwiftUI

enum AppConstants {
    enum Colors {
        static let accentColor = Color.todoAccent
        static let backgroundColor = Color.todoBackground
        static let secondaryColor = Color.todoSecondary  // 수정된 참조 사용
    }
    
    enum Layout {
        static let cornerRadius: CGFloat = 12
        static let spacing: CGFloat = 16
        static let shadowRadius: CGFloat = 5
        static let shadowOpacity: Double = 0.1
    }
    
    enum Animation {
        static let spring = SwiftUI.Animation.spring(
            response: 0.3,
            dampingFraction: 0.7,
            blendDuration: 0
        )
    }
}
