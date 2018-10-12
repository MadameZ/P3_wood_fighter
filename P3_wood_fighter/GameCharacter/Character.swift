import Foundation
class Character {
    enum GameCharacter{
        case Fighter, Mage, Colossus, Dwarf
    }
    var name: String = ""
    var characterNb: Int = 0
    var currentHealth: Int = 0
    var health: Int = 0
    var type: GameCharacter!
    var custom: String = ""
    var weapon: Weapon!
    //==================================
    //MARK:(Character)- Character's description
    //==================================
    func description() {
        print("\(self.custom) \(self.name) -> HP: \(self.currentHealth)")
    }
    //=====================================
    //MARK:(Character)- Attack the character Defense
    //=====================================
    func attack(characterDefense: Character) {
        print()
        print("🔱 \(self.name) a décidé d'attaquer \(characterDefense.name) 🔱")
        print()
        characterDefense.attackDamage(Damage: self.weapon.damage)
    }
    //==================================
    //MARK:(Character)- Assign damages
    //==================================
    func attackDamage(Damage: Int) {
        currentHealth -= Damage
        print(SEPARATOR_MIDDLE_SCALE_ROUND)
        if currentHealth <= 0 {
            currentHealth = 0
            print("                          \(self.name) est désormais out... ⛔️ ")
        } else {
            print("                             \(self.name) 💔 -> HP = \(currentHealth) ")
        }
    }

    //==================================
    //MARK:(Character)- Healing
    //==================================
    func heal(selfCharacter: Character) {
        print(SEPARATOR_MIDDLE_SCALE_ROUND)
        print("                         \(self.name) a décidé de soigner \(selfCharacter.name) ✨✨")
        print("                          Il retrouve 💚 HP = \(currentHealth)")
        print()
        selfCharacter.recoverHP(healing: self.weapon.healing)
        print(SEPARATOR_SCALE)
    }
    //==================================
    //MARK:(Character)- Recover Health Points
    //==================================
    func recoverHP(healing: Int) {
        if currentHealth == health {
            print("             Mais votre perso est en forme ! vous passez votre tour 😴")
            print()
        } else {
            currentHealth += healing
            if currentHealth >= health {
                currentHealth = health
                print("                          Il retrouve 💚 HP = \(currentHealth)")
                print()
            }
        }
    }
    //==================================
    //MARK:(Character)- Character's dead
    //==================================
    func isOut() -> Bool  {
        if currentHealth <= 0 {
            return true
        } else {
            return false
        }
    }
    //==================================
    //MARK:(Character)- Find the treasure
    //==================================
    func treasure() {
        let weaponTreasure: Weapon
        Message.treasure()
        switch self.type! {
        case .Fighter:
            weaponTreasure = Sword(damage: 100)
            print("              Il a une épée qui envoie une boulle de feu !! 🔥🔥🔥 ")
            print("                               Damages = \(weaponTreasure.damage)")
        case .Mage:
            weaponTreasure = Scepter(healing: 70)
            print("                  Son sceptre s'illumine ✨✨✨✨✨✨⭐️⭐️ ")
            print("                               Healing = \(weaponTreasure.healing)")
        case .Colossus:
            weaponTreasure = Mass(damage: 100)
            print("             Votre colosse a le pouvoir d'envoyer une tornade 💨🌪💨 ")
            print("                              Damages = \(weaponTreasure.damage)")
        case .Dwarf:
            weaponTreasure = Axe(damage: 100)
            print("                  Twiiiiit...Votre nain a un arc ! 🏹 ")
            print("                              Damages = \(weaponTreasure.damage)")
        }
        self.weapon = weaponTreasure
    }
}



