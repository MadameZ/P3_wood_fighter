import Foundation
var tournement = Game()

tournement.startNewGame()
while tournement.rePlay() {
    tournement.startNewGame()
}


