import Foundation
class Game {
    
    var players: [Player] = []
    var counter: Int = 0
    private var entryUser: String = ""
    
    //==================================
    //MARK: - The flow of the game
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
    //MARK: - Assign players
    //==================================
    private func initializePlayer() {
        for numberOfPlayer in NB_MIN_OF_PLAYER...NB_MAX_OF_PLAYERS {
            players.append(Player(playerKey: numberOfPlayer))
        }
    }
    //==================================
    //MARK: - Assign team's names
    //==================================
    private func assignNameTeam() {
        var enterName : String = ""
        players.forEach { player in
            repeat {
                print("Joueur \(player.playerKey). Donnez un nom à votre équipe : ", terminator:"")
                if let nameTeamTemp = readLine() {
                    enterName = nameTeamTemp
                }
                print("Le nom : \(enterName) vous convient-il ? 1.Yes or 2.No : ", terminator:"")
                entryUser = readLine()!
                switch entryUser {
                case "1":
                    print("Super.")
                case "2":
                    print("On reprend... ")
                default:
                    print("Saisie incorrecte. Donnez un nom à votre équipe : ", terminator:"")
                }
            } while entryUser != "1"
            player.name = enterName
            print(SEPARATOR_SCALE)
            print()
        }
    }
    //==================================
    //MARK: - Build a team
    //==================================
    private func assignTeam() {
        players.forEach { player in
            print("Joueur \(player.playerKey) : \(player.name)! Constituez votre équipe.")
            player.teamBuilding(playerList: players)
            print(SEPARATOR_SCALE)
            print()
        }
        players.forEach { player in
            player.displayTeam()
            print()
        }
        print(SEPARATOR_SCALE)
        print()
    }
    //==================================
    //MARK: - Make the action
    //==================================
    private func fight()  {
        print("LET'S START TO FIGHT")
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
            print()
            print("⚡️Joueur \(playerAttack.playerKey) de l'équipe \(playerAttack.name) à l'attaque⚡️ ")
            playerAttack.action(playerOpposite: playerOpposite, counter: counter)
            if gameOver() {
                print()
                print("🎈Joueur \(playerAttack.playerKey) de l'équipe \(playerAttack.name) a gagné en \(counter) tours !!!!!! 🎈🎈")
                print()
                print(SEPARATOR_SCALE)
            }
        }
    }
    
    
    //==================================
    //MARK: - Game is over
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
    //MARK: - Replay
    //==================================
    func rePlay() -> Bool {
        var startAgain: Bool = true
        var response : String = ""
        while response != "ok" {
            print()
            print("Voulez-vous rejouer? 1.Yes or 2.No : ", terminator:"")
            entryUser = readLine()!
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
