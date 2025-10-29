//
//  QuestionnaireView.swift
//  ECO
//
//  View for displaying and answering the questionnaire
//

import SwiftUI

struct QuestionnaireView: View {
    let userInfo: UserInfo
    var onComplete: (AssessmentResults) -> Void

    @State private var currentQuestionIndex = 0
    @State private var answers: [Int: Int] = [:]
    @State private var showingIncompleteAlert = false

    private let questions = QuestionData.allQuestions

    var body: some View {
        VStack(spacing: 0) {
            // Progress bar
            ProgressView(value: Double(currentQuestionIndex + 1), total: Double(questions.count))
                .padding()

            // Progress text
            Text("Pergunta \(currentQuestionIndex + 1) de \(questions.count)")
                .font(.caption)
                .foregroundColor(.secondary)
                .padding(.bottom, 8)

            ScrollView {
                VStack(alignment: .leading, spacing: 20) {
                    // Question text
                    Text(questions[currentQuestionIndex].text)
                        .font(.title3)
                        .fontWeight(.medium)
                        .padding()
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(Color(.systemBackground))
                        .cornerRadius(12)
                        .shadow(radius: 2)

                    // Answer options
                    VStack(spacing: 12) {
                        let options = QuestionData.getOptions(for: questions[currentQuestionIndex].optionSet)
                        ForEach(options, id: \.value) { option in
                            AnswerButton(
                                value: option.value,
                                label: option.label,
                                isSelected: answers[questions[currentQuestionIndex].id] == option.value,
                                action: {
                                    selectAnswer(option.value)
                                }
                            )
                        }
                    }
                    .padding(.horizontal)
                }
                .padding()
            }

            // Navigation buttons
            HStack {
                Button(action: previousQuestion) {
                    Label("Anterior", systemImage: "chevron.left")
                }
                .disabled(currentQuestionIndex == 0)

                Spacer()

                if currentQuestionIndex < questions.count - 1 {
                    Button(action: nextQuestion) {
                        Label("Próxima", systemImage: "chevron.right")
                            .labelStyle(.titleAndIcon)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(answers[questions[currentQuestionIndex].id] == nil)
                } else {
                    Button(action: completeQuestionnaire) {
                        Label("Concluir", systemImage: "checkmark")
                            .labelStyle(.titleAndIcon)
                    }
                    .buttonStyle(.borderedProminent)
                    .disabled(answers[questions[currentQuestionIndex].id] == nil)
                }
            }
            .padding()
        }
        .navigationTitle("Questionário ECO")
        .navigationBarTitleDisplayMode(.inline)
        .alert("Questionário Incompleto", isPresented: $showingIncompleteAlert) {
            Button("OK", role: .cancel) { }
        } message: {
            Text("Por favor, responda todas as perguntas antes de continuar.")
        }
    }

    private func selectAnswer(_ value: Int) {
        withAnimation {
            answers[questions[currentQuestionIndex].id] = value
        }
    }

    private func nextQuestion() {
        if currentQuestionIndex < questions.count - 1 {
            withAnimation {
                currentQuestionIndex += 1
            }
        }
    }

    private func previousQuestion() {
        if currentQuestionIndex > 0 {
            withAnimation {
                currentQuestionIndex -= 1
            }
        }
    }

    private func completeQuestionnaire() {
        // Check if all questions are answered
        if answers.count == questions.count {
            let results = AssessmentResults(userInfo: userInfo, answers: answers)
            onComplete(results)
        } else {
            showingIncompleteAlert = true
        }
    }
}

// Custom answer button component
struct AnswerButton: View {
    let value: Int
    let label: String
    let isSelected: Bool
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack {
                Text("\(value)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(isSelected ? .white : .primary)
                    .frame(width: 40, height: 40)
                    .background(isSelected ? Color.accentColor : Color(.systemGray5))
                    .clipShape(Circle())

                Text(label)
                    .font(.body)
                    .foregroundColor(isSelected ? .white : .primary)

                Spacer()

                if isSelected {
                    Image(systemName: "checkmark.circle.fill")
                        .foregroundColor(.white)
                }
            }
            .padding()
            .background(isSelected ? Color.accentColor : Color(.systemGray6))
            .cornerRadius(12)
        }
        .buttonStyle(.plain)
    }
}

#Preview {
    NavigationView {
        QuestionnaireView(
            userInfo: UserInfo(
                fullName: "João Silva",
                dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!
            )
        ) { results in
            print("Results: \(results)")
        }
    }
}
