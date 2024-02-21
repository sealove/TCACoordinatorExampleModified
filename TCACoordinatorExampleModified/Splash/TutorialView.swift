//
//  TutorialView.swift
//  TCACoordinatorExampleModified
//
//  Created by hanwool oh on 2/20/24.
//

import SwiftUI
import ComposableArchitecture
import TCACoordinators

struct TutorialView: View {
    let store: StoreOf<TutorialStore>
    var body: some View {
        WithViewStore(store, observe: { $0 }) { viewStore in
            TabView(selection: viewStore.binding(
                get: { $0.tabSelection },
                send: { .nextPage($0) }
            )) {
                TutorialPage1View()
                    .tag(0)
                TutorialPage2View()
                    .tag(1)
                TutorialPage3View(isTutorialComplete: viewStore.binding(
                    get: { $0.isTutorialComplete },
                    send: { _ in .completedTutorial }
                ))
                    .tag(2)
            }
            .tabViewStyle(.page)
        }
    }
}

#Preview {
    let store = Store(initialState: TutorialStore.State(), reducer: { TutorialStore() })
    return TutorialView(store: store)
}

@Reducer
struct TutorialStore {
    struct State: Equatable {
        var tabSelection: Int = 0
        var isTutorialComplete: Bool = false

    }
    
    enum Action {
        case nextPage(Int)
        case completedTutorial
    }
    
    var body: some ReducerOf<Self> {
        Reduce<State, Action> { state, action in
            switch action {
                case .nextPage(let index):
                    state.tabSelection = index
                    return .none
                case .completedTutorial:
                    UserDefaults.standard.setValue(true, forKey: "isTutorialComplete")
                    state.isTutorialComplete = true
                    return .none
            }
        }
    }
}

struct TutorialPage1View: View {
    var body: some View {
        Text("Hello TCA, Let's start tutorial.")
//            .navigationTitle("Tutorial")
//            .toolbarTitleDisplayMode(.inline)
    }
}

struct TutorialPage2View: View {
    var body: some View {
        Text("Hello TCA-Coordinator\nI like coordinator pattern")
    }
}

struct TutorialPage3View: View {
    @Binding var isTutorialComplete: Bool
    var body: some View {
        VStack {
            Text("TCA-Coordinator-Example gogo😉")
            Button {
                isTutorialComplete = true
            } label: {
                Text("Ok, Start")
            }
        }
    }
}
