//
//  TodoError.swift
//  TodoList
//
//  Created by Kim Young Hee on 1/20/25.
//

import Foundation

enum TodoError: LocalizedError {
    case saveError
    case loadError
    case updateError
    case deleteError
    
    var errorDescription: String? {
        switch self {
        case .saveError:
            return "할일을 저장하는 중 오류가 발생했습니다."
        case .loadError:
            return "할일을 불러오는 중 오류가 발생했습니다."
        case .updateError:
            return "할일을 수정하는 중 오류가 발생했습니다."
        case .deleteError:
            return "할일을 삭제하는 중 오류가 발생했습니다."
        }
    }
}
