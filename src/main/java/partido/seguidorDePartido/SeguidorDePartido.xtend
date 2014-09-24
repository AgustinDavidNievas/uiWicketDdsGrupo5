package partido.seguidorDePartido

import java.io.Serializable
import organizador.partidos.criterios.Criterios
import java.util.List
import organizador.partidos.jugador.Jugador

import org.uqbar.commons.utils.ApplicationContext
import organizador.partidos.criterios.Handicap
import organizador.Administrador.Admin
import organizador.home.HomeDeJugadores

class SeguidorDePartido implements Serializable {
	
	@Property List<Criterios> criterios			//Para la generacion de equipos
	@Property List<Criterios> criteriosDeBusqueda //Para la busqueda de jugadores
	@Property List<Jugador> jugadores
	@Property Jugador jugadorSeleccionado
	@Property Admin admin
	
	new(Admin unAdmin){
		super()
		this.inicializarColeccionDeJugadores
		this.inicializarColleccionDeCriterios
		this.inicializarColleccionDeCriteriosDeBusqueda
		this.admin = unAdmin
	}
	
	def inicializarColleccionDeCriteriosDeBusqueda() {
//		this.criteriosDeBusqueda = newArrayList
		//this.criteriosDeBusqueda.add()
	}
	
	def inicializarColleccionDeCriterios() {
		this.criterios = newArrayList
		this.criterios.add(new Handicap("Handicap"))
		//aca hay que poner más criterios de los que estan en el domino, esto es parte de la ventan de Ivan, me estaba confundiendo y crei que eran de la mia :P
		//ver los test del dominio para acordarse como funcionan
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
	
	def HomeDeJugadores getHomeJugadores() {
		ApplicationContext.instance.getSingleton(typeof(Jugador))

	}
	
	def seleccionarMateriaNumeroUno() {
		if (jugadores.size > 0)
			jugadorSeleccionado = jugadores.get(0)
	}
	
}