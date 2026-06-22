//
//  HomeView.swift
//  HomeView
//
//  Created by Neosoft on 19/06/26.
//

import SwiftUI
import Common
import Login

public struct HomeView: View {
    @EnvironmentObject var appState: AppState
    
    public init() {
    }
    
    public var body: some View {
        VStack(spacing: 20) {
            Text("Home3")
                .font(.title)
                .foregroundStyle(AppColor.vishnuGreen)
            
            Text(LoginState.shared.userName)
            
            Button() {
                appState.isLoggedIn = false
            } label: {
                Text("Logout")
            }
        }
        .padding()
    }
}

#Preview {
    HomeView()
}


