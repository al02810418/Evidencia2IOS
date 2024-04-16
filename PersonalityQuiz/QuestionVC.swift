import UIKit

class VistaPreguntas: UIViewController {
    
    @IBOutlet weak var etiquetaPregunta: UILabel!
    
    @IBOutlet weak var vistaSimple: UIStackView!
    @IBOutlet weak var botonOpcion1: UIButton!
    @IBOutlet weak var botonOpcion2: UIButton!
    @IBOutlet weak var botonOpcion3: UIButton!
    @IBOutlet weak var botonOpcion4: UIButton!
    
    @IBOutlet weak var vistaMultiple: UIStackView!
    @IBOutlet weak var etiquetaOpcion1: UILabel!
    @IBOutlet weak var etiquetaOpcion2: UILabel!
    @IBOutlet weak var etiquetaOpcion3: UILabel!
    @IBOutlet weak var etiquetaOpcion4: UILabel!
    
    @IBOutlet weak var interruptorOpcion1: UISwitch!
    @IBOutlet weak var interruptorOpcion2: UISwitch!
    @IBOutlet weak var interruptorOpcion3: UISwitch!
    @IBOutlet weak var interruptorOpcion4: UISwitch!
    
    @IBOutlet weak var vistaRango: UIStackView!
    @IBOutlet weak var etiquetaRango1: UILabel!
    @IBOutlet weak var etiquetaRango2: UILabel!
    
    @IBOutlet weak var deslizadorRango: UISlider!
    
    @IBOutlet weak var barraProgreso: UIProgressView!
    
    // Propiedades
    var indicePregunta = 0
    var respuestasSeleccionadas: [Respuesta] = []
    
    var preguntas: [Pregunta] = [
        Pregunta(texto: "¿Cuál es tu comida favorita?",
                 tipo: .única,
                 respuestas: [
                    Respuesta(texto: "Bistec", tipo: .perro),
                    Respuesta(texto: "Pescado", tipo: .gato),
                    Respuesta(texto: "Zanahorias", tipo: .conejo),
                    Respuesta(texto: "Maíz", tipo: .tortuga)
                    ]),
        Pregunta(texto: "¿Qué actividades disfrutas?",
                 tipo: .múltiple,
                 respuestas: [
                    Respuesta(texto: "Nadar", tipo: .tortuga),
                    Respuesta(texto: "Dormir", tipo: .gato),
                    Respuesta(texto: "Acurrucarse", tipo: .conejo),
                    Respuesta(texto: "Comer", tipo: .perro)
                    ]),
        Pregunta(texto: "¿Cuánto disfrutas de los paseos en auto?",
                 tipo: .rango,
                 respuestas: [
                    Respuesta(texto: "No me gustan", tipo: .gato),
                    Respuesta(texto: "Me pongo un poco nervioso", tipo: .conejo),
                    Respuesta(texto: "Apenas los noto", tipo: .tortuga),
                    Respuesta(texto: "Los amo", tipo: .perro)
                    ]),
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        actualizarInterfaz()
    }
    
    func actualizarInterfaz() {
        vistaSimple.isHidden = true
        vistaMultiple.isHidden = true
        vistaRango.isHidden = true
        
        let preguntaActual = preguntas[indicePregunta]
        let respuestasActuales = preguntaActual.respuestas
        let progresoTotal = Float(indicePregunta) / Float(preguntas.count)
        
        navigationItem.title = "Pregunta #\(indicePregunta + 1)"
        etiquetaPregunta.text = preguntaActual.texto
        barraProgreso.setProgress(progresoTotal, animated: true)
        
        switch preguntaActual.tipo {
        case .única:
            mostrarVistaSimple(con: respuestasActuales)
        case .múltiple:
            mostrarVistaMultiple(con: respuestasActuales)
        case .rango:
            mostrarVistaRango(con: respuestasActuales)
        }
    }
    
    func mostrarVistaSimple(con respuestas: [Respuesta]) {
        vistaSimple.isHidden = false
        botonOpcion1.setTitle(respuestas[0].texto, for: .normal)
        botonOpcion2.setTitle(respuestas[1].texto, for: .normal)
        botonOpcion3.setTitle(respuestas[2].texto, for: .normal)
        botonOpcion4.setTitle(respuestas[3].texto, for: .normal)
    }
    
    func mostrarVistaMultiple(con respuestas: [Respuesta]) {
        vistaMultiple.isHidden = false
        interruptorOpcion1.isOn = false
        interruptorOpcion2.isOn = false
        interruptorOpcion3.isOn = false
        interruptorOpcion4.isOn = false
        etiquetaOpcion1.text = respuestas[0].texto
        etiquetaOpcion2.text = respuestas[1].texto
        etiquetaOpcion3.text = respuestas[2].texto
        etiquetaOpcion4.text = respuestas[3].texto
    }
    
    func mostrarVistaRango(con respuestas: [Respuesta]) {
        vistaRango.isHidden = false
        deslizadorRango.setValue(0.5, animated: false)
        etiquetaRango1.text = respuestas.first?.texto
        etiquetaRango2.text = respuestas.last?.texto
    }
    
    @IBAction func botonRespuestaSimplePresionado(_ sender: UIButton) {
        let respuestasActuales = preguntas[indicePregunta].respuestas
        
        switch sender {
        case botonOpcion1:
            respuestasSeleccionadas.append(respuestasActuales[0])
        case botonOpcion2:
            respuestasSeleccionadas.append(respuestasActuales[1])
        case botonOpcion3:
            respuestasSeleccionadas.append(respuestasActuales[2])
        case botonOpcion4:
            respuestasSeleccionadas.append(respuestasActuales[3])
        default:
            break
        }
        siguientePregunta()
    }
    
    @IBAction func botonRespuestaMultiplePresionado() {
        let respuestasActuales = preguntas[indicePregunta].respuestas
        
        if interruptorOpcion1.isOn {
            respuestasSeleccionadas.append(respuestasActuales[0])
        }
        if interruptorOpcion2.isOn {
            respuestasSeleccionadas.append(respuestasActuales[1])
        }
        if interruptorOpcion3.isOn {
            respuestasSeleccionadas.append(respuestasActuales[2])
        }
        if interruptorOpcion4.isOn {
            respuestasSeleccionadas.append(respuestasActuales[3])
        }
        siguientePregunta()
    }
    
    @IBAction func botonRespuestaRangoPresionado() {
        let respuestasActuales = preguntas[indicePregunta].respuestas
        let indice = Int(round(deslizadorRango.value * Float(respuestasActuales.count - 1)))
        respuestasSeleccionadas.append(respuestasActuales[indice])
        siguientePregunta()
    }
    
    func siguientePregunta() {
        indicePregunta += 1
        
        if indicePregunta < preguntas.count {
            actualizarInterfaz()
        } else {
           
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ResultadosSegue" {
            let controladorResultados = segue.destination as! VistaResultados
            controladorResultados.respuestasRecibidas = respuestasSeleccionadas
        }
    }
}
