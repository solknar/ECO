//
//  UserInfoView.swift
//  ECO
//
//  View for collecting user information
//

import SwiftUI

struct UserInfoView: View {
    @State private var fullName: String = ""
    @State private var dateOfBirth = Date()
    @State private var showingValidationAlert = false
    @State private var validationMessage = ""

    var onContinue: (UserInfo) -> Void

    private let maxDate = Date()
    private let minDate = Calendar.current.date(byAdding: .year, value: -120, to: Date()) ?? Date()

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Informações Pessoais")) {
                    TextField("Nome Completo", text: $fullName)
                        .textContentType(.name)
                        .autocapitalization(.words)

                    DatePicker(
                        "Data de Nascimento",
                        selection: $dateOfBirth,
                        in: minDate...maxDate,
                        displayedComponents: .date
                    )
                    .datePickerStyle(.compact)
                }

                Section {
                    Button(action: validateAndContinue) {
                        HStack {
                            Spacer()
                            Text("Continuar")
                                .fontWeight(.semibold)
                            Spacer()
                        }
                    }
                    .disabled(fullName.trimmingCharacters(in: .whitespaces).isEmpty)
                }
            }
            .navigationTitle("Bem-vindo")
            .navigationBarTitleDisplayMode(.large)
            .alert("Validação", isPresented: $showingValidationAlert) {
                Button("OK", role: .cancel) { }
            } message: {
                Text(validationMessage)
            }
        }
    }

    private func validateAndContinue() {
        let trimmedName = fullName.trimmingCharacters(in: .whitespaces)

        if trimmedName.isEmpty {
            validationMessage = "Por favor, digite seu nome completo."
            showingValidationAlert = true
            return
        }

        let age = UserInfo.calculateAge(from: dateOfBirth)
        if age < 0 || age > 120 {
            validationMessage = "Por favor, verifique a data de nascimento."
            showingValidationAlert = true
            return
        }

        let userInfo = UserInfo(fullName: trimmedName, dateOfBirth: dateOfBirth)
        onContinue(userInfo)
    }
}

#Preview {
    UserInfoView { userInfo in
        print("User info: \(userInfo)")
    }
}
