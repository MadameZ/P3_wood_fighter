import Foundation
class Fighter: Character {
    override init() {
        super.init()
        health = 100
        currentHealth = 100
        type = GameCharacter.Fighter
        custom = "⚔️"
        weapon = Sword(damage: SWORD_DAMAGE_TEST)
    }
}
