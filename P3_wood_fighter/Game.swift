import Foundation
class Game {
    
    var players: [Player] = []
    var counter: Int = 0
    
    //==================================
    //MARK:(Game) - The flow of the game
    //==================================
    func startNewGame() {
        counter = 0
        Message.welcome()
        initializePlayer()
        assignNameTeam()
        assignTeam()
        fight()
    }
    //==================================
    //MARK:(Game) - Assign players
    //==================================
    private func initializePlayer() {
        for numberOfPlayer in NB_MIN_OF_PLAYER...NB_MAX_OF_PLAYERS {
            players.append(Player(playerKey: numberOfPlayer))
        }
    }
    //==================================
    //MARK:(Game) - Assign team's names
    //==================================
    private func assignNameTeam() {
        var enterName: String = ""
        var namesOk: Bool = true
        var entryUser: String = ""
        players.forEach { player in
            repeat {
                namesOk = true
                print("\(LEAD) Joueur \(player.playerKey). Donnez un nom à votre équipe : ", terminator:"")
                // Here is a check for valid value
                guard let nameTeamTemp = readLine() else {
                    print("Le nom doit avoir une valeur")
                    return // if it false the else statement excecutes will exit the method
                }
                enterName = nameTeamTemp
                if players.first?.name.lowercased() == enterName.lowercased() {
                    print("⛔️ Le nom des deux équipes est le même. Veuillez recommencer.")
                    print()
                    namesOk = false
                } else {
                    print("\(LEAD) Le nom \(enterName), vous convient-il ? ✅ Si oui, tapez sur \"Entrée\" ; sinon 🛑 tapez \"2\" : ", terminator:"")
                    entryUser = readLine()!
                    entryUser = entryUser.isEmpty ? "1" : entryUser
                        switch entryUser {
                        case "1":
                            print("✅ Super.")
                        case "2":
                            print("🛑 On reprend... ")
                        default:
                            print("Saisie incorrecte. Donnez un nom à votre équipe : ", terminator:"")
                        }
                }
                
            } while !namesOk || entryUser != "1"
            player.name = enterName
            print(SEPARATOR_SCALE)
            print()
        }
    }
    //==================================
    //MARK:(Game) - Build a team
    //==================================
    private func assignTeam() {
        players.forEach { player in
            Message.teamBuildingTitle()
            player.teamBuilding(playerList: players)
            print(SEPARATOR_SCALE)
            print()
        }
        Message.teamDescription()
        players.forEach { player in
            player.displayTeam()
            print()
        }
        print(SEPARATOR_SCALE)
        print()
    }
    //==================================
    //MARK:(Game) - Make the action
    //==================================
    private func fight()  {
        Message.startToFight()
        print()
        while !gameOver() {
            counter += 1
            var playerAttack = players[IND_PLAYER_1]
            var playerOpposite = players[IND_PLAYER_2]
            let firstAttack = Int(arc4random_uniform(23))
            if counter == 1 && (firstAttack % 2) == 0 {
                swap(&playerAttack, &playerOpposite)
            } else {
                players.reverse()
            }
            print("                                  ROUND \(counter)")
            print(SEPARATOR_MIDDLE_SCALE_ROUND)
            print("                 🔱 Joueur \(playerAttack.playerKey) de l'équipe \(playerAttack.name) à l'attaque 🔱 ")
            playerAttack.action(playerOpposite: playerOpposite, counter: counter)
            print("\(LEAD) Appuyer sur \"entrer\" pour continuer.")
            print(SEPARATOR_SCALE)
            var _ = readLine()
            if gameOver() {
                Message.congratulations()
                print("          🎈Joueur \(playerAttack.playerKey) de l'équipe \(playerAttack.name) a gagné en \(counter) tours !!!!!! 🎈🎈")
                print()
                print(SEPARATOR_SCALE)
            }
        }
    }
    
    
    //==================================
    //MARK:(Game) - Game is over
    //==================================
    private func gameOver() -> Bool {
        var AliveTeams: Int = 0
        players.forEach { player in
            if player.teamIsAlive() {
                AliveTeams += 1
            }
        }
        if AliveTeams == 1 {
            return true
        } else {
            return false
        }
    }
    //==================================
    //MARK:(Game) - Play again or no
    //==================================
    func rePlay() -> Bool {
        var startAgain: Bool = true
        var response : String = ""
        var entryUser: String = ""
        while response != "ok" {
            print()
            print("\(LEAD) Voulez-vous rejouer?  ✅ Si oui, tapez sur \"Entrée\" ; sinon 🛑 tapez \"2\" : ", terminator:"")
            entryUser = readLine()!
            entryUser = entryUser.isEmpty ? "1" : entryUser
            if let responseSecure = Int(entryUser) {
                switch responseSecure {
                case 1:
                    print("OK")
                    print()
                    print(SEPARATOR_SCALE)
                    players.removeAll()
                    startAgain = true
                    response = "ok"
                case 2:
                    Message.goodBye()
                    startAgain = false
                    response = "ok"
                default:
                    print("Choix incorrect")
                    response = "none"
                }
            }
        }
        return startAgain
    }
    
    
    
}
