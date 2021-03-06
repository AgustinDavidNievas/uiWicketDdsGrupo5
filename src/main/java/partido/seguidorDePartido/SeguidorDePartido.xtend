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
import organizador.partidos.jugador.Estandar
import organizador.partidos.partido.Partido
import organizador.partidos.jugador.Tipo

class SeguidorDePartido implements Serializable {

	@Property List<CreadorDeEquipos> criteriosDeSeleccion
	@Property List<Criterios> criteriosDeOrdenamiento //Para la generacion de equipos
	@Property List<Criterios> criteriosDeBusqueda //Para la busqueda de jugadores
	@Property List<Jugador> jugadores
	@Property List<Jugador> jugadores1
	@Property List<Jugador> jugadores2
	/**********esta lista esta para que funcione el limpiar de handicap en la busquedaDeJugadores**********/
	@Property List<Jugador> jugadoresSinFiltrar
	/******************************************************************************************************/
	@Property Jugador jugadorSeleccionado
	@Property Admin admin
	@Property Partido partido
	
	//para que funcionen la divicion de equipos
	@Property Boolean algoritmo1Bool = false
	@Property Boolean algoritmo2Bool = false
	
	//para que funcionen los ordenamienos	
	@Property Boolean handicapBool = false
	@Property Boolean ultimasCalificaciones = false
	@Property Boolean ultimasNCalificaciones = false
	@Property int numero

	//Para que funcione la busqueda de jugadores//
	@Property String nombre
	@Property String apodo
	@Property Integer handicap
	@Property Boolean infraccionBool = false
	@Property int promedioDeUltimoPartido
	//******************************************//
	
	@Property Tipo tipo = new Estandar //todos los jugadores los creamos como estandar
	
	new(Admin unAdmin,Partido unPartido) {
		super()
		this.admin = unAdmin
		this.partido = unPartido
		this.inicializarColeccionDeJugadores
		this.inicializarColleccionDeCriterios
		this.inicializarColleccionDeCriteriosDeBusqueda
		

	}

	def inicializarColleccionDeCriteriosDeBusqueda() {
		//this.criteriosDeBusqueda = newArrayList
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
		this.homeDeJugadores.init
		this.jugadores = homeDeJugadores.allInstances.toList

		//esto esta momentaneamente para probar las vistas, el home por alguna razon no esta cargando los jugadores en la lista :(
		/*val hugo = new Jugador("Hugo", new Estandar, 40, "koku")
		this.admin.definirHandicap(hugo,8)
		this.jugadores.add(hugo)
		val gaby = new Jugador("Gaby", new Estandar, 30, "Ga")
		this.admin.definirHandicap(gaby,6)
		this.jugadores.add(gaby)
		val rodry = new Jugador("Rodry", new Estandar, 20, "Ro")
		this.admin.definirHandicap(rodry,7)
		this.jugadores.add(rodry)
		val ivan = new Jugador("Ivan", new Estandar, 22, "Ivu")
		this.admin.definirHandicap(ivan,2)
		this.jugadores.add(ivan)
		val quique = new Jugador("Quique", new Estandar, 27, "Qui")
		this.admin.definirHandicap(quique,1)
		this.jugadores.add(quique)
		val daniel = new Jugador("Daniel", new Estandar, 31, "Dani")
		this.admin.definirHandicap(daniel,6)
		this.jugadores.add(daniel)
		val po = new Jugador("Po", new Estandar, 2, "P")
		this.admin.definirHandicap(po,3)
		this.jugadores.add(po)
		val iroito = new Jugador("Iroito", new Estandar, 100, "Iru")
		this.admin.definirHandicap(iroito,10)
		this.jugadores.add(iroito)
		val cuirassier = new Jugador("Cuirassier", new Estandar, 28, "Cu")
		this.admin.definirHandicap(cuirassier,9)
		this.jugadores.add(cuirassier)
		val carla = new Jugador("Carla", new Estandar, 14, "La Carla")
		this.admin.definirHandicap(carla,3)
		this.jugadores.add(carla)
		
		hugo.calificarA(gaby,10,"un crack")
		hugo.calificarA(rodry,7,"aceptable")
		hugo.calificarA(ivan,1,"Baby")
		hugo.calificarA(quique,5,"ads")
		hugo.calificarA(daniel,7,"kjhasfkajhf")
		hugo.calificarA(po,2,"Baby")
		hugo.calificarA(iroito,10,"pro")
		hugo.calificarA(cuirassier,10,"groso")
		hugo.calificarA(carla,7,";)")
		
		ivan.calificarA(hugo,9,"fuck me!")
		ivan.calificarA(rodry,3,"lalalalalala")
		ivan.calificarA(gaby,5,"blow")*/
		//**********************************************************************************************************************//
		this.jugadoresSinFiltrar = this.jugadores
		this.seleccionarJugadorNumeroUno
		this.partido.inscriptos = jugadores
	
	}

	def HomeDeJugadores getHomeDeJugadores() {
		ApplicationContext.instance.getSingleton(typeof(Jugador))

	}

	def seleccionarJugadorNumeroUno() {
		if (jugadores.size > 0)
			jugadorSeleccionado = jugadores.get(0)
	}

	def void search() {

		jugadores = new ArrayList<Jugador>

		jugadores = getHomeDeJugadores().search(getNombre, getApodo)
		
		jugadoresSinFiltrar = getHomeDeJugadores().search(getNombre, getApodo)
	}

	def void clear() {
		nombre = null
		apodo = null
	}
	
	def buscarHandicapHasta(Integer numero){//preguntarle a Lucas como parametrizar el "<" para no duplicar código
		this.jugadores = jugadores.filter[unJugador|unJugador.handicap >= numero].toList
	}
	
	def buscarHandicapDesde(Integer numero){
		this.jugadores = jugadores.filter[unJugador|unJugador.handicap <= numero].toList
	}
	
	def buscarPromedioDelUltimoPartidoHasta(int numero){
		this.jugadores = jugadores.filter[unJugador|unJugador.promedioDeUltimoPartido >= numero].toList
	}
	
	def buscarPromedioDelUltimoPartidoDesde(int numero){
		this.jugadores = jugadores.filter[unJugador|unJugador.promedioDeUltimoPartido <= numero].toList
	}
	
	def volverALaListaDeJugadoresSinFiltrar(){
		this.jugadores = this.jugadoresSinFiltrar
	}
	
	def buscarJugadoresConInfracciones(){
		this.jugadores = jugadores.filter[unJugador|(unJugador.infracciones.size) > 0].toList
	}

}