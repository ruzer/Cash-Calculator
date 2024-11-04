import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MoneyCounterViewModel
    @State private var showMenu = false
    @FocusState private var focusedField: Int?

    private var numberFormatter: NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.minimumFractionDigits = 2
        formatter.maximumFractionDigits = 2
        return formatter
    }

    var body: some View {
        NavigationView {
            VStack {
                List {
                    // Filtrar solo las denominaciones seleccionadas
                    ForEach(viewModel.denominations.filter { $0.isSelected }) { denomination in
                        let index = viewModel.denominations.firstIndex(where: { $0.id == denomination.id })!
                        
                        HStack {
                            Image(systemName: denomination.value < 1 ? "centsign.circle" : "dollarsign.circle")
                                .foregroundColor(denomination.value < 1 ? .orange : .green)

                            if let formattedValue = numberFormatter.string(from: NSNumber(value: denomination.value)) {
                                Text(formattedValue)
                                    .font(.headline)
                                    .padding(.leading, 5)
                            }

                            Text("X")
                                .font(.headline)
                                .padding(.horizontal, 5)

                            TextField("Cantidad", value: $viewModel.denominations[index].quantity, formatter: NumberFormatter())
                                .textFieldStyle(RoundedBorderTextFieldStyle())
                                .frame(width: 60)
                                .keyboardType(.numberPad)
                                .focused($focusedField, equals: index)
                                .onChange(of: viewModel.denominations[index].quantity) { _ in
                                    viewModel.calculateTotal()
                                }

                            Text("=")
                                .font(.headline)
                                .padding(.horizontal, 5)

                            let totalValue = denomination.value * Double(denomination.quantity)
                            if let formattedTotal = numberFormatter.string(from: NSNumber(value: totalValue)) {
                                Text(formattedTotal)
                                    .font(.headline)
                                    .frame(maxWidth: .infinity, alignment: .center)
                            }
                        }
                        .padding(.vertical, 5)
                    }
                }

                // Botones de Copiar, Compartir y Restablecer entradas
                HStack(spacing: 40) {
                    Button(action: copyToClipboard) {
                        Image(systemName: "doc.on.doc")
                            .font(.title)
                            .padding()
                    }

                    Button(action: shareContent) {
                        Image(systemName: "square.and.arrow.up")
                            .font(.title)
                            .padding()
                    }

                    Button(action: resetQuantities) {
                        Image(systemName: "trash")
                            .font(.title)
                            .foregroundColor(.red)
                            .padding()
                    }
                }
                .padding(.bottom, 20)

                // Mostrar el total general
                if let formattedTotalAmount = numberFormatter.string(from: NSNumber(value: viewModel.totalAmount)) {
                    Text("Total: \(formattedTotalAmount)")
                        .font(.title)
                        .padding()
                }

                Spacer()
            }
            .navigationTitle("Cash Counter")
            .toolbar {
                // Botón de menú en la barra superior
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        showMenu.toggle()
                    }) {
                        Image(systemName: "line.horizontal.3")
                            .imageScale(.large)
                    }
                }
            }
            .sheet(isPresented: $showMenu) {
                MenuView(viewModel: viewModel)
            }
            .onTapGesture {
                focusedField = nil
            }
        }
    }

    private func resetQuantities() {
        // Restablece la cantidad de cada denominación a cero sin borrar la configuración
        for index in viewModel.denominations.indices {
            viewModel.denominations[index].quantity = 0
        }
        viewModel.calculateTotal() // Llama a calculateTotal para actualizar el total
    }

    private func copyToClipboard() {
        let totalAmount = viewModel.totalAmount
        UIPasteboard.general.string = String(format: "%.2f", totalAmount)
    }

    private func shareContent() {
        let totalAmount = viewModel.totalAmount
        let activityVC = UIActivityViewController(activityItems: ["El total es: \(String(format: "%.2f", totalAmount))"], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
}

// Vista de vista previa
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: MoneyCounterViewModel())
    }
}
