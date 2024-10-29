// MoneyCounterViewModel.swift
import SwiftUI

class MoneyCounterViewModel: ObservableObject {
    @Published var denominations: [Denomination] = [] {
        didSet {
            saveDenominations()
        }
    }

    init() {
        loadDenominations()
    }

    // Agrega una nueva denominación
    func addDenomination(name: String, value: Double, quantity: Int = 1) {
        let newDenomination = Denomination(name: name, value: value, quantity: quantity)
        denominations.append(newDenomination)
    }

    // Elimina una denominación
    func removeDenomination(at index: Int) {
        denominations.remove(at: index)
    }

    // Calcula el total de todas las denominaciones
    var totalAmount: Double {
        return denominations.reduce(0) { $0 + $1.total }
    }

    // MARK: - Persistencia con UserDefaults

    private let denominationsKey = "denominationsKey"

    // Guarda las denominaciones en UserDefaults
    private func saveDenominations() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(denominations) {
            UserDefaults.standard.set(encoded, forKey: denominationsKey)
        }
    }

    // Carga las denominaciones desde UserDefaults
    private func loadDenominations() {
        if let savedData = UserDefaults.standard.data(forKey: denominationsKey) {
            let decoder = JSONDecoder()
            if let loadedDenominations = try? decoder.decode([Denomination].self, from: savedData) {
                self.denominations = loadedDenominations
            }
        }
    }
}
