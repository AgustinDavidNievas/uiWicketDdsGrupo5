package partido.vista

import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.CheckBox
import org.apache.wicket.markup.html.form.Form
import org.eclipse.xtend.lib.Property
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.uqbar.wicket.xtend.XButton
import org.uqbar.wicket.xtend.XListView
import organizador.partidos.creador.CreadorAlgoritmo1
import organizador.partidos.creador.CreadorAlgoritmo2
import organizador.partidos.creador.CreadorDeEquipos
import organizador.partidos.criterios.CriterioPromedioNCalificaciones
import organizador.partidos.criterios.Criterios
import organizador.partidos.criterios.Handicap
import organizador.partidos.criterios.UltimasCalificaciones
import organizador.partidos.partido.Partido
import partido.seguidorDePartido.SeguidorDePartido

class GeneradorDeEquiposPage extends WebPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods

	private final SeguidorDePartidoPage mainPage
	@Property CreadorDeEquipos creador1
	@Property CreadorDeEquipos creador2
	@Property SeguidorDePartido seguidor
	@Property Criterios criterio
	


	new(Partido partido, SeguidorDePartido seguidorDeParametro) {
		this.mainPage = mainPage
		this.creador1 = new CreadorAlgoritmo1
		this.creador2 = new CreadorAlgoritmo2
		this.seguidor = seguidorDeParametro

		val generarEquiposForm = new Form<SeguidorDePartido>("generarEquiposForm", seguidor.asCompoundModel)
		this.agregarGrillaDeJugadoresEquipo1(generarEquiposForm)
		this.agregarGrillaDeJugadoresEquipo2(generarEquiposForm)
		this.agregarGrillaDeJugadores(generarEquiposForm)
		this.agregarCamposDeEdicion(generarEquiposForm)
		this.agregarAcciones(generarEquiposForm)
		this.addChild(generarEquiposForm)
		
		
	}

def agregarGrillaDeJugadores(Form<SeguidorDePartido> parent) {
		val listView = new XListView("jugadores")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))

		]

		parent.addChild(listView)
	}


	def agregarGrillaDeJugadoresEquipo1(Form<SeguidorDePartido> parent) {
		val listView = new XListView("jugadores1")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))
			item.addChild(new Label("apodo"))
			item.addChild(new Label("handicap"))
			item.addChild(new Label("promedio"))
		]

		parent.addChild(listView)
	}

	def agregarGrillaDeJugadoresEquipo2(Form<SeguidorDePartido> parent) {
		val listView = new XListView("jugadores2")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))
			item.addChild(new Label("apodo"))
			item.addChild(new Label("handicap"))
			item.addChild(new Label("promedio"))
		]

		parent.addChild(listView)
	}

	def agregarAcciones(Form<SeguidorDePartido> parent) {

		println("antes de los ifs" + seguidor.jugadores)
		val ordenarBoton = new XButton("ordenarJugadores").onClick = [ |
			if (seguidor.handicapBool == true && seguidor.ultimasCalificaciones == false &&
				seguidor.ultimasNCalificaciones == false) {

				seguidor.admin.ordenarJugadoresPor(new Handicap)
				seguidor.jugadores = seguidor.admin.inscriptosOrdenados
				println("en handicap if" + seguidor.jugadores)

			} else {

				if (seguidor.handicapBool == false && seguidor.ultimasCalificaciones == true &&
					seguidor.ultimasNCalificaciones == false) {
					seguidor.admin.ordenarJugadoresPor(new UltimasCalificaciones)
					seguidor.jugadores = seguidor.admin.inscriptosOrdenados
					println("en ultimasCalificaciones if" + seguidor.jugadores)
				} else {
					if (seguidor.handicapBool == false && seguidor.ultimasCalificaciones == false &&
						seguidor.ultimasNCalificaciones == true) {
						seguidor.admin.ordenarJugadoresPor(new CriterioPromedioNCalificaciones(seguidor.numero))
						seguidor.jugadores = seguidor.admin.inscriptosOrdenados
						println("en ultimasNcalificaciones if" + seguidor.jugadores)
					}

				}

			}
		]

		parent.addChild(ordenarBoton)
	}

	def agregarCamposDeEdicion(Form<SeguidorDePartido> parent) {

		parent.addChild(new CheckBox("handicapBool"))
		parent.addChild(new CheckBox("ultimasCalificaciones"))
		parent.addChild(new CheckBox("ultimasNCalificaciones"))
		parent.addChild(new Label("numero"))

	}

}
