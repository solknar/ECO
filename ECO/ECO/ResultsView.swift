//
//  ResultsView.swift
//  ECO
//
//  View for displaying assessment results
//

import SwiftUI

struct ResultsView: View {
    let results: AssessmentResults
    @Environment(\.dismiss) private var dismiss

    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd 'de' MMMM 'de' yyyy"
        formatter.locale = Locale(identifier: "pt_BR")
        return formatter
    }

    // Calculate temperament based on wanted (Y) and expressed (X) scores
    private func getTemperament(wanted: Int, expressed: Int) -> String {
        if wanted >= 0 && wanted <= 3 && expressed >= 0 && expressed <= 3 {
            return "Melancólico"
        } else if wanted >= 6 && wanted <= 9 && expressed >= 0 && expressed <= 3 {
            return "Supina"
        } else if wanted >= 0 && wanted <= 3 && expressed >= 6 && expressed <= 9 {
            return "Colérico"
        } else if wanted >= 6 && wanted <= 9 && expressed >= 6 && expressed <= 9 {
            return "Sanguíneo"
        }
        return ""
    }

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                // Header
                VStack(alignment: .center, spacing: 8) {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 60))
                        .foregroundColor(.green)

                    Text("Avaliação Concluída!")
                        .font(.title)
                        .fontWeight(.bold)

                    Text("Data: \(dateFormatter.string(from: results.completionDate))")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 20)

                // User Information
                GroupBox(label: Label("Informações do Usuário", systemImage: "person.fill")) {
                    VStack(alignment: .leading, spacing: 12) {
                        InfoRow(label: "Nome Completo", value: results.userInfo.fullName)
                        InfoRow(
                            label: "Data de Nascimento",
                            value: dateFormatter.string(from: results.userInfo.dateOfBirth)
                        )
                        InfoRow(label: "Idade", value: "\(results.userInfo.age) anos")
                    }
                    .padding(.vertical, 8)
                }

                // Results
                GroupBox(label: Label("Resultados da Avaliação", systemImage: "chart.bar.fill")) {
                    VStack(spacing: 16) {
                        // Inclusion
                        let inclusionTemperament = getTemperament(
                            wanted: results.scores[.wantedInclusion] ?? 0,
                            expressed: results.scores[.expressedInclusion] ?? 0
                        )
                        SectionHeader(
                            title: inclusionTemperament.isEmpty ? "Inclusão" : "Inclusão (\(inclusionTemperament))",
                            icon: "person.3.fill",
                            color: .blue
                        )
                        ScoreRow(
                            label: "Inclusão Desejada",
                            score: results.scores[.wantedInclusion] ?? 0,
                            maxScore: 9
                        )
                        ScoreRow(
                            label: "Inclusão Expressa",
                            score: results.scores[.expressedInclusion] ?? 0,
                            maxScore: 9
                        )

                        Divider()

                        // Control
                        let controlTemperament = getTemperament(
                            wanted: results.scores[.wantedControl] ?? 0,
                            expressed: results.scores[.expressedControl] ?? 0
                        )
                        SectionHeader(
                            title: controlTemperament.isEmpty ? "Controle" : "Controle (\(controlTemperament))",
                            icon: "slider.horizontal.3",
                            color: .orange
                        )
                        ScoreRow(
                            label: "Controle Desejado",
                            score: results.scores[.wantedControl] ?? 0,
                            maxScore: 9
                        )
                        ScoreRow(
                            label: "Controle Expressa",
                            score: results.scores[.expressedControl] ?? 0,
                            maxScore: 9
                        )

                        Divider()

                        // Affection
                        let affectionTemperament = getTemperament(
                            wanted: results.scores[.wantedAffection] ?? 0,
                            expressed: results.scores[.expressedAffection] ?? 0
                        )
                        SectionHeader(
                            title: affectionTemperament.isEmpty ? "Afeto" : "Afeto (\(affectionTemperament))",
                            icon: "heart.fill",
                            color: .pink
                        )
                        ScoreRow(
                            label: "Afeto Desejado",
                            score: results.scores[.wantedAffection] ?? 0,
                            maxScore: 9
                        )
                        ScoreRow(
                            label: "Afeto Expressa",
                            score: results.scores[.expressedAffection] ?? 0,
                            maxScore: 9
                        )
                    }
                    .padding(.vertical, 8)
                }

                // Info text
                Text("Os resultados apresentados refletem suas respostas ao questionário FIRO-B, que avalia necessidades interpessoais em três dimensões: Inclusão, Controle e Afeto. Cada dimensão possui dois aspectos: Desejada (o que você quer receber dos outros) e Expressa (o que você demonstra aos outros).")
                    .font(.caption)
                    .foregroundColor(.secondary)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)

                // Finish button
                Button(action: { dismiss() }) {
                    HStack {
                        Spacer()
                        Text("Finalizar")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding()
                    .background(Color.accentColor)
                    .foregroundColor(.white)
                    .cornerRadius(12)
                }
                .padding(.top)
            }
            .padding()
        }
        .navigationTitle("Resultados")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
    }
}

// MARK: - Supporting Views

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .foregroundColor(.secondary)
            Spacer()
            Text(value)
                .fontWeight(.medium)
        }
    }
}

struct SectionHeader: View {
    let title: String
    let icon: String
    let color: Color

    var body: some View {
        HStack {
            Image(systemName: icon)
                .foregroundColor(color)
            Text(title)
                .font(.headline)
                .foregroundColor(color)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}

struct ScoreRow: View {
    let label: String
    let score: Int
    let maxScore: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                Text(label)
                    .font(.subheadline)
                Spacer()
                Text("\(score)")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.accentColor)
            }

            GeometryReader { geometry in
                ZStack(alignment: .leading) {
                    Rectangle()
                        .fill(Color(.systemGray5))
                        .frame(height: 8)
                        .cornerRadius(4)

                    Rectangle()
                        .fill(Color.accentColor)
                        .frame(width: geometry.size.width * (Double(score) / Double(maxScore)), height: 8)
                        .cornerRadius(4)
                }
            }
            .frame(height: 8)
        }
    }
}

#Preview {
    NavigationView {
        ResultsView(
            results: AssessmentResults(
                userInfo: UserInfo(
                    fullName: "João Silva",
                    dateOfBirth: Calendar.current.date(byAdding: .year, value: -30, to: Date())!
                ),
                answers: [
                    1: 4, 2: 3, 3: 5, 4: 6, 5: 4,
                    6: 3, 7: 5, 8: 6, 9: 5, 10: 4
                    // ... (sample answers)
                ]
            )
        )
    }
}
