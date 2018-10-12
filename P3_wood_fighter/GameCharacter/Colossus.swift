import Foundation
class Colossus: Character {
    override init() {
        super.init()
        health = 100
        currentHealth = 100
        type = GameCharacter.Colossus
        custom = "🗿"
        weapon = Mass(damage: COLOSSUS_DAMAGE_TEST)
    }
}
