import SwiftUI

struct MenuView: View {
    @ObservedObject var viewModel: MoneyCounterViewModel
    @EnvironmentObject var appViewModel: AppViewModel
    @Environment(\.dismiss) var dismiss // Para cerrar la hoja de menú
    @State private var showDenominations = false
    @State private var showSettings = false
    @State private var showSupport = false

    var body: some View {
        VStack(spacing: 20) {
            // Ícono de la app y nombre centrado
            VStack {
                Image(systemName: "dollarsign.circle.fill")
                    .resizable()
                    .frame(width: 80, height: 80)
                    .foregroundColor(.green)
                    .padding(.top, 40)

                Text("Cash Counter")
                    .font(.largeTitle)
                    .bold()
                    .padding(.top, 8)
            }
            .padding(.bottom, 40)

            // Botón de inicio
            Button(action: {
                dismiss() // Cierra el menú y regresa a la vista previa
            }) {
                HStack {
                    Image(systemName: "house.fill")
                        .font(.title)
                    Text("Inicio")
                        .font(.title2)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }

            // Botones de denominaciones, ajustes, apóyanos, y compartir aplicación
            // Botón de denominaciones
            Button(action: {
                showDenominations = true
            }) {
                HStack {
                    Image(systemName: "list.bullet")
                        .font(.title)
                    Text("Denominaciones")
                        .font(.title2)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .sheet(isPresented: $showDenominations) {
                DenominationsView(viewModel: viewModel)
            }

            // Botón de ajustes
            Button(action: {
                showSettings = true
            }) {
                HStack {
                    Image(systemName: "gearshape.fill")
                        .font(.title)
                    Text("Ajustes")
                        .font(.title2)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .sheet(isPresented: $showSettings) {
                Text("Ajustes") // Reemplaza con tu vista de ajustes real
            }

            // Botón de apóyanos
            Button(action: {
                showSupport = true
            }) {
                HStack {
                    Image(systemName: "heart.fill")
                        .font(.title)
                    Text("Apóyanos")
                        .font(.title2)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }
            .sheet(isPresented: $showSupport) {
                Text("Apóyanos") // Reemplaza con tu vista de Apóyanos real
            }

            // Botón de compartir aplicación
            Button(action: {
                shareApp()
            }) {
                HStack {
                    Image(systemName: "square.and.arrow.up")
                        .font(.title)
                    Text("Compartir Aplicación")
                        .font(.title2)
                }
                .padding()
                .frame(maxWidth: .infinity)
                .background(Color.blue)
                .foregroundColor(.white)
                .cornerRadius(10)
                .padding(.horizontal)
            }

            Spacer()
        }
        .navigationBarTitle("Cash Counter", displayMode: .inline)
    }

    // Función para compartir la app
    private func shareApp() {
        let text = "¡Prueba Cash Counter para contar tu dinero fácilmente!"
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)

        if let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene {
            windowScene.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
        }
    }
}

// Vista de vista previa
struct MenuView_Previews: PreviewProvider {
    static var previews: some View {
        MenuView(viewModel: MoneyCounterViewModel())
            .environmentObject(AppViewModel())
    }
}
