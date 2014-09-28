package partido.seguidorDePartido

import java.io.Serializable
import organizador.partidos.criterios.Criterios
import java.util.List
import organizador.partidos.jugador.Jugador

import org.uqbar.commons.utils.ApplicationContext
import organizador.partidos.criterios.Handicap
import organizador.Administrador.Admin
import organizador.home.HomeDeJugadores
import java.util.ArrayList
import organizador.partidos.creador.CreadorAlgoritmo1
import organizador.partidos.creador.CreadorDeEquipos
import organizador.partidos.creador.CreadorAlgoritmo2
import organizador.partidos.criterios.CriterioPromedioNCalificaciones
import organizador.partidos.criterios.UltimasCalificaciones
import org.uqbar.wicket.xtend.XListView

class SeguidorDePartido implements Serializable {

	@Property List<CreadorDeEquipos> criteriosDeSeleccion
	@Property List<Criterios> criteriosDeOrdenamiento //Para la generacion de equipos
	@Property List<Criterios> criteriosDeBusqueda //Para la busqueda de jugadores
	@Property List<Jugador> jugadores
	@Property List<Jugador> jugadores1
	@Property List<Jugador> jugadores2
	@Property Jugador jugadorSeleccionado
	@Property Admin admin
	
	@Property Boolean handicap = false
	@Property Boolean ultimasCalificaciones = false
	@Property Boolean ultimasNCalificaciones = false
	@Property int numero
	

	//Para que funcione la busqueda de jugadores//
	@Property String nombre
	@Property String apodo

	//******************************************//
	new(Admin unAdmin) {
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
		this.criteriosDeSeleccion = newArrayList
		this.criteriosDeSeleccion.add(new CreadorAlgoritmo1)
		this.criteriosDeSeleccion.add(new CreadorAlgoritmo2)

	//aca hay que poner más criterios de los que estan en el domino, esto es parte de la ventan de Ivan, me estaba confundiendo y crei que eran de la mia :P
	//ver los test del dominio para acordarse como funcionan
	}



	

	def void inicializarColeccionDeJugadores() {
		this.jugadores = newArrayList
		this.actualizar
		this.jugadores1 = newArrayList
		this.jugadores2 = newArrayList
	}

	def actualizar() {
		this.jugadores = homeDeJugadores.allInstances.toList
		this.seleccionarMateriaNumeroUno
	}

	def HomeDeJugadores getHomeDeJugadores() {
		ApplicationContext.instance.getSingleton(typeof(Jugador))

	}

	def seleccionarMateriaNumeroUno() {
		if (jugadores.size > 0)
			jugadorSeleccionado = jugadores.get(0)
	}

	def void search() {

		jugadores = new ArrayList<Jugador>

		jugadores = getHomeDeJugadores().search(getNombre, getApodo)

	}

	def void clear() {
		nombre = null
		apodo = null
	}

}
