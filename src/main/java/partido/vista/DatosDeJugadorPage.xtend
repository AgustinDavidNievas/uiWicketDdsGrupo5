package partido.vista

import org.apache.wicket.markup.html.WebPage
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.apache.wicket.markup.html.form.Form
import organizador.partidos.jugador.Jugador
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import org.apache.wicket.markup.html.basic.Label

class DatosDeJugadorPage extends WebPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods

	new(Jugador jugador) {

		val datosDeJugadorForm = new Form<Jugador>("datosDeJugadorForm", jugador.asCompoundModel)
		this.agregarGrillaDatos(datosDeJugadorForm)
		//this.agregarGrillaInfracciones(datosDeJugadorForm)
		this.agregarAcciones(datosDeJugadorForm)
		this.addChild(datosDeJugadorForm)
		this.actualizar
	}

	def agregarGrillaDatos(Form<Jugador> parent) {

		parent.addChild(new Label("nombre"))
		parent.addChild(new Label("apodo"))
		parent.addChild(new Label("handicap"))
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
