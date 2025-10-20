package main

import (
	"bufio"
	"fmt"
	"os"
	"strconv"
	"strings"
	"time"
)

// Create a slice of Portuguese month names
var portugueseMonths = []string{
	"",        // Index 0 (unused)
	"Janeiro", // 1
	"Fevereiro",
	"Março",
	"Abril",
	"Maio",
	"Junho",
	"Julho",
	"Agosto",
	"Setembro",
	"Outubro",
	"Novembro",
	"Dezembro",
}

// Struct to hold variable groups with their associated questions and conditions
type VariableGroup struct {
	Name        string
	Questions   map[int][]int // Mapping of question number to acceptable answers
	Description string        // Optional description for clarity
}

// Function to read user input with a prompt
func readInput(prompt string) string {
	reader := bufio.NewReader(os.Stdin)
	for {
		fmt.Print(prompt)
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("Erro ao ler a entrada. Por favor, tente novamente.")
			continue
		}
		input = strings.TrimSpace(input)
		if input == "" {
			fmt.Println("A entrada não pode estar vazia. Por favor, tente novamente.")
			continue
		}
		return input
	}
}

// Function to parse date with multiple formats
func parseDate(input string) (time.Time, error) {
	layouts := []string{
		"2006-01-02",
		"02-01-2006",
		"02/01/2006",
		"January 2, 2006",
		"2 Jan 2006",
	}
	var t time.Time
	var err error
	for _, layout := range layouts {
		t, err = time.Parse(layout, input)
		if err == nil {
			return t, nil
		}
	}
	return t, fmt.Errorf("formato de data inválido")
}

// Function to get a valid answer (1-6) from the user
func getValidAnswer(questionNumber int) int {
	reader := bufio.NewReader(os.Stdin)
	for {
		fmt.Printf("Resposta (1-6): ")
		input, err := reader.ReadString('\n')
		if err != nil {
			fmt.Println("Erro ao ler a entrada. Por favor, insira um número entre 1 e 6.")
			continue
		}
		input = strings.TrimSpace(input)
		answer, err := strconv.Atoi(input)
		if err != nil || answer < 1 || answer > 6 {
			fmt.Println("Entrada inválida. Por favor, insira um número entre 1 e 6.")
			continue
		}
		return answer
	}
}

// Function to calculate age based on Date of Birth and Today's Date
func calculateAge(dob, today time.Time) int {
	age := today.Year() - dob.Year()

	// Adjust age if the birthday hasn't occurred yet this year
	if today.YearDay() < dob.YearDay() {
		age--
	}

	return age
}

