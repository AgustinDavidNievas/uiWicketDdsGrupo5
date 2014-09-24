package partido.vista

import org.apache.wicket.markup.html.WebPage
import partido.seguidorDePartido.SeguidorDePartido
import org.apache.wicket.markup.html.form.Form
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import organizador.partidos.jugador.Jugador
import organizador.partidos.partido.Partido
import organizador.partidos.jugador.Estandar
import organizador.Administrador.Admin

class SeguidorDePartidoPage extends WebPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods

	@Property SeguidorDePartido seguidor
	@Property Partido partido
	@Property Admin unAdmin

	new() {
		this.unAdmin = new Admin("admin@mail.com")
		this.partido = new Partido("20/58/14", "Campus", "05:00pm", unAdmin)
		this.seguidor = new SeguidorDePartido(unAdmin)
		val seguidorDePartidoForm = new Form<SeguidorDePartido>("seguidorDePartidoForm", this.seguidor.asCompoundModel)
		this.agregarAcciones(seguidorDePartidoForm)
		this.addChild(seguidorDePartidoForm)
		this.actualizar

	}

	def actualizar() {
		this.seguidor.actualizar
	}

	def agregarAcciones(Form<SeguidorDePartido> parent) {

		val busquedaDeJugadoresButton = new XButton("busquedaDeJugadores")
		busquedaDeJugadoresButton.onClick = [|nuevaBusquedaDeJugadores(new Jugador("Roman", new Estandar, 30))]
		parent.addChild(busquedaDeJugadoresButton)

		parent.addChild(
			new XButton("generadorDeEquipos") => [
				onClick = [|]
			])
	}

	def nuevaBusquedaDeJugadores(Jugador jugador) {
		responsePage = new BusquedaDeJugadoresPage(partido,this.seguidor,this.unAdmin)
	}

}
