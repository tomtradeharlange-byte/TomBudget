import Foundation
import SwiftUI

struct Transaction: Identifiable, Codable {
    let id = UUID()
    let amount: Double
    let category: Category
    let date: Date
    let note: String?
    let isExpense: Bool
    
    enum Category: String, CaseIterable, Codable {
        case groceries = "Groceries"
        case transport = "Transport"
        case entertainment = "Entertainment"
        case housing = "Housing"
        case salary = "Salary"
        case dining = "Dining Out"
        case shopping = "Shopping"
        case health = "Health"
        case education = "Education"
        case savings = "Savings"
        
        var icon: String {
            switch self {
            case .groceries: return "cart.fill"
            case .transport: return "car.fill"
            case .entertainment: return "tv.fill"
            case .housing: return "house.fill"
            case .salary: return "banknote.fill"
            case .dining: return "fork.knife"
            case .shopping: return "bag.fill"
            case .health: return "heart.fill"
            case .education: return "book.fill"
            case .savings: return "piggybank.fill"
            }
        }
        
        var color: Color {
            switch self {
            case .groceries: return Color(hex: "#a1f0c9")
            case .transport: return Color(hex: "#bfc2ff")
            case .entertainment: return Color(hex: "#ffb4a8")
            case .housing: return Color(hex: "#6067df")
            case .salary: return Color(hex: "#166b4c")
            case .dining: return Color(hex: "#ffdad4")
            case .shopping: return Color(hex: "#e0e0ff")
            case .health: return Color(hex: "#a3645a")
            case .education: return Color(hex: "#4950c7")
            case .savings: return Color(hex: "#474dc5")
            }
        }
    }
}
