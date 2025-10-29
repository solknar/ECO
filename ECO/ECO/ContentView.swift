//
//  ContentView.swift
//  ECO
//
//  Main content view that manages navigation flow
//

import SwiftUI

enum AppState {
    case userInfo
    case questionnaire
    case results
}

struct ContentView: View {
    @State private var appState: AppState = .userInfo
    @State private var userInfo: UserInfo?
    @State private var results: AssessmentResults?

    var body: some View {
        NavigationStack {
            Group {
                switch appState {
                case .userInfo:
                    UserInfoView { info in
                        userInfo = info
                        appState = .questionnaire
                    }

                case .questionnaire:
                    if let userInfo = userInfo {
                        QuestionnaireView(userInfo: userInfo) { assessmentResults in
                            results = assessmentResults
                            appState = .results
                        }
                    }

                case .results:
                    if let results = results {
                        ResultsView(results: results)
                            .toolbar {
                                ToolbarItem(placement: .navigationBarTrailing) {
                                    Button("Novo") {
                                        restartAssessment()
                                    }
                                }
                            }
                    }
                }
            }
        }
    }

    private func restartAssessment() {
        appState = .userInfo
        userInfo = nil
        results = nil
    }
}

#Preview {
    ContentView()
}
