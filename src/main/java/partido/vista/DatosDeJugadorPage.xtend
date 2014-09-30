package partido.vista

import org.apache.wicket.markup.html.WebPage
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.apache.wicket.markup.html.form.Form
import organizador.partidos.jugador.Jugador
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import org.apache.wicket.markup.html.basic.Label
import organizador.partidos.criterios.UltimasCalificaciones
import organizador.partidos.criterios.CriterioPromedioNCalificaciones

class DatosDeJugadorPage extends WebPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	
	new(Jugador jugador) {		
		val datosDeJugadorForm = new Form<Jugador>("datosDeJugadorForm", jugador.asCompoundModel)
		this.agregarDatos(datosDeJugadorForm, jugador)
		this.agregarGrillaAmigos(datosDeJugadorForm)
		//this.agregarGrillaInfracciones(datosDeJugadorForm)
		this.agregarAcciones(datosDeJugadorForm)
		this.addChild(datosDeJugadorForm)
		this.actualizar
	}
	
	def agregarGrillaAmigos(Form<Jugador> parent) {
		val listView = new XListView("amigos")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))
			]

		parent.addChild(listView)
	}

	def agregarDatos(Form<Jugador> parent, Jugador jugador) {
		val calificacionesUltimoPartido = new UltimasCalificaciones
		val promedioTodosPartidos = new CriterioPromedioNCalificaciones(jugador.partidosJugados)
//		val promedioDelUltimoPartido = calificacionesUltimoPartido.aplicarCriterio(jugador)
//		val promedioDeTodosLosPartidos= promedioTodosPartidos.aplicarCriterio(jugador)
		parent.addChild(new Label("nombre"))
		parent.addChild(new Label("apodo"))
		parent.addChild(new Label("handicap"))
		parent.addChild(new Label("fechaDeNacimiento"))
//		parent.addChild(new Label("promedioDelUltimoPartido")) Feedback panel?
//		parent.addChild(new Label("promedioDeTodosLosPartidos"))
		parent.addChild(new Label("partidosJugados"))
		//mirar los test para los demas atributos, creo que ya tenemos mensajes que calculan esas cosas...
	}

	def agregarAcciones(Form<Jugador> parent) {
		parent.addChild(new XButton("volver").onClick = [|abrirPantallaPrincipal])
	}

	def abrirPantallaPrincipal() {
		responsePage = new SeguidorDePartidoPage()
	}

	def actualizar() {
	}

	def agregarGrillaInfracciones(Form<Jugador> parent) {

		val listView = new XListView("infracciones")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("numeroDeInfraccion"))
			item.addChild(new Label("fecha"))
			item.addChild(new Label("hora"))
			item.addChild(new Label("descripcion"))
		]

	}

}
