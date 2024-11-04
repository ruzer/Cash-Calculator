// AddDenominationModal.swift
import SwiftUI

struct AddDenominationModal: View {
    @ObservedObject var viewModel: MoneyCounterViewModel
    @Binding var denominationToEdit: Denomination?
    @Binding var newValue: String

    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            TextField("Valor de la Denominación", text: $newValue)
                .keyboardType(.decimalPad)
                .padding()
                .textFieldStyle(RoundedBorderTextFieldStyle())

            HStack {
                Button("Cancelar") {
                    presentationMode.wrappedValue.dismiss()
                }
                .foregroundColor(.red)
                .padding()

                Spacer()

                Button("Guardar") {
                    saveDenomination()
                }
                .foregroundColor(.blue)
                .padding()
            }
        }
        .padding()
        .frame(maxWidth: 300) // Modal más pequeño
        .background(Color.white)
        .cornerRadius(12)
        .shadow(radius: 8)
    }

    private func saveDenomination() {
        guard let valueDouble = Double(newValue) else { return }

        if let denomination = denominationToEdit {
            // Editar denominación existente
            if let index = viewModel.denominations.firstIndex(where: { $0.id == denomination.id }) {
                viewModel.denominations[index].value = valueDouble
            }
        } else {
            // Agregar nueva denominación
            viewModel.addDenomination(name: "Denominación", value: valueDouble)
        }

        presentationMode.wrappedValue.dismiss()
    }
}

// Vista de vista previa
struct AddDenominationModal_Previews: PreviewProvider {
    static var previews: some View {
        AddDenominationModal(viewModel: MoneyCounterViewModel(), denominationToEdit: .constant(nil), newValue: .constant(""))
    }
}
