import Foundation
class Sword: Weapon {
    init(damage: Int) {
        super.init()
        name = "Sword"
        self.damage = damage
    }
}
