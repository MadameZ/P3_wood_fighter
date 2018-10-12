import Foundation
class Player {
    
    let playerKey: Int
    var name: String = ""
    var characters: [Character] = []
    
    init(playerKey: Int) {
        self.playerKey = playerKey
    }
    //==================================
    //MARK:(player) - Make a team
    //==================================
    func teamBuilding(playerList: [Player]) {
        for numberOfCharacter in 1...3 {
            pickCharacter(characterNumber: numberOfCharacter, AllPlayers: playerList)
        }
    }
    //======================================================
    //MARK:(player) - Choose characters and give them a special name
    //======================================================
    func pickCharacter(characterNumber: Int, AllPlayers: [Player]) {
        var newCharacter: Character!
        var checkName: String = ""
        var entryType: Bool
        var duplicate: Bool
        print()
        print("                     ➡️ Joueur \(self.playerKey) Équipe \(self.name), \(characterNumber)e personnage ⬅️")
        print(SEPARATOR_MIDDLE_SCALE)
        print()
        print("\(LEAD) Choisissez le \(characterNumber)e personnage : ", terminator:"")
        repeat {
            print(" 1. \(Fighter.init().custom)Fighter  2. \(Mage.init().custom)Mage  3. \(Colossus.init().custom)Colosse  4. \(Dwarf.init().custom)Nain -> ", terminator:"")
            entryType = true
            guard let typeChoice = readLine() else {
                print("Vous devez faire votre choix")
                return
            }
                switch typeChoice {
                case "1":
                    newCharacter = Fighter()
                    print("\(Fighter.init().custom) Un Fighter rentre dans l'équipe \(name) du joueur \(playerKey).")
                case "2":
                    newCharacter = Mage()
                    print("\(Mage.init().custom) Un Mage rentre dans l'équipe \(name) du joueur \(playerKey).")
                case "3":
                    newCharacter = Colossus()
                    print("\(Colossus.init().custom) Un Colosse rentre dans l'équipe \(name) du joueur \(playerKey).")
                case "4":
                    newCharacter = Dwarf()
                    print("\(Dwarf.init().custom) Un Nain rentre dans l'équipe \(name) du joueur \(playerKey).")
                default:
                    entryType = false
                    print("Saisie incorrecte. Faites votre choix.")
                }
        } while !entryType
    
        repeat {
            duplicate = false
            print("\(LEAD) Donnez-lui un nom : ", terminator:"")
            guard let nameTemp = readLine() else {
                print("Le nom doit avoir une valeur")
                return 
            }
                if checkIfSameName(whichPlayer: AllPlayers, name: nameTemp) {
                    print("Le nom est déjà pris...🤔")
                    duplicate = true
            }
            checkName = nameTemp
            
        } while duplicate
        newCharacter.name = checkName
        characters.append(newCharacter)  
    }
    //==================================
    //MARK:(player) - Check the name
    //==================================
    func checkIfSameName(whichPlayer: [Player], name: String) -> Bool {
        var sameName: Bool = false
        whichPlayer.forEach { player in
            player.characters.forEach { character in
                if name.lowercased() == character.name.lowercased() {
                    sameName = true
                }
            }
        }
        return sameName
    }
    //==================================
    //MARK:(player) - Display Team
    //==================================
    func displayTeam() {
        var characterCounter: Int = 0
        print("   Joueur \(self.playerKey), EQUIPE \(name):")
        characters.forEach { character in
            characterCounter += 1
            if character.isOut() {
                print("⛔️ ",terminator: "")
            } else {
                print("\(characterCounter). ",terminator: "")
            }
            character.description()
        }
    }
    //=======================================
    //MARK:(player)- Select a character to play whith
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
                    print("⛔️ Votre personnage est Hors de combat !")
                    print("\(LEAD) Choisissez un autre personnage.")
                    entryCharacterChoice = false
                } else {
                    entryCharacterChoice = true
                }
            } else {
                print("🛑 Veuillez faire votre choix.") 
                entryCharacterChoice = false
            }
        } while !entryCharacterChoice!
        return characterChoice!
    }
    
    //==================================
    //MARK:(player) - which action ?
    //==================================
    func action(playerOpposite: Player, counter: Int) {
        print()
        print("🔷 Joueur \(self.playerKey) VOUS ÊTES PRÊT À ATTAQUER 🔷")
        displayTeam()
        print("\(LEAD) Choisissez votre personnage. Tapez un chiffre entre 1 et 3 : ", terminator:"")
        let characterAttack = selectCharacterToPlay(player: self)
        if characterAttack.type == .Mage {
            let characterIsMage = characterAttack
            print("\(LEAD) Quel perso voulez-vous soigner ? Tapez un chiffre entre 1 et 3 : ", terminator:"")
            print()
            let characterInTeamMage = selectCharacterToPlay(player: self)
            if characterInTeamMage.type == .Mage {
                print(SEPARATOR_MIDDLE_SCALE_ROUND)
                print()
                print("    Le Mage ne peut peut pas soigner lui-même. Vous passez votre tour 😴")
                print()
                print(SEPARATOR_SCALE)
            } else {
                characterIsMage.heal(selfCharacter: characterInTeamMage)
            }
            
        } else {
            print("\(characterAttack.name) a été sélectionné pour le combat !")
            print()
            let randomNumber = arc4random_uniform(50)
            if counter > COUNTER_TREASURE && (randomNumber % 2) != 0 {
                characterAttack.treasure()
            }
            print()
            print(SEPARATOR_MIDDLE_SCALE_ROUND)
            print()
            print("🔶 VOUS JOUEZ CONTRE 🔶")
            playerOpposite.displayTeam()
            print("\(LEAD) Choisissez un personnage à attaquer. Tapez un chiffre entre 1 et 3 : ", terminator:"")
            let characterDefense = selectCharacterToPlay(player: playerOpposite)
            characterAttack.attack(characterDefense: characterDefense)
            print("                   Joueur \(playerOpposite.playerKey), équipe \(playerOpposite.name) perd le ROUND \(counter)")
            print()
            print(SEPARATOR_SCALE)
        }
    }
    //==================================
    //MARK:(player) - is a player win ?
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

