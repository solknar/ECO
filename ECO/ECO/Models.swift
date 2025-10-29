//
//  Models.swift
//  ECO
//
//  Data models for the FIRO-B questionnaire app
//

import Foundation

// MARK: - User Information
struct UserInfo {
    var fullName: String
    var dateOfBirth: Date
    var age: Int

    init(fullName: String, dateOfBirth: Date) {
        self.fullName = fullName
        self.dateOfBirth = dateOfBirth
        self.age = UserInfo.calculateAge(from: dateOfBirth)
    }

    static func calculateAge(from dateOfBirth: Date) -> Int {
        let calendar = Calendar.current
        let now = Date()
        let ageComponents = calendar.dateComponents([.year], from: dateOfBirth, to: now)
        return ageComponents.year ?? 0
    }
}

// MARK: - Question Model
struct Question: Identifiable {
    let id: Int
    let text: String
    let optionSet: QuestionOptionSet

    enum QuestionOptionSet {
        case frequency  // Questions 1-16, 41-54
        case quantity   // Questions 17-40
    }
}

// MARK: - Variable Groups
enum VariableType: String, CaseIterable {
    case wantedInclusion = "wanted_inclusion"
    case expressedInclusion = "expressed_inclusion"
    case wantedControl = "wanted_control"
    case expressedControl = "expressed_control"
    case wantedAffection = "wanted_affection"
    case expressedAffection = "expressed_affection"

    var displayName: String {
        switch self {
        case .wantedInclusion: return "Inclusão Desejada"
        case .expressedInclusion: return "Inclusão Expressa"
        case .wantedControl: return "Controle Desejado"
        case .expressedControl: return "Controle Expressa"
        case .wantedAffection: return "Afeto Desejado"
        case .expressedAffection: return "Afeto Expressa"
        }
    }
}

struct VariableGroup {
    let type: VariableType
    let questions: [Int: [Int]]  // Question number: Valid answers

    static let allGroups: [VariableGroup] = [
        VariableGroup(
            type: .wantedInclusion,
            questions: [
                28: [5, 6],
                31: [5, 6],
                34: [5, 6],
                37: [6],
                39: [6],
                42: [5, 6],
                45: [5, 6],
                48: [5, 6],
                51: [5, 6]
            ]
        ),
        VariableGroup(
            type: .expressedInclusion,
            questions: [
                1: [4, 5, 6],
                3: [3, 4, 5, 6],
                5: [3, 4, 5, 6],
                7: [4, 5, 6],
                9: [5, 6],
                11: [5, 6],
                13: [5, 6],
                15: [6],
                16: [6]
            ]
        ),
        VariableGroup(
            type: .wantedControl,
            questions: [
                2: [3, 4, 5, 6],
                6: [3, 4, 5, 6],
                10: [4, 5, 6],
                14: [4, 5, 6],
                18: [4, 5, 6],
                20: [4, 5, 6],
                22: [3, 4, 5, 6],
                24: [4, 5, 6],
                26: [4, 5, 6]
            ]
        ),
        VariableGroup(
            type: .expressedControl,
            questions: [
                30: [4, 5, 6],
                33: [4, 5, 6],
                36: [5, 6],
                41: [3, 4, 5, 6],
                44: [4, 5, 6],
                47: [4, 5, 6],
                50: [5, 6],
                53: [5, 6],
                54: [5, 6]
            ]
        ),
        VariableGroup(
            type: .wantedAffection,
            questions: [
                29: [5, 6],
                32: [5, 6],
                35: [1, 2],
                38: [5, 6],
                40: [1, 2],
                43: [6],
                46: [1, 2],
                49: [5, 6],
                52: [1, 2]
            ]
        ),
        VariableGroup(
            type: .expressedAffection,
            questions: [
                4: [5, 6],
                8: [5, 6],
                12: [6],
                17: [5, 6],
                19: [1, 2, 3],
                21: [5, 6],
                23: [5, 6],
                25: [1, 2, 3],
                27: [5, 6]
            ]
        )
    ]
}

// MARK: - Results Model
struct AssessmentResults {
    let userInfo: UserInfo
    let scores: [VariableType: Int]
    let completionDate: Date

    init(userInfo: UserInfo, answers: [Int: Int]) {
        self.userInfo = userInfo
        self.completionDate = Date()

        var calculatedScores: [VariableType: Int] = [:]

        // Calculate scores for each variable group
        for group in VariableGroup.allGroups {
            var score = 0
            for (questionNum, validAnswers) in group.questions {
                if let userAnswer = answers[questionNum],
                   validAnswers.contains(userAnswer) {
                    score += 1
                }
            }
            calculatedScores[group.type] = score
        }

        self.scores = calculatedScores
    }
}
