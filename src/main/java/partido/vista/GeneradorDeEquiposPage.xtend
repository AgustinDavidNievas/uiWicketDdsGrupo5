package partido.vista

import org.apache.wicket.markup.html.basic.Label
import org.apache.wicket.markup.html.form.CheckBox
import org.apache.wicket.markup.html.form.Form
import org.apache.wicket.markup.html.form.TextField
import org.apache.wicket.markup.html.list.ListItem
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
import organizador.partidos.jugador.Jugador
import organizador.partidos.partido.Partido
import partido.seguidorDePartido.SeguidorDePartido
import org.apache.wicket.markup.html.WebPage
import org.apache.wicket.markup.html.panel.FeedbackPanel
import partido.excepciones.UltimasNCalificacionesEsCero

class GeneradorDeEquiposPage extends BusquedaDeJugadoresPage {

	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods

	private final SeguidorDePartidoPage mainPage
	@Property CreadorDeEquipos creador1
	@Property CreadorDeEquipos creador2
	@Property SeguidorDePartido seguidor
	@Property Criterios criterio

	new(Partido partido, SeguidorDePartido seguidorDeParametro, WebPage quienLlama) {

		this.mainPage = mainPage
		this.creador1 = new CreadorAlgoritmo1
		this.creador2 = new CreadorAlgoritmo2
		this.seguidor = seguidorDeParametro

		val generarEquiposForm = new Form<SeguidorDePartido>("generarEquiposForm", seguidor.asCompoundModel)
		this.agregarGrillaDeJugadoresEquipo(generarEquiposForm, "jugadores1")
		this.agregarGrillaDeJugadoresEquipo(generarEquiposForm, "jugadores2")
		this.agregarGrillaDeJugadores(generarEquiposForm, "jugadores")
		this.agregarCamposDeEdicion(generarEquiposForm)
		this.agregarAccionesOrdenamiento(generarEquiposForm)
		this.agregarAccionesDivisionEquipos(generarEquiposForm)
		super.agregarAccionesDeVolver(generarEquiposForm, quienLlama)
		this.addChild(generarEquiposForm)

	}

	def agregarGrillaDeJugadores(Form<SeguidorDePartido> parent, String jugadores) {
		val listView = new XListView(jugadores)
		bloqueNombreJugadores(listView)
		parent.addChild(listView)
	}

	def bloqueNombreJugadores(XListView<Object> listView) {
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))
		]
	}

	def agregarGrillaDeJugadoresEquipo(Form<SeguidorDePartido> parent, String jugadores) {
		val listView = new XListView(jugadores)
		bloqueDatosCompletosJugador(listView)
		parent.addChild(listView)
	}

	def bloqueDatosCompletosJugador(XListView<Jugador> listView) {
		listView.populateItem = [ item |
			item.model = item.modelObject.asCompoundModel
			item.addChild(new Label("nombre"))
			item.addChild(new Label("apodo"))
			item.addChild(super.label1(item.modelObject))
			super.botonAbrirDatosDeJugador(item)
		]
	}

	def agregarAccionesDivisionEquipos(Form<SeguidorDePartido> parent) {

		val dividirBoton = new XButton("dividirEquipos").onClick = [ |
			if (seguidor.algoritmo1Bool == true && seguidor.algoritmo2Bool == false) {
				seguidor.admin.solicitarCreacionDeEquiposTentativos(new CreadorAlgoritmo1)
				seguidor.jugadores1 = seguidor.admin.equipoTentativo1
				seguidor.jugadores2 = seguidor.admin.equipoTentativo2
			} else {
				if (seguidor.algoritmo1Bool == false && seguidor.algoritmo2Bool == true) {
					seguidor.admin.solicitarCreacionDeEquiposTentativos(new CreadorAlgoritmo2)
					seguidor.jugadores1 = seguidor.admin.equipoTentativo1
					seguidor.jugadores2 = seguidor.admin.equipoTentativo2
				}
			}
		]
		parent.addChild(dividirBoton)
	}

	def agregarAccionesOrdenamiento(Form<SeguidorDePartido> parent) {

		val ordenarBoton = new XButton("ordenarJugadores").onClick = [ |
			try {

				if (seguidor.handicapBool == true && seguidor.ultimasCalificaciones == false &&
					seguidor.ultimasNCalificaciones == false) {

					seguidor.admin.ordenarJugadoresPor(new Handicap)
					seguidor.jugadores = seguidor.admin.inscriptosOrdenados

				} else {

					if (seguidor.handicapBool == false && seguidor.ultimasCalificaciones == true &&
						seguidor.ultimasNCalificaciones == false) {
						seguidor.admin.ordenarJugadoresPor(new UltimasCalificaciones)
						seguidor.jugadores = seguidor.admin.inscriptosOrdenados

					} else {
						if (seguidor.handicapBool == false && seguidor.ultimasCalificaciones == false &&
							seguidor.ultimasNCalificaciones == true) {

							if (seguidor.numero == 0) {
								throw new UltimasNCalificacionesEsCero("N no puede ser 0 ;)")

							} else {

								seguidor.admin.ordenarJugadoresPor(new CriterioPromedioNCalificaciones(seguidor.numero))
								seguidor.jugadores = seguidor.admin.inscriptosOrdenados
							}
						}

					}

				}

			} catch (UltimasNCalificacionesEsCero e) {
				info(e.getMessage)

			}
		]

		parent.addChild(ordenarBoton)
	}

	def agregarCamposDeEdicion(Form<SeguidorDePartido> parent) {
		val checkbox = new CheckBox("ultimasNCalificaciones")
		parent.addChild(checkbox)
		parent.addChild(new CheckBox("handicapBool"))
		parent.addChild(new CheckBox("ultimasCalificaciones"))
		parent.addChild(new FeedbackPanel("f"))
		val texto = new TextField<Integer>("numero")

		if (this.seguidor.ultimasNCalificaciones == false) {
			texto.setVisibilityAllowed(true)
		} //esta parte tenemos que entender como hacerla conAjax y feedbackpanel, o lo que tengamos que usar

		//		texto.setEnabled(checkbox.)
		parent.addChild(texto)
		parent.addChild(new CheckBox("algoritmo1Bool"))
		parent.addChild(new CheckBox("algoritmo2Bool"))

	}

}
