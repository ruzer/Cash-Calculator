// DenominationsView.swift
import SwiftUI

struct DenominationsView: View {
    @ObservedObject var viewModel: MoneyCounterViewModel
    @State private var showAddModal = false
    @State private var selectedDenomination: Denomination?
    @State private var newValue: String = ""

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.denominations.sorted(by: { $0.value > $1.value })) { denomination in
                        HStack {
                            // Checkbox para seleccionar la denominación
                            Button(action: {
                                toggleSelection(for: denomination)
                            }) {
                                Image(systemName: denomination.isSelected ? "checkmark.square" : "square")
                                    .foregroundColor(.blue)
                            }

                            // Muestra el valor de la denominación con dos decimales
                            Text("\(denomination.value, specifier: "%.2f")")
                                .foregroundColor(.gray)

                            Spacer()

                            // Menú de opciones
                            Menu {
                                Button("Editar") {
                                    selectedDenomination = denomination
                                    newValue = String(format: "%.2f", denomination.value) // Muestra el valor actual con decimales en el campo de edición
                                    showAddModal = true
                                }
                                Button("Eliminar", role: .destructive) {
                                    if let index = viewModel.denominations.firstIndex(where: { $0.id == denomination.id }) {
                                        viewModel.removeDenomination(at: index)
                                    }
                                }
                            } label: {
                                Image(systemName: "ellipsis")
                                    .foregroundColor(.black)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }

                // Botón para agregar nuevas denominaciones
                Button(action: {
                    selectedDenomination = nil // Para agregar una nueva
                    newValue = ""
                    showAddModal = true
                }) {
                    Image(systemName: "plus")
                        .font(.largeTitle)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .clipShape(Circle())
                        .padding()
                }
            }
            .navigationTitle("Denominaciones")
            .sheet(isPresented: $showAddModal) {
                AddDenominationModal(viewModel: viewModel, denominationToEdit: $selectedDenomination, newValue: $newValue)
            }
        }
    }

    private func toggleSelection(for denomination: Denomination) {
        if let index = viewModel.denominations.firstIndex(where: { $0.id == denomination.id }) {
            viewModel.denominations[index].isSelected.toggle()
        }
    }
}

// Vista de vista previa
struct DenominationsView_Previews: PreviewProvider {
    static var previews: some View {
        DenominationsView(viewModel: MoneyCounterViewModel())
    }
}
