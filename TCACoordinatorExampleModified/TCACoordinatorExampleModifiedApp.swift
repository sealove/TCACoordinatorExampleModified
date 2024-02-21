//
//  TCACoordinatorExampleModifiedApp.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

@main
struct TCACoordinatorExampleModifiedApp: App {
    var body: some Scene {
        WindowGroup {
//            ContentView()
            AppCoordinatorView(
                coordinator: Store.init(
                    initialState: AppCoordinator.State.initialState,
                    reducer: {
                        AppCoordinator()
                    })
                )
        }
    }
}
