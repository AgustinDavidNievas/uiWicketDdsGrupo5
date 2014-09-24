package uiWicketDdsGrupo5

import org.apache.wicket.protocol.http.WebApplication
import org.uqbar.commons.utils.ApplicationContext
import organizador.partidos.jugador.Jugador
import partido.vista.SeguidorDePartidoPage
import organizador.home.HomeDeJugadores

/**
 * Application object for your web application. If you want to run this application without deploying, run the Start class.
 * 
 * @see uiWicketDdsGrupo5.Start#main(String[])
 */
class WicketApplication extends WebApplication {
	
	override getHomePage() {
		return SeguidorDePartidoPage
	}
	
	override init() {
		super.init()
		ApplicationContext.instance.configureSingleton(Jugador, new HomeDeJugadores)
	}
	
}