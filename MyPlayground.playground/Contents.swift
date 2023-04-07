import UIKit

protocol Bird: CustomStringConvertible {
    var name: String { get }
    var canFly: Bool { get }
}

protocol Flyable {
    var maximumSpeed: Double { get }
}


struct Parrot: Bird, Flyable {
    var name: String
    var amplitude: Double
    var frequency: Double
    var canFly: Bool = true
    
    var maximumSpeed: Double {
        3 * amplitude * frequency
    }
}

let parrot = Parrot(name: "Papagaio", amplitude: 6.8, frequency: 3)
print("\(parrot.name) voa a \(parrot.maximumSpeed) km/h ")


struct Penguim: Bird {
    var name: String
    var canFly: Bool = false
}

let penguim = Penguim(name: "Penguim BR")
print("\(penguim.name) é um passado que não voa? \(penguim.canFly ? "Sim" : "Não") ")






// MARK: - extesão de protocolo - Comportamento padrão
extension Bird {
    var canFly: Bool { self is Flyable }
}

struct Dove: Bird, Flyable {
    var name: String
    var amplitude: Double
    var frequency: Double
    
    var maximumSpeed: Double {
        3 * amplitude * frequency
    }
}

let dove = Dove(name: "Bompo", amplitude: 3.5, frequency: 4)
print("O \(dove.name) voa? \(dove.canFly ? "Sim, ele voa a \(dove.maximumSpeed) KM/h" : "Não")")

struct Ortrich: Bird {
    var name: String
}
let ortrich = Ortrich(name: "Avestruz")
print("O \(ortrich.name) voa? \(ortrich.canFly ? "Sim" : "Não")")







// MARK: - protocolo em enum
enum Swallow: Bird, Flyable {
    case african
    case european
    case american
    case unknown
    
    var name: String {
        switch self {
        case .african:
            return "Andorinha africana"
        case .european:
            return "Andorinha europeia"
        case .american:
            return "Andorinha Americana"
        case .unknown:
            return "Andorinha"
        }
    }
    
    var maximumSpeed: Double {
        switch self {
        case .african:
            return 11
        case .european:
            return 10
        case .american:
            return 12
        case .unknown:
           fatalError("Não sabemos a velocidade que a andorinha voa!s")
        }
    }
}







// MARK: - Extensão de enum - Comportamento padrão
extension Swallow {
    var canFly: Bool { self != .unknown }
}

Swallow.african.canFly
Swallow.unknown.canFly
Penguim(name: "Name").canFly
Dove(name: "Dove", amplitude: 2, frequency: 3).canFly








// MARK: - Criando extensões condicionais usando a implementação padrão CustomStringConvertible
extension CustomStringConvertible where Self: Bird {
    var description: String {
        canFly ? "Pode voar" : "Não pode voar"
    }
}

print(Swallow.african)
print(Swallow.unknown)








// MARK: - Modelagem retroativa
class Motocycle {
    var name: String
    var speed: Double
    
    init(name: String) {
        self.name = name
        self.speed = 200
    }
}

protocol Racer {
    var speed: Double { get }
}

extension Parrot: Racer {
    var speed: Double {
        maximumSpeed
    }
}
extension Penguim: Racer {
    var speed: Double {
        35
    }
}
extension Swallow: Racer {
    var speed: Double {
        canFly ? maximumSpeed : 0.00
    }
}
extension Motocycle: Racer {
    // nada aqui porque ele ja implementa esta propriedade
}

let racers: [Racer] = [
    Swallow.african,
    Swallow.american,
    Swallow.european,
    Swallow.unknown,
    Penguim(name: "Penguim"),
    Parrot(name: "Papagaio", amplitude: 2.5, frequency: 3.6),
    Motocycle(name: "Chablau")
]

func toSpeed(of racers: [Racer]) -> Double {
    racers.max(by: {$0.speed < $1.speed})?.speed ?? 0.00
}

print("Velocidade dos nossos corredores \(toSpeed(of: racers))")







//MARK: - Usando extensão para não ter que usar a função diretamente.
extension Sequence where Iterator.Element == Racer {
    func topSpeed() -> Double {
        self.max(by: {$0.speed < $1.speed})?.speed ?? 0.00
    }
}

print("Velocidade maxima entre os nossos corredores \(racers.topSpeed())")
print("Velocidade maxima entre os 3 primeiros corredores \(racers[1...3].topSpeed())")








//MARK: - Usando funções mutantes (Que altera caracteristicas existentes)
protocol Cheat {
    mutating func boost(_ power: Double)
}

struct SwiftBird: Bird, Flyable {
    var name: String { "Swift Bird \(version)" }
    let version: Double
    private var speedFactor: Double = 1000.00
    
    var maximumSpeed: Double {
        version * speedFactor
    }
    
    init(version: Double) {
        self.version = version
    }
}

extension SwiftBird: Cheat {
    mutating func boost(_ power: Double) {
        speedFactor += power
    }
}

var swiftBird = SwiftBird(version: 5)
print("A velocidade é de \(swiftBird.maximumSpeed)")

swiftBird.boost(5)
print("A velocidade é de \(swiftBird.maximumSpeed)")

swiftBird.boost(5)
print("A velocidade é de \(swiftBird.maximumSpeed)")

swiftBird.boost(-5)
print("A velocidade é de \(swiftBird.maximumSpeed)")

