
// AppViewModel.swift
import SwiftUI

class AppViewModel: ObservableObject {
    @Published var currentView: AppView = .content
    @Published var isMenuVisible: Bool = false

    enum AppView {
        case content
        case menu
    }

    func goToContent() {
        currentView = .content
    }

    func goToMenu() {
        currentView = .menu
    }
}
