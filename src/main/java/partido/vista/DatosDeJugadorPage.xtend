package partido.vista

import org.apache.wicket.markup.html.WebPage
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.apache.wicket.markup.html.form.Form
import organizador.partidos.jugador.Jugador
import org.uqbar.wicket.xtend.XButton


class DatosDeJugadorPage extends WebPage {
		extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
		
		new(Jugador jugador) {
		
		val datosDeJugadorForm = new Form<Jugador>("datosDeJugadorForm", jugador.asCompoundModel)
		this.agregarGrillaDatos(datosDeJugadorForm)
		this.agregarAcciones(datosDeJugadorForm)
		this.addChild(datosDeJugadorForm)
		this.actualizar
	}
	
	def agregarGrillaDatos (Form<Jugador> Parent){
		
		
	}
	
	def agregarAcciones(Form<Jugador> Parent){
		
		parent.addChild(new XButton("volver")
		.onClick = [|abrirPantallaPrincipal])	}
	
	def abrirPantallaPrincipal() {
		responsePage = new SeguidorDePartidoPage()
	}
	
	def actualizar() {
		
		
	}
	
	
	
}