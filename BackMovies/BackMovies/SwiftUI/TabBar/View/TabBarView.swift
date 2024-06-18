//
//  TabBarView.swift
//  BackMovies
//
//  Created by Lucas Gomesx on 11/06/24.
//

import SwiftUI

struct TabBarView: View {
    
    @State private var selectedTab: Int = 1
    
    var body: some View {
        TabView(selection: $selectedTab) {
            PosterView()
                .tabItem { Label("Cinema", systemImage: "film") }
                .tag(1)
            
            SearchStoryboard()
                .ignoresSafeArea()
                .tabItem { Label("Busca", systemImage: "magnifyingglass") }
                .tag(2)
            
            FavoriteStoryboard()
                .ignoresSafeArea()
                .tabItem { Label("Favoritos", systemImage: "heart") }
                .tag(3)
            
            ProfileStoryboard()
                .ignoresSafeArea()
                .tabItem { Label("Perfil", systemImage: "person") }
                .tag(4)
        }
        .onAppear(perform: {
            tabAppearance()
        })
    }
    
    func tabAppearance() {
        let appearance = UITabBarAppearance()
        appearance.backgroundEffect = UIBlurEffect(style: .systemUltraThinMaterial)
        appearance.backgroundColor = UIColor(Color(.backGray).opacity(0.1))
        UITabBar.appearance().standardAppearance = appearance
        UITabBar.appearance().scrollEdgeAppearance = appearance
    }
    
}

struct PosterStoryboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Aqui você carrega o ViewController do Storyboard
        let storyboard = UIStoryboard(name: "PosterView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "PosterViewController")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Atualizar o UIViewController, se necessário
    }
}

struct SearchStoryboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Aqui você carrega o ViewController do Storyboard
        let storyboard = UIStoryboard(name: "SearchView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "SearchViewController")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Atualizar o UIViewController, se necessário
    }
}

struct FavoriteStoryboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Aqui você carrega o ViewController do Storyboard
        let storyboard = UIStoryboard(name: "FavoriteView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "FavoriteViewController")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Atualizar o UIViewController, se necessário
    }
}

struct ProfileStoryboard: UIViewControllerRepresentable {
    func makeUIViewController(context: Context) -> UIViewController {
        // Aqui você carrega o ViewController do Storyboard
        let storyboard = UIStoryboard(name: "ProfileView", bundle: Bundle.main)
        let viewController = storyboard.instantiateViewController(identifier: "ProfileViewController")
        return viewController
    }
    
    func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        // Atualizar o UIViewController, se necessário
    }
}


#Preview {
    TabBarView()
}
