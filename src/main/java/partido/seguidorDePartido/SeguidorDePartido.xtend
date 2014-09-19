package partido.seguidorDePartido

import java.io.Serializable
import organizador.partidos.criterios.Criterios
import java.util.List
import organizador.partidos.jugador.Jugador
import partido.home.HomeJugadores
import org.uqbar.commons.utils.ApplicationContext

class SeguidorDePartido implements Serializable {
	
	@Property List<Criterios> criterios
	@Property List<Jugador> jugadores
	@Property Jugador jugadorSeleccionado
	
	new(){
		super()
		this.inicializarColeccionDeJugadores
		this.inicializarColleccionDeCriterios

	}
	
	def inicializarColleccionDeCriterios() {
		this.criterios = newArrayList
	}

	def void inicializarColeccionDeJugadores() {
		this.jugadores = newArrayList
		this.actualizar
	}
	
	def actualizar() {
		jugadores = newArrayList
		//this.jugadores = homeJugadores.allInstances.toList
		this.seleccionarMateriaNumeroUno
	}
	
	def HomeJugadores getHomeJugadores() {
		ApplicationContext.instance.getSingleton(typeof(Jugador))

	}
	
	def seleccionarMateriaNumeroUno() {
		if (jugadores.size > 0)
			jugadorSeleccionado = jugadores.get(0)
	}
	
}