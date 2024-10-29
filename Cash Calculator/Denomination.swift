// Denomination.swift
import Foundation

struct Denomination: Identifiable, Codable {
    let id: UUID
    var name: String
    var value: Double
    var quantity: Int

    // Calcula el total para esta denominación
    var total: Double {
        return value * Double(quantity)
    }

    // Propiedad para manejar si está seleccionada
    var isSelected: Bool {
        get { UserDefaults.standard.bool(forKey: id.uuidString) }
        set { UserDefaults.standard.setValue(newValue, forKey: id.uuidString) }
    }

    init(name: String, value: Double, quantity: Int) {
        self.id = UUID()
        self.name = name
        self.value = value
        self.quantity = quantity
    }
}
