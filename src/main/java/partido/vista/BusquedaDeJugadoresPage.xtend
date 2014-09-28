package partido.vista

import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.TextField
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import organizador.partidos.jugador.Jugador
import organizador.partidos.partido.Partido
import partido.seguidorDePartido.SeguidorDePartido

class BusquedaDeJugadoresPage extends WebPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	@Property SeguidorDePartido seguidor
	

	new(Partido partido, SeguidorDePartido seguidorComoParametro) {
		this.seguidor = seguidorComoParametro
		
		val busquedaDeJugadoresForm = new Form<SeguidorDePartido>("busquedaDeJugadoresForm", seguidor.asCompoundModel)
		this.agregarCamposDeBusqueda(busquedaDeJugadoresForm)
		this.agregarAcciones(busquedaDeJugadoresForm)
		this.agregarGrillaDeJugadores(busquedaDeJugadoresForm)
		this.addChild(busquedaDeJugadoresForm)
		this.actualizar
	}

	def actualizar() {
		//TODO
	}

	def agregarGrillaDeJugadores(Form<SeguidorDePartido> parent) {
		val listView = new XListView("jugadores")
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

	def agregarAcciones(Form<SeguidorDePartido> parent) {
		val buscarButton = new XButton("buscar")
		buscarButton.onClick = [| seguidor.search ]
		parent.addChild(buscarButton)
		
		parent.addChild(new XButton("limpiar")
			.onClick = [| seguidor.clear ]
		)
		
	
	}

	def agregarCamposDeBusqueda(Form<SeguidorDePartido> parent) {
		/*parent.addChild(
			new DropDownChoice<Criterios>("criteriosDeBusqueda") => [
				choices = loadableModel([|seguidor.criteriosDeBusqueda])
			])
		parent.addChild(new TextField<String>("comienzaCon"))*///hacer if depende del criterio hacer distinto textField...
		parent.addChild(new TextField<String>("nombre"))
		parent.addChild(new TextField<String>("apodo"))
	}

}
