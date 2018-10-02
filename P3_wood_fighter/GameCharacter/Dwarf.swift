import Foundation
class Dwarf: Character {
    override init() {
        super.init()
        health = 100
        currentHealth = 100
        type = GameCharacter.Colossus
        custom = "🎭"
        weapon = Axe(damage: 50)
    }
}
