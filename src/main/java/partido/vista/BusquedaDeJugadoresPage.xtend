package partido.vista

import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.DropDownChoice
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.TextField
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import organizador.Administrador.Admin
import organizador.partidos.jugador.Jugador
import organizador.partidos.partido.Partido
import partido.criteriosDeBusquedaDeLaUi.CriteriosDeBusqueda
import partido.seguidorDePartido.SeguidorDePartido

class BusquedaDeJugadoresPage extends WebPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	@Property SeguidorDePartido seguidor
	@Property Admin admin

	new(Partido partido, SeguidorDePartido seguidor, Admin unAdmin) {
		this.seguidor = seguidor
		this.admin = unAdmin
		
		val busquedaDeJugadoresForm = new Form<Partido>("busquedaDeJugadoresForm", partido.asCompoundModel)
		this.agregarCamposDeEdicion(busquedaDeJugadoresForm)
		//this.agregarAcciones(busquedaDeJugadoresForm)
		this.agregarGrillaDeJugadores(busquedaDeJugadoresForm)
		this.addChild(busquedaDeJugadoresForm)
		this.actualizar
	}

	def actualizar() {
		//TODO
	}

	def agregarGrillaDeJugadores(Form<Partido> parent) {
		val listView = new XListView("inscriptos")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("Nombre"))
			item.addChild(new Label("Apodo"))
			item.addChild(new Label("Handicap"))
			item.addChild(new Label("Promedio"))
			item.addChild(
				new XButton("editarJugador").onClick = [|seguidor.jugadorSeleccionado = item.modelObject
					this.abrirDatosDeJugadorPage(seguidor.jugadorSeleccionado)]
			)
		]

		parent.addChild(listView)
	}

	def abrirDatosDeJugadorPage(Jugador jugador) {
		responsePage = new DatosDeJugadorPage(jugador)
	}

	def agregarAcciones(Form<Partido> form) {
		//TODO
	}

	def agregarCamposDeEdicion(Form<Partido> parent) {
		parent.addChild(
			new DropDownChoice<CriteriosDeBusqueda>("criteriosDeBusqueda") => [
				choices = loadableModel([|seguidor.criteriosDeBusqueda])
			])
		parent.addChild(new TextField<String>("comienzaCon"))//hacer if depende del criterio hacer distinto textField...
	}

}
