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

class DatosDeJugadorPage extends BusquedaDeJugadoresPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	
	new(Jugador jugador) {		
		val datosDeJugadorForm = new Form<Jugador>("datosDeJugadorForm", jugador.asCompoundModel)
		this.agregarDatos(datosDeJugadorForm, jugador)
		this.agregarGrillaAmigos(datosDeJugadorForm)
		this.agregarGrillaInfracciones(datosDeJugadorForm)
		this.agregarAccionesDeVolver(datosDeJugadorForm)
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
		parent.addChild(new Label("nombre"))
		parent.addChild(new Label("apodo"))
		parent.addChild(new Label("handicap"))
		parent.addChild(new Label("fechaDeNacimiento"))
		parent.addChild(new Label("promedioDeUltimoPartido"))
		parent.addChild(new Label("promedioDeTodosLosPartidos"))
		parent.addChild(new Label("partidosJugados"))
		
	}

	def agregarAccionesDeVolver(Form<Jugador> parent) {
		parent.addChild(new XButton("volver").onClick = [|abrirPantallaPrincipal])
	}

	def abrirPantallaPrincipal() {
		responsePage = new SeguidorDePartidoPage()
	}



	def agregarGrillaInfracciones(Form<Jugador> parent) {

		val listView = new XListView("infracciones")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("fecha"))
			item.addChild(new Label("hora"))
			item.addChild(new Label("descripcion"))
		]
		parent.addChild(listView)

	}

}
