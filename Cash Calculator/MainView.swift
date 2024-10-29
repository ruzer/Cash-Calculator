// MainView.swift
import SwiftUI

struct MainView: View {
    @EnvironmentObject var appViewModel: AppViewModel
    @StateObject var moneyCounterViewModel = MoneyCounterViewModel()

    var body: some View {
        Group {
            if appViewModel.currentView == .content {
                ContentView(viewModel: moneyCounterViewModel)
            } else {
                MenuView(viewModel: moneyCounterViewModel)
            }
        }
    }
}

// Vista de vista previa
struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
            .environmentObject(AppViewModel())
    }
}
