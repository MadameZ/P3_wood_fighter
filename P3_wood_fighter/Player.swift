import Foundation
class Player {
    
    var playerKey: Int = 0
    var name: String = ""
    var characters: [Character] = []
    
    init(playerKey: Int) {
        self.playerKey = playerKey
    }
    //==================================
    //MARK: - Make a team
    //==================================
    func teamBuilding(playerList: [Player]) {
        for numberOfCharacter in 1...3 {
            pickCharacter(characterNumber: numberOfCharacter, AllPlayers: playerList)
        }
    }
    //======================================================
    //MARK: - Choose characters and give them a special name
    //======================================================
    func pickCharacter(characterNumber: Int, AllPlayers: [Player]) {
        var newCharacter: Character?
        var checkName: String = ""
        var entryType: Bool
        var duplicate: Bool
        print("👉🏽 Choisissez le \(characterNumber)e personnage : ", terminator:"")
        repeat {
            print(" 1. \(Fighter.init().custom)Fighter  2. \(Mage.init().custom)Mage  3. \(Colossus.init().custom)Colosse  4. \(Dwarf.init().custom)Nain")
            entryType = true
            if let typeChoice = readLine() {
                switch typeChoice {
                case "1":
                    newCharacter = Fighter()
                    print("Un Fighter rentre dans l'équipe \(name) du joueur \(playerKey).")
                case "2":
                    newCharacter = Mage()
                    print("Un Mage rentre dans l'équipe \(name) du joueur \(playerKey).")
                case "3":
                    newCharacter = Colossus()
                    print("Un Colosse rentre dans l'équipe \(name) du joueur \(playerKey).")
                case "4":
                    newCharacter = Dwarf()
                    print("Un Nain rentre dans l'équipe \(name) du joueur \(playerKey).")
                default:
                    entryType = false
                    print("Saisie incorrecte. Faites votre choix.")
                }
            }
        } while !entryType
        
        repeat {
            duplicate = false
            print("Donnez-lui un nom : ", terminator:"")
            if let nameTemp = readLine() {
                if checkIfSameName(whichPlayer: AllPlayers, name: nameTemp) {
                    print("Le nom est déjà pris...🤔")
                    duplicate = true
                }
                checkName = nameTemp
            }
        } while duplicate
        print()
        newCharacter!.name = checkName
        characters.append(newCharacter!)
        
    }
    //==================================
    //MARK: - Display Team
    //==================================
    func checkIfSameName(whichPlayer: [Player], name: String) -> Bool {
        var sameName: Bool = false
        whichPlayer.forEach { player in
            player.characters.forEach { character in
                if name == character.name {
                    sameName = true
                }
            }
        }
        return sameName
    }
    //==================================
    //MARK: - Display Team
    //==================================
    func displayTeam() {
        print("Joueur \(self.playerKey), EQUIPE \(name):")
        characters.forEach { character in
            character.description()
        }
    }
    //=======================================
    //MARK: - Select a character to play whith
    //=======================================
    func selectCharacterToPlay(player: Player) -> Character {
        var characterChoice: Character?
        var entryCharacterChoice: Bool?
        repeat{
            entryCharacterChoice = true
            let data = readLine()!
            if let characterChoiceNumber = Int(data), characterChoiceNumber >= 1 && characterChoiceNumber <= player.characters.count {
                characterChoice = player.characters[characterChoiceNumber - 1]
                if characterChoice!.isOut() {
                    print("Votre personnage est Hors de combat !")
                    entryCharacterChoice = false
                } else {
                    entryCharacterChoice = true
                }
            } else {
                print("Veuillez faire votre choix.")
                entryCharacterChoice = false
            }
        } while !entryCharacterChoice!
        return characterChoice!
    }
    
    //==================================
    //MARK: - which action ?
    //==================================
    func action(playerOpposite: Player, counter: Int) {
        print()
        print("**** ROUND \(counter) ****")
        print()
        print("Joueur \(self.playerKey) vous êtes PRÊT À ATTAQUER")
        print("Choisissez votre personnage. Tapez un chiffre entre 1 et 3.")
        displayTeam()
        let characterAttack = selectCharacterToPlay(player: self)
        if characterAttack.type == .Mage {
            let characterIsMage = characterAttack
            print("Quel perso voulez-vous soigner ? Tapez un chiffre entre 1 et 3.")
            let characterInTeamMage = selectCharacterToPlay(player: self)
            if characterInTeamMage.type == .Mage {
                print("Le Mage ne peut peut pas soigner lui-même. Vous passez votre tour 😴")
            } else {
                characterIsMage.heal(character: characterInTeamMage)
            }
            
        } else {
            print("\(characterAttack.name) a été sélectionné pour le combat")
            print()
            let randomNumber = arc4random_uniform(50)
            if counter > COUNTER_TREASURE && (randomNumber % 2) != 0 {
                characterAttack.treasure()
            }
            print("Vous jouez contre :")
            playerOpposite.displayTeam()
            print("Choisissez un personnage à attaquer. Tapez un chiffre entre 1 et 3.")
            let characterDefense = selectCharacterToPlay(player: playerOpposite)
            characterAttack.attack(characterDefense: characterDefense)
            print("joueur \(playerOpposite.playerKey), EQUIPE \(playerOpposite.name) perd ce tour")
            print()
            print(SEPARATOR_SCALE)
        }
    }
    //==================================
    //MARK: - is a player win ?
    //==================================
    func teamIsAlive() -> Bool {
        var deadCounter: Int = 0
        characters.forEach { character in
            if character.isOut() {
                deadCounter += 1
            }
        }
        if deadCounter == 3  {
            return false
        } else {
            return true
        }
    }
    
}

