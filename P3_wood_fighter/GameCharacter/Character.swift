import Foundation
class Character {
    
    enum GameCharacter{
        case Fighter, Mage, Colossus, Dwarf
    }
    var name: String = ""
    var characterNb: Int = 0
    var currentHealth: Int = 0
    var health: Int = 0
    var type: GameCharacter?
    var custom: String = ""
    var weapon: Weapon?
    //==================================
    //MARK: - Character's description
    //==================================
    func description() {
        print("\(self.custom) \(self.name) 👉🏽 HP: \(self.currentHealth)")
    }
    //=====================================
    //MARK: - Attack the character Defense
    //=====================================
    func attack(characterDefense: Character) {
        print("\(self.name) a décidé d'attaquer \(characterDefense.name)")
        print()
        characterDefense.attackDamage(Damage: self.weapon!.damage)
    }
    //==================================
    //MARK: - Assign damages
    //==================================
    func attackDamage(Damage: Int) {
        currentHealth -= Damage
        
        if currentHealth <= 0 {
            currentHealth = 0
            print("\(self.name) 💔 HP = \(currentHealth) ")
        } else {
            print("\(self.name) 💔 HP = \(currentHealth) ")
        }
    }
    //==================================
    //MARK: - Recover Health Points
    //==================================
    func recoverHP(healing: Int) {
        if currentHealth == health {
            print("Votre perso est en forme ! vous passez votre tour 😴")
            print()
        } else {
            currentHealth += healing
            print("Votre personnage retrouve 💚 HP = \(currentHealth)")
            if currentHealth >= health {
                currentHealth = health
            }
        }
    }
    //==================================
    //MARK: - Healing
    //==================================
    func heal(character: Character) {
        print("\(self.name) a décidé de soigner \(character.name) ✨")
        character.recoverHP(healing: self.weapon!.healing)
        print(SEPARATOR_SCALE)
    }
    
    //==================================
    //MARK: - Character's dead
    //==================================
    func isOut() -> Bool  {
        if currentHealth <= 0 {
            return true
        } else {
            return false
        }
    }
    //==================================
    //MARK: - Character's alive
    //==================================
    func isAlive() -> Bool  {
        if currentHealth > 0 {
            return true
        } else {
            return false
        }
    }
    //==================================
    //MARK: - FInd the treasure
    //==================================
    func treasure() {
        let weaponTreasure: Weapon
        switch self.type! {
        case .Fighter:
            weaponTreasure = Sword(damage: 100)
            print("          Il a une épée qui envoie une boulle de feu !! 🔥🔥🔥")
            print("                        Damages = \(weaponTreasure.damage)")
            print()
        case .Colossus:
            weaponTreasure = Mass(damage: 100)
            print("       Votre colosse a le pouvoir d'envoyer une tornade 💨🌪💨")
            print("                        Damages = \(weaponTreasure.damage)")
            print()
        case .Dwarf:
            weaponTreasure = Axe(damage: 100)
            print("               Twiiiiit...Votre nain a un arc ! 🏹")
            print("                        Damages = \(weaponTreasure.damage)")
            print()
        case .Mage:
            weaponTreasure = Scepter(healing: 70)
            print("          Son sceptre s'illumine ✨✨✨✨✨✨⭐️⭐️")
            print("                        Healing = \(weaponTreasure.healing)")
            print()
        }
        print()
        self.weapon = weaponTreasure
    }
}



