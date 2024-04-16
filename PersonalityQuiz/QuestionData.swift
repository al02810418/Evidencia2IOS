import Foundation

struct Pregunta {
    var texto: String
    var tipo: TipoRespuesta
    var respuestas: [Respuesta]
}

enum TipoRespuesta {
    case única, múltiple, rango
}

struct Respuesta {
    var texto: String
    var tipo: TipoAnimal
}

enum TipoAnimal: Character {
    case perro = "🐶", gato = "🐱", conejo = "🐰", tortuga = "🐢"
    
    var descripción: String {
        switch self {
        case .perro:
            return "Eres increíblemente extrovertido. Te rodeas de las personas que amas y disfrutas de actividades con tus amigos."
        case .gato:
            return "Travieso, pero de temperamento suave, te gusta hacer las cosas a tu manera."
        case .conejo:
            return "Amas todo lo suave. Eres saludable y lleno de energía."
        case .tortuga:
            return "Eres sabio más allá de tus años, y te enfocas en los detalles. Despacio pero seguro gana la carrera."
        }
    }
}
