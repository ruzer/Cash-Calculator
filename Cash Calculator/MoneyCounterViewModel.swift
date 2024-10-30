import SwiftUI

class MoneyCounterViewModel: ObservableObject {
    @Published var denominations: [Denomination] = [] {
        didSet {
            saveDenominations()
            calculateTotal()
        }
    }

    @Published var totalAmount: Double = 0.0

    init() {
        loadDenominations()
        calculateTotal()
    }

    func calculateTotal() {
        totalAmount = denominations
            .filter { $0.isSelected }
            .reduce(0) { $0 + $1.total }
    }

    func toggleSelection(for denomination: Denomination) {
        if let index = denominations.firstIndex(where: { $0.id == denomination.id }) {
            denominations[index].isSelected.toggle()
            calculateTotal()
        }
    }

    func addDenomination(name: String, value: Double, quantity: Int = 1) {
        let newDenomination = Denomination(name: name, value: value, quantity: quantity)
        denominations.append(newDenomination)
        calculateTotal()
    }

    func removeDenomination(at index: Int) {
        denominations.remove(at: index)
        calculateTotal()
    }

    func clearQuantities() {
        denominations = denominations.map { Denomination(name: $0.name, value: $0.value, quantity: 0) }
        calculateTotal()
    }

    private func saveDenominations() {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(denominations) {
            UserDefaults.standard.set(encoded, forKey: "denominationsKey")
        }
    }

    private func loadDenominations() {
        if let savedData = UserDefaults.standard.data(forKey: "denominationsKey") {
            let decoder = JSONDecoder()
            if let loadedDenominations = try? decoder.decode([Denomination].self, from: savedData) {
                self.denominations = loadedDenominations
            }
        }
    }
}
