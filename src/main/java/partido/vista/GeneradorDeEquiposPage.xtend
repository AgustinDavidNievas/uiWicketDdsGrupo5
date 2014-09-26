package partido.vista

import org.apache.wicket.markup.html.WebPage
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import org.apache.wicket.markup.html.form.Form
import org.uqbar.wicket.xtend.XListView
import org.apache.wicket.markup.html.basic.Label
import org.uqbar.wicket.xtend.XButton
import partido.seguidorDePartido.SeguidorDePartido
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.markup.html.form.DropDownChoice
import organizador.partidos.partido.Partido
import organizador.partidos.creador.CreadorDeEquipos
import organizador.partidos.creador.CreadorAlgoritmo1
import organizador.partidos.creador.CreadorAlgoritmo2
import organizador.partidos.criterios.Criterios
import org.apache.wicket.markup.html.form.CheckBox
import organizador.partidos.criterios.Handicap
import organizador.partidos.criterios.UltimasCalificaciones
import organizador.partidos.criterios.CriterioPromedioNCalificaciones

class GeneradorDeEquiposPage extends WebPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods

	private final SeguidorDePartidoPage mainPage
	@Property CreadorDeEquipos creador1
	@Property CreadorDeEquipos creador2
	@Property SeguidorDePartido seguidor
	@Property Criterios criterio

	new(Partido partido, SeguidorDePartido seguidor) {
		this.mainPage = mainPage
		this.creador1 = new CreadorAlgoritmo1
		this.creador2 = new CreadorAlgoritmo2

		val generarEquiposForm = new Form<SeguidorDePartido>("generarEquiposForm", seguidor.asCompoundModel)
		this.agregarGrillaDeJugadoresEquipo1(generarEquiposForm)
		this.agregarGrillaDeJugadoresEquipo2(generarEquiposForm)
		this.agregarCamposDeEdicion(generarEquiposForm)
		this.agregarAcciones(generarEquiposForm)
		this.addChild(generarEquiposForm)
	}

	def agregarGrillaDeJugadoresEquipo1(Form<SeguidorDePartido> parent) {
		val listView = new XListView("jugadores1")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("Nombre"))
			item.addChild(new Label("Apodo"))
			item.addChild(new Label("Handicap"))
			item.addChild(new Label("Promedio"))
		]

		parent.addChild(listView)
	}

	def agregarGrillaDeJugadoresEquipo2(Form<SeguidorDePartido> parent) {
		val listView = new XListView("jugadores2")
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("Nombre"))
			item.addChild(new Label("Apodo"))
			item.addChild(new Label("Handicap"))
			item.addChild(new Label("Promedio"))
		]

		parent.addChild(listView)
	}

	def agregarAcciones(Form<SeguidorDePartido> parent) {

		println("antes de los ifs" + seguidor.jugadores)
		val ordenarBoton = new XButton("ordenarJugadores").onClick = [ |
			if (seguidor.handicap == true && seguidor.ultimasCalificaciones == false &&
				seguidor.ultimasNCalificaciones == false) {

				seguidor.admin.ordenarJugadoresPor(new Handicap)
				println("en handicap if" + seguidor.jugadores)

			} else {

				if (seguidor.handicap == false && seguidor.ultimasCalificaciones == true &&
					seguidor.ultimasNCalificaciones == false) {
					seguidor.admin.ordenarJugadoresPor(new UltimasCalificaciones)
					println("en ultimasCalificaciones if" + seguidor.jugadores)
				} else {
					if (seguidor.handicap == false && seguidor.ultimasCalificaciones == false &&
						seguidor.ultimasNCalificaciones == true) {
						seguidor.admin.ordenarJugadoresPor(new CriterioPromedioNCalificaciones(seguidor.numero))
						println("en ultimasNcalificaciones if" + seguidor.jugadores)
					}

				}

			}
		]

		parent.addChild(ordenarBoton)
	}

	def agregarCamposDeEdicion(Form<SeguidorDePartido> parent) {

		parent.addChild(new CheckBox("handicap"))
		parent.addChild(new CheckBox("ultimasCalificaciones"))
		parent.addChild(new CheckBox("ultimasNCalificaciones"))
		parent.addChild(new Label("numero"))

	}

}
