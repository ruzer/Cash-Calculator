import Foundation

struct Denomination: Identifiable, Codable {
    let id: UUID
    var name: String
    var value: Double
    var quantity: Int
    var isSelected: Bool = false // Valor predeterminado

    var total: Double {
        return value * Double(quantity)
    }

    init(name: String, value: Double, quantity: Int, isSelected: Bool = false) {
        self.id = UUID()
        self.name = name
        self.value = value
        self.quantity = quantity
        self.isSelected = isSelected
    }
}
