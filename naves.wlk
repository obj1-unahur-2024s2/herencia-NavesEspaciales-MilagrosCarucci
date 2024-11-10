class Naves {
    var velocidad = 0 //0.min(100000)
    var direccion = -10 //-10.min(10)
    var combustible

    method acelerar(cuanto) {
        //velocidad += cuanto
        direccion = 100000.min(velocidad + cuanto)
    }
    method desacelerar(cuanto) {
        //velocidad -= cuanto
        direccion = 0.max(velocidad - cuanto)
    }
    method irHaciaElSol() {
        direccion = 10
    }
    method escaparDelSol() {
        direccion = -10
    }
    method ponerseParaleloAlSol() {
        direccion = 0
    }
    method acercarseUnPocoAlSol() {
        direccion = 10.min(direccion + 1)
    }
    method alejarseUnPocoAlSol() {
        direccion = (-10).max(direccion - 1)
    }
    method prepararViaje() {
        self.cargarCombustible(3000)
        self.acelerar(5000)
    }
    method cargarCombustible(cantidad) {
        combustible += cantidad
    }
    method descargarCombustible(cantidad) {
        combustible = 0.max(combustible - cantidad)
    }
    method estaTranquila() {
        return combustible >= 4000 and velocidad <= 12000
    }
    method recibirAmenaza()
    method estaDeRelajo() = self.estaTranquila()
}
class NavesBaliza inherits Naves {
    var color = "verde"

    method cambiarColorDeBaliza(colorNuevo) {
        color = colorNuevo
    }
    override method prepararViaje() {
        self.cambiarColorDeBaliza("verde")
        self.ponerseParaleloAlSol()
    }
    override method estaTranquila() = super() and color != "rojo"
    override method recibirAmenaza() {
        self.irHaciaElSol()
        self.cambiarColorDeBaliza("rojo")
    }
    override method estaDeRelajo() = color == "verde"
}
class NavesDePasajeros inherits Naves {
    var comida
    var bebida
    var cantPasajeros

    method cargarComida(cantidad) {
        comida += cantidad * cantPasajeros
    }
    method descargarComida(cantidad) {
        comida -= cantidad
    }
    method cargarBebida(cantidad) {
        bebida += cantidad * cantPasajeros
    }
    method descargarBebida(cantidad) {
        bebida -= cantidad
    }
    override method prepararViaje() {
        self.cargarComida(4)
        self.cargarBebida(6)
        self.acercarseUnPocoAlSol()
        self.cargarCombustible(3000)
        self.acelerar(5000)
    }
    override method recibirAmenaza() {
        velocidad *= 2
        self.cargarComida(2)
        self.cargarBebida(2)
    }
    override method estaDeRelajo() = comida < 50
}
class NavesDeCombate inherits Naves {
    var visible
    var misilesDesplegados
    var mensajes = []

    method ponerseVisible() {
        visible = true
    }
    method ponerseInvisible() {
        visible = false
    }
    method estaVisible() = visible
    method desplegarMisiles() {
        misilesDesplegados = true
    }
    method replegarMisiles() {
        misilesDesplegados = false
    }
    method misilesDesplegados() = misilesDesplegados
    method emitirMensaje(mensaje) {
        mensajes.add(mensaje)
    }
    method mensajesEmitidos() {
        return mensajes
    }
    method primerMensajeEmitido() {
        return mensajes.first()
    }
    method ultimoMensajeEmitido() {
        return mensajes.last()
    }
    method esEscueta() {
        return !mensajes.any({m => m.size() > 30})
    }
    method emitioMensaje(mensaje) {
        return mensajes.contains(mensaje)
    }
    override method prepararViaje() {
        self.ponerseVisible()
        self.replegarMisiles()
        self.acelerar(20000)
        self.emitirMensaje("Saliendo en mision")
        self.cargarCombustible(3000)
    }
    override method estaTranquila() = !misilesDesplegados
    override method recibirAmenaza() {
        self.acercarseUnPocoAlSol()
        self.acercarseUnPocoAlSol()
        self.emitirMensaje("Amenaza recibida")
    }
}
class NavesHospital inherits NavesDePasajeros {
    var tieneQuirofanos
    var quirofanosEstanPreparados

    method prepararQuirofanos() {
        quirofanosEstanPreparados = true
    }
    override method estaTranquila() = !quirofanosEstanPreparados
    override method recibirAmenaza() {
        self.prepararQuirofanos()
    }
}
class NavesDeCombateSigilosa inherits NavesDeCombate {
    var tranquilidad

    override method estaTranquila() = visible
    override method recibirAmenaza() {
        self.desplegarMisiles()
        self.ponerseInvisible()
    }
}