//
//  SplashView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct SplashView: View {
    let store: StoreOf<SplashStore>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            Text("This is Splash\nSleep 3seconds")
                .task {
                    try? await Task.sleep(nanoseconds: 3 * 1_000_000_000)
                    // if Tutorial Completed, go to main
                    viewStore.send(.completed)
                }
        }
    }
}

#Preview {
    let store = Store(initialState: SplashStore.State(), reducer: {
        SplashStore()
    })
    return SplashView(store: store)
}

@Reducer
struct SplashStore {
    struct State: Equatable {
        var splashCompleted: Bool = false
    }
    
    enum Action {
        case completed
    }
    
    var body: some ReducerOf<Self> {
        Reduce { state, action in
            switch action {
            case .completed:
                state.splashCompleted = true
                return .none
            }
        }
    }
}
