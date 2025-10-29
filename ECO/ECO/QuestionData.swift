//
//  QuestionData.swift
//  ECO
//
//  Contains all 54 questions for the FIRO-B assessment
//

import Foundation

struct QuestionData {
    static let allQuestions: [Question] = [
        // Questions 1-16 (Frequency scale)
        Question(id: 1, text: "Eu tento estar com as pessoas", optionSet: .frequency),
        Question(id: 2, text: "Eu deixo as pessoas decidirem o que elas querem fazer", optionSet: .frequency),
        Question(id: 3, text: "Eu me junto a grupos sociais", optionSet: .frequency),
        Question(id: 4, text: "Eu tento ter relacionamentos próximos com as pessoas", optionSet: .frequency),
        Question(id: 5, text: "Eu tento me filiar a organizações sociais", optionSet: .frequency),
        Question(id: 6, text: "Eu deixo outras pessoas exercerem muita influência sobre mim", optionSet: .frequency),
        Question(id: 7, text: "Eu tento estar incluído em atividades sociais informais", optionSet: .frequency),
        Question(id: 8, text: "Eu tento ter relações pessoais com as pessoas", optionSet: .frequency),
        Question(id: 9, text: "Eu tento incluir outras pessoas nos meus planos", optionSet: .frequency),
        Question(id: 10, text: "Eu deixo outras pessoas controlarem as minhas ações", optionSet: .frequency),
        Question(id: 11, text: "Eu tento ter pessoas à minha volta", optionSet: .frequency),
        Question(id: 12, text: "Eu tento me envolver pessoalmente com as pessoas", optionSet: .frequency),
        Question(id: 13, text: "Quando as pessoas estão envolvidas em alguma atividade eu tento me unir a elas", optionSet: .frequency),
        Question(id: 14, text: "Eu sou facilmente guiado por outras pessoas", optionSet: .frequency),
        Question(id: 15, text: "Eu tento não estar sozinho", optionSet: .frequency),
        Question(id: 16, text: "Eu tento participar de atividades em grupos", optionSet: .frequency),

        // Questions 17-40 (Quantity scale)
        Question(id: 17, text: "Eu tento ser amigável com as pessoas", optionSet: .frequency),
        Question(id: 18, text: "Eu deixo as pessoas decidirem o que elas querem fazer", optionSet: .quantity),
        Question(id: 19, text: "Os meus relacionamentos pessoais são frios e distantes", optionSet: .quantity),
        Question(id: 20, text: "Eu permito que outras pessoas executem suas responsabilidades", optionSet: .quantity),
        Question(id: 21, text: "Eu tento ter relacionamentos íntimos com as pessoas", optionSet: .quantity),
        Question(id: 22, text: "Eu deixo as pessoas influenciarem muito as minhas ações", optionSet: .quantity),
        Question(id: 23, text: "Eu tento chegar próximo das pessoas", optionSet: .quantity),
        Question(id: 24, text: "Eu permito que as pessoas controlem as minhas ações", optionSet: .quantity),
        Question(id: 25, text: "Eu ajo de forma fria e distante com as pessoas", optionSet: .quantity),
        Question(id: 26, text: "Eu sou facilmente guiado por outras pessoas", optionSet: .quantity),
        Question(id: 27, text: "Eu tento ter relações próximas e pessoais com outras pessoas", optionSet: .quantity),
        Question(id: 28, text: "Eu gosto que as pessoas me convidem para suas atividades", optionSet: .quantity),
        Question(id: 29, text: "Eu gosto que as pessoas ajam próximas e pessoalmente comigo", optionSet: .quantity),
        Question(id: 30, text: "Eu tento influenciar fortemente as ações de outras pessoas", optionSet: .quantity),
        Question(id: 31, text: "Eu gosto que as pessoas me convidem para me juntar às suas atividades", optionSet: .quantity),
        Question(id: 32, text: "Eu gosto que as pessoas ajam objetivamente comigo", optionSet: .quantity),
        Question(id: 33, text: "Eu tento tomar a liderança quando estou com as pessoas", optionSet: .quantity),
        Question(id: 34, text: "Eu gosto que as pessoas me incluam em suas atividades", optionSet: .quantity),
        Question(id: 35, text: "Eu gosto que as pessoas ajam frias e distantes comigo", optionSet: .quantity),
        Question(id: 36, text: "Eu tento fazer com que as pessoas façam as coisas da maneira que eu acho que devem ser feitas", optionSet: .quantity),
        Question(id: 37, text: "Eu gosto que as pessoas me perguntem se quero participar de suas discussões", optionSet: .quantity),
        Question(id: 38, text: "Eu gosto que as pessoas ajam amigavelmente comigo", optionSet: .quantity),
        Question(id: 39, text: "Eu gosto que as pessoas me convidem para participar em suas atividades", optionSet: .quantity),
        Question(id: 40, text: "Eu gosto que as pessoas ajam distantes comigo", optionSet: .quantity),

        // Questions 41-54 (Frequency scale)
        Question(id: 41, text: "Eu tento ser dominante quando estou com as pessoas", optionSet: .frequency),
        Question(id: 42, text: "Eu gosto que as pessoas me convidem para suas atividades", optionSet: .frequency),
        Question(id: 43, text: "Eu gosto que as pessoas ajam objetivamente comigo", optionSet: .frequency),
        Question(id: 44, text: "Eu tento fazer com que as pessoas façam as coisas que eu gosto", optionSet: .frequency),
        Question(id: 45, text: "Eu gosto que as pessoas me convidem para me juntar às suas atividades", optionSet: .frequency),
        Question(id: 46, text: "Eu gosto que as pessoas ajam frias e distantes para comigo", optionSet: .frequency),
        Question(id: 47, text: "Eu tento influenciar fortemente as ações das pessoas", optionSet: .frequency),
        Question(id: 48, text: "Eu gosto que as pessoas me incluam em suas atividades", optionSet: .frequency),
        Question(id: 49, text: "Eu gosto que as pessoas ajam intimamente e pessoalmente comigo", optionSet: .frequency),
        Question(id: 50, text: "Eu tento assumir a liderança quando estou com outras pessoas", optionSet: .frequency),
        Question(id: 51, text: "Eu gosto que as pessoas me convidem para participar em suas atividades", optionSet: .frequency),
        Question(id: 52, text: "Eu gosto que as pessoas ajam distantes para comigo", optionSet: .frequency),
        Question(id: 53, text: "Eu tento que as pessoas façam as coisas da maneira que eu gosto", optionSet: .frequency),
        Question(id: 54, text: "Eu assumo a liderança quando estou com outras pessoas", optionSet: .frequency)
    ]

    static func getOptions(for optionSet: Question.QuestionOptionSet) -> [(value: Int, label: String)] {
        switch optionSet {
        case .frequency:
            return [
                (1, "Nunca"),
                (2, "Raramente"),
                (3, "Ocasionalmente"),
                (4, "Algumas vezes"),
                (5, "Com frequência"),
                (6, "Sempre")
            ]
        case .quantity:
            return [
                (1, "Nenhuma"),
                (2, "Uma ou duas"),
                (3, "Poucas"),
                (4, "Algumas"),
                (5, "Muitas"),
                (6, "A maioria")
            ]
        }
    }
}
