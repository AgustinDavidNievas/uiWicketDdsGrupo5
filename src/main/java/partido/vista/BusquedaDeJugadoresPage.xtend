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
import org.apache.wicket.model.CompoundPropertyModel
import org.apache.wicket.markup.html.list.ListItem
import org.apache.wicket.markup.html.form.CheckBox
import org.apache.wicket.behavior.SimpleAttributeModifier
import org.apache.wicket.model.PropertyModel

class BusquedaDeJugadoresPage extends WebPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	@Property SeguidorDePartido seguidor

	new() {
		super()
	}

	new(Partido partido, SeguidorDePartido seguidorComoParametro) {
		this.seguidor = seguidorComoParametro
		val busquedaDeJugadoresForm = new Form<SeguidorDePartido>("busquedaDeJugadoresForm",
			new CompoundPropertyModel<SeguidorDePartido>(this.seguidor))

		//val busquedaDeJugadoresForm = new Form<SeguidorDePartido>("busquedaDeJugadoresForm", seguidor.asCompoundModel)
		this.agregarCamposDeBusqueda(busquedaDeJugadoresForm)
		this.agregarAcciones(busquedaDeJugadoresForm)
		this.agregarGrillaDeJugadores(busquedaDeJugadoresForm)
		this.agregarCheckBox(busquedaDeJugadoresForm)
		this.agregarAccionesDelCheckBox(busquedaDeJugadoresForm)
		this.addChild(busquedaDeJugadoresForm)
		this.actualizar
	}

	def agregarAccionesDelCheckBox(Form<SeguidorDePartido> form) {
		val checkBoxBoton = new XButton("checkBoxBoton").onClick = [ |
			if (seguidor.infraccionBool == true) {
				seguidor.buscarJugadoresConInfracciones
			} else {
				seguidor.volverALaListaDeJugadoresSinFiltrar
			}
		]

		form.addChild(checkBoxBoton)
	}

	def agregarCheckBox(Form<SeguidorDePartido> parent) {
		val infraccion = new CheckBox("infraccionBool")
		parent.addChild(infraccion)
	}

	def actualizar() {
		this.seguidor.search
	}

	def agregarGrillaDeJugadores(Form<SeguidorDePartido> parent) {

		
		
		val listView = new XListView("jugadores")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))
			item.addChild(new Label("apodo"))
			item.addChild(this.label1(item.modelObject))
					
			//item.addChild(new Label("promedio")) esto no lo tiene como property el jugador, vamos a tener que agregarla o calcularlo de alguna manera :P
			this.botonAbrirDatosDeJugador(item)
		]

		parent.addChild(listView)
	}

def label1(Jugador jugador){
	
	val label1 = new Label("handicap", new PropertyModel(jugador, "handicap"))
	val styleAttr = ("color:blue;")
	if (jugador.handicap > 8) {
						label1.add(new SimpleAttributeModifier("style", styleAttr))
						
			}
			return label1
}

	def botonAbrirDatosDeJugador(ListItem<Jugador> item) {
		item.addChild(
			new XButton("editarJugador").onClick = [|seguidor.jugadorSeleccionado = item.modelObject
				this.abrirDatosDeJugadorPage(seguidor.jugadorSeleccionado)]
		)
	}

	def abrirDatosDeJugadorPage(Jugador jugador) {
		responsePage = new DatosDeJugadorPage(jugador, this)
	}

	def agregarAcciones(Form<SeguidorDePartido> parent) {
		val buscarButton = new XButton("buscar")
		buscarButton.onClick = [|seguidor.search]
		parent.addChild(buscarButton)

		parent.addChild(
			new XButton("limpiar").onClick = [|seguidor.clear]
		)

		val buscarHasta = new XButton("buscarHasta")
		buscarHasta.onClick = [|seguidor.buscarHandicapHasta(seguidor.handicap)]
		parent.addChild(buscarHasta)

		val buscarDesde = new XButton("buscarDesde") //por alguna razon este boton da null cuando se ejecuta...
		buscarHasta.onClick = [|seguidor.buscarHandicapDesde(seguidor.handicap)]
		parent.addChild(buscarDesde)

		parent.addChild(
			new XButton("clear").onClick = [|seguidor.volverALaListaDeJugadoresSinFiltrar]
		)

	}

	def agregarCamposDeBusqueda(Form<SeguidorDePartido> parent) {
		parent.addChild(new TextField<String>("nombre"))
		parent.addChild(new TextField<String>("apodo"))
		parent.addChild(new TextField<Integer>("handicap"))
	}

}
