import SwiftUI

@main
struct CashCounterApp: App {
    // Se inicializa el ViewModel con @StateObject
    @StateObject private var appViewModel = AppViewModel()

    var body: some Scene {
        WindowGroup {
            MainView()
                .environmentObject(appViewModel) // Se pasa el environmentObject correctamente
        }
    }
}
