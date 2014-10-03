package partido.vista

import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.model.PropertyModel
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import organizador.partidos.jugador.Jugador
import org.apache.wicket.behavior.SimpleAttributeModifier

class DatosDeJugadorPage extends BusquedaDeJugadoresPage {
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods


		
	new(Jugador jugador) {
		val datosDeJugadorForm = new Form<Jugador>("datosDeJugadorForm", jugador.asCompoundModel)
		this.agregarDatos(datosDeJugadorForm, jugador)
		this.agregarGrillaAmigos(datosDeJugadorForm)
		this.agregarGrillaInfracciones(datosDeJugadorForm)
		this.agregarAccionesDeVolver(datosDeJugadorForm)
		this.addChild(datosDeJugadorForm)
		this.prueba1(datosDeJugadorForm, jugador)
		this.actualizar //De hecho, no se por qué tendria que actualizar yo, 
						//creo que esta al pedo. Ademas, si no hago un override, 
						//tira error porque el home parece ser que aparece como null, 
						//entonces hay NullPointereException.
	}
	
	def agregarGrillaAmigos(Form<Jugador> parent) {
		val listView = new XListView("amigos")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))
		]

		parent.addChild(listView)
	}

override actualizar() {
	//bien y vos?
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

	def prueba1(Form<Jugador> parent, Jugador jugador) {
		val label1 = new Label("labelEdad", new PropertyModel(jugador, "edad"))
		val styleAttr = "color:blue;"
		if(jugador.edad>20){
		label1.add(new SimpleAttributeModifier("style", styleAttr))}
		parent.addChild(label1)
	}
	
}
