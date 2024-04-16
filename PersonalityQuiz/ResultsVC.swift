import UIKit

class VistaResultados: UIViewController {
    @IBOutlet weak var etiquetaResultado: UILabel!
    @IBOutlet weak var descripcionResultado: UILabel!
    
    var respuestasRecibidas: [Respuesta]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calcularResultadosPersonalidad()
        navigationItem.hidesBackButton = true
    }
    
    func calcularResultadosPersonalidad() {
        var frecuenciaRespuestas: [TipoAnimal: Int] = [:]
        
        let tiposRespuestas = respuestasRecibidas.map { $0.tipo }
        
        for tipo in tiposRespuestas {
            frecuenciaRespuestas[tipo] = (frecuenciaRespuestas[tipo] ?? 0) + 1
        }
        
        let respuestasOrdenadasPorFrecuencia = frecuenciaRespuestas.sorted { $0.value > $1.value }
        
        let respuestaMasComún = respuestasOrdenadasPorFrecuencia.first!.key
        
        etiquetaResultado.text = "Eres un \(respuestaMasComún.rawValue)"
        descripcionResultado.text = respuestaMasComún.descripción
    }
}
