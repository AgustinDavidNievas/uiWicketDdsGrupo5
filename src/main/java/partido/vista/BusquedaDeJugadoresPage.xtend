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

class BusquedaDeJugadoresPage extends WebPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	@Property SeguidorDePartido seguidor
	

	new(Partido partido, SeguidorDePartido seguidorComoParametro) {
		this.seguidor = seguidorComoParametro
		val busquedaDeJugadoresForm = new Form<SeguidorDePartido>("busquedaDeJugadoresForm", new CompoundPropertyModel<SeguidorDePartido>(this.seguidor))
		//val busquedaDeJugadoresForm = new Form<SeguidorDePartido>("busquedaDeJugadoresForm", seguidor.asCompoundModel)
		this.agregarCamposDeBusqueda(busquedaDeJugadoresForm)
		this.agregarAcciones(busquedaDeJugadoresForm)
		this.agregarGrillaDeJugadores(busquedaDeJugadoresForm)
		this.addChild(busquedaDeJugadoresForm)
		this.actualizar
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
			item.addChild(new Label("handicap"))
			//item.addChild(new Label("promedio")) esto no lo tiene como property el jugador, vamos a tener que agregarla o calcularlo de alguna manera :P
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
		
		val buscarHasta = new XButton("buscarHasta")
		buscarHasta.onClick = [|seguidor.buscarHandicapHasta(seguidor.handicap)]
		parent.addChild(buscarHasta)
		
		val buscarDesde = new XButton("buscarDesde")//por alguna razon este boton da null cuando se ejecuta...
		buscarHasta.onClick = [|seguidor.buscarHandicapDesde(seguidor.handicap)]
		parent.addChild(buscarDesde)
		
		parent.addChild(new XButton("clear")
			.onClick = [|seguidor.volverALaListaDeJugadoresSinFiltrar]
		)
	
	}

	def agregarCamposDeBusqueda(Form<SeguidorDePartido> parent) {
		parent.addChild(new TextField<String>("nombre"))
		parent.addChild(new TextField<String>("apodo"))
		parent.addChild(new TextField<Integer>("handicap"))
	}

}