func main() {
	// Gather Initial Information

	// Prompt for Full Name
	fullName := readInput("Digite seu Nome Completo: ")

	// Prompt for Date of Birth
	var dob time.Time
	for {
		dobInput := readInput("Digite sua Data de Nascimento (AAAA-MM-DD): ")
		parsedDOB, err := parseDate(dobInput)
		if err != nil {
			fmt.Println("Formato de Data de Nascimento inválido. Por favor, use AAAA-MM-DD ou outros formatos suportados.")
			continue
		}
		dob = parsedDOB
		break
	}

	// Get Today's Date Automatically
	today := time.Now()

	// Calculate Age
	age := calculateAge(dob, today)

	// Display Initial Information
	fmt.Println("\n--- Informações do Usuário ---")
	fmt.Printf("Nome Completo: %s\n", fullName)
	dobDay := dob.Day()
	dobMonth := portugueseMonths[int(dob.Month())]
	dobYear := dob.Year()
	fmt.Printf("Data de Nascimento: %02d de %s de %d\n", dobDay, dobMonth, dobYear)
	todayDay := today.Day()
	todayMonth := portugueseMonths[int(today.Month())]
	todayYear := today.Year()
	fmt.Printf("Data de Hoje: %02d de %s de %d\n", todayDay, todayMonth, todayYear)
	fmt.Printf("Idade: %d anos\n\n", age)

	// Initialize variables to store the total points
	wanted_inclusion := 0
	expressed_inclusion := 0
	wanted_control := 0
	expressed_control := 0
	wanted_affection := 0
	expressed_affection := 0

	// Define the six variable groups with their associated questions and conditions
	variableGroups := []VariableGroup{
		{
			Name: "wanted_inclusion",
			Questions: map[int][]int{
				28: {5, 6},
				31: {5, 6},
				34: {5, 6},
				37: {6},
				39: {6},
				42: {5, 6},
				45: {5, 6},
				48: {5, 6},
				51: {5, 6},
			},
			Description: "Inclusão Desejada",
		},
		{
			Name: "expressed_inclusion",
			Questions: map[int][]int{
				1:  {4, 5, 6},
				3:  {3, 4, 5, 6},
				5:  {3, 4, 5, 6},
				7:  {4, 5, 6},
				9:  {5, 6},
				11: {5, 6},
				13: {5, 6},
				15: {6},
				16: {6},
			},
			Description: "Inclusão Expressa",
		},
		{
			Name: "wanted_control",
			Questions: map[int][]int{
				2:  {3, 4, 5, 6},
				6:  {3, 4, 5, 6},
				10: {4, 5, 6},
				14: {4, 5, 6},
				18: {4, 5, 6},
				20: {4, 5, 6},
				22: {3, 4, 5, 6},
				24: {4, 5, 6},
				26: {4, 5, 6},
			},
			Description: "Controle Desejado",
		},
		{
			Name: "expressed_control",
			Questions: map[int][]int{
				30: {4, 5, 6},
				33: {4, 5, 6},
				36: {5, 6},
				41: {3, 4, 5, 6},
				44: {4, 5, 6},
				47: {4, 5, 6},
				50: {5, 6},
				53: {5, 6},
				54: {5, 6},
			},
			Description: "Controle Expressa",
		},
		{
			Name: "wanted_affection",
			Questions: map[int][]int{
				29: {5, 6},
				32: {5, 6},
				35: {1, 2},
				38: {5, 6},
				40: {1, 2},
				43: {6},
				46: {1, 2},
				49: {5, 6},
				52: {1, 2},
			},
			Description: "Afeto Desejado",
		},
		{
			Name: "expressed_affection",
			Questions: map[int][]int{
				4:  {5, 6},
				8:  {5, 6},
				12: {6},
				17: {5, 6},
				19: {1, 2, 3},
				21: {5, 6},
				23: {5, 6},
				25: {1, 2, 3},
				27: {5, 6},
			},
			Description: "Afeto Expressa",
		},
	}

	// Initialize a map to store all answers
	answers := make(map[int]int)

	// Create a map to hold the question texts
	questionTexts := map[int]string{
		1:  "Eu tento estar com as pessoas",
		2:  "Eu deixo as pessoas decidirem o que elas querem fazer",
		3:  "Eu me junto a grupos sociais",
		4:  "Eu tento ter relacionamentos próximos com as pessoas",
		5:  "Eu tento me filiar a organizações sociais",
		6:  "Eu deixo outras pessoas exercerem muita influência sobre mim",
		7:  "Eu tento estar incluído em atividades sociais informais",
		8:  "Eu tento ter relações pessoais com as pessoas",
		9:  "Eu tento incluir outras pessoas nos meus planos",
		10: "Eu deixo outras pessoas controlarem as minhas ações",
		11: "Eu tento ter pessoas à minha volta",
		12: "Eu tento me envolver pessoalmente com as pessoas",
		13: "Quando as pessoas estão envolvidas em alguma atividade eu tento me unir a elas",
		14: "Eu sou facilmente guiado por outras pessoas",
		15: "Eu tento não estar sozinho",
		16: "Eu tento participar de atividades em grupos",
		17: "Eu tento ser amigável com as pessoas",
		18: "Eu deixo as pessoas decidirem o que elas querem fazer",
		19: "Os meus relacionamentos pessoais são frios e distantes",
		20: "Eu permito que outras pessoas executem suas responsabilidades",
		21: "Eu tento ter relacionamentos íntimos com as pessoas",
		22: "Eu deixo as pessoas influenciarem muito as minhas ações",
		23: "Eu tento chegar próximo das pessoas",
		24: "Eu permito que as pessoas controlem as minhas ações",
		25: "Eu ajo de forma fria e distante com as pessoas",
		26: "Eu sou facilmente guiado por outras pessoas",
		27: "Eu tento ter relações próximas e pessoais com outras pessoas",
		28: "Eu gosto que as pessoas me convidem para suas atividades",
		29: "Eu gosto que as pessoas ajam próximas e pessoalmente comigo",
		30: "Eu tento influenciar fortemente as ações de outras pessoas",
		31: "Eu gosto que as pessoas me convidem para me juntar às suas atividades",
		32: "Eu gosto que as pessoas ajam objetivamente comigo",
		33: "Eu tento tomar a liderança quando estou com as pessoas",
		34: "Eu gosto que as pessoas me incluam em suas atividades",
		35: "Eu gosto que as pessoas ajam frias e distantes comigo",
		36: "Eu tento fazer com que as pessoas façam as coisas da maneira que eu acho que devem ser feitas",
		37: "Eu gosto que as pessoas me perguntem se quero participar de suas discussões",
		38: "Eu gosto que as pessoas ajam amigavelmente comigo",
		39: "Eu gosto que as pessoas me convidem para participar em suas atividades",
		40: "Eu gosto que as pessoas ajam distantes comigo",
		41: "Eu tento ser dominante quando estou com as pessoas",
		42: "Eu gosto que as pessoas me convidem para suas atividades",
		43: "Eu gosto que as pessoas ajam objetivamente comigo",
		44: "Eu tento fazer com que as pessoas façam as coisas que eu gosto",
		45: "Eu gosto que as pessoas me convidem para me juntar às suas atividades",
		46: "Eu gosto que as pessoas ajam frias e distantes para comigo",
		47: "Eu tento influenciar fortemente as ações das pessoas",
		48: "Eu gosto que as pessoas me incluam em suas atividades",
		49: "Eu gosto que as pessoas ajam intimamente e pessoalmente comigo",
		50: "Eu tento assumir a liderança quando estou com outras pessoas",
		51: "Eu gosto que as pessoas me convidem para participar em suas atividades",
		52: "Eu gosto que as pessoas ajam distantes para comigo",
		53: "Eu tento que as pessoas façam as coisas da maneira que eu gosto",
		54: "Eu assumo a liderança quando estou com outras pessoas",
	}

	// Iterate through all 54 questions
	totalQuestions := 54
	for q := 1; q <= totalQuestions; q++ {
		// Display the question text
		fmt.Printf("Pergunta %d: %s\n", q, questionTexts[q])

		// Display options based on question number
		if (q >= 1 && q <= 16) || (q >= 41 && q <= 54) {
			fmt.Println("1 - Nunca")
			fmt.Println("2 - Raramente")
			fmt.Println("3 - Ocasionalmente")
			fmt.Println("4 - Algumas vezes")
			fmt.Println("5 - Com frequência")
			fmt.Println("6 - Sempre")
		} else if q >= 17 && q <= 40 {
			fmt.Println("1 - Nenhuma")
			fmt.Println("2 - Uma ou duas")
			fmt.Println("3 - Poucas")
			fmt.Println("4 - Algumas")
			fmt.Println("5 - Muitas")
			fmt.Println("6 - A maioria")
		}

		// Get valid answer
		answer := getValidAnswer(q)
		answers[q] = answer
		fmt.Println()
	}

	// Calculate Variables Based on Specific Questions
	for _, group := range variableGroups {
		for q, validAnswers := range group.Questions {
			userAnswer, exists := answers[q]
			if !exists {
				// This should not happen, but added for safety
				continue
			}
			// Check if the user's answer is in the validAnswers slice
			matched := false
			for _, va := range validAnswers {
				if userAnswer == va {
					matched = true
					break
				}
			}
			if matched {
				// Increment the corresponding variable
				switch group.Name {
				case "wanted_inclusion":
					wanted_inclusion++
				case "expressed_inclusion":
					expressed_inclusion++
				case "wanted_control":
					wanted_control++
				case "expressed_control":
					expressed_control++
				case "wanted_affection":
					wanted_affection++
				case "expressed_affection":
					expressed_affection++
				}
			}
		}
	}

	// Display Results
	fmt.Println("\n--- Resultados ---")
	fmt.Printf("Nome Completo: %s\n", fullName)
	fmt.Printf("Inclusão Desejada: %d\n", wanted_inclusion)
	fmt.Printf("Inclusão Expressa: %d\n", expressed_inclusion)
	fmt.Printf("Controle Desejado: %d\n", wanted_control)
	fmt.Printf("Controle Expressa: %d\n", expressed_control)
	fmt.Printf("Afeto Desejado: %d\n", wanted_affection)
	fmt.Printf("Afeto Expressa: %d\n", expressed_affection)
}
