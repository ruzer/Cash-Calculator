import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: MoneyCounterViewModel = MoneyCounterViewModel()

    @State private var showMenu = false

    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(viewModel.denominations.indices, id: \.self) { index in
                        let denomination = viewModel.denominations[index]
                        HStack {
                            Text(denomination.name)
                            Spacer()
                            Text("\(denomination.quantity) x \(denomination.value, specifier: "%.2f")")
                            Spacer()
                            Text("\(denomination.total, specifier: "%.2f")")
                        }
                    }
                    .onDelete { indexSet in
                        viewModel.removeDenomination(at: indexSet.first!)
                    }
                }

                // Mostrar el total
                Text("Total: \(viewModel.totalAmount, specifier: "%.2f")")
                    .font(.title)
                    .padding()

                Spacer()

                // Botón para mostrar el menú
                Button(action: {
                    showMenu.toggle()
                }) {
                    Image(systemName: "line.horizontal.3")
                        .imageScale(.large)
                        .padding()
                }
                .sheet(isPresented: $showMenu) {
                    MenuView(viewModel: viewModel)
                }
            }
            .navigationTitle("Cash Counter")
        }
    }
}

// Vista de vista previa
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
