package partido.seguidorDePartido

import java.io.Serializable
import organizador.partidos.criterios.Criterios
import java.util.List
import organizador.partidos.jugador.Jugador
import partido.home.HomeJugadores
import org.uqbar.commons.utils.ApplicationContext

class SeguidorDePartido implements Serializable {
	
	@Property List<Criterios> criterios
	@Property List<Jugador> jugadores
	
	def HomeJugadores getHomeJugadores() {
		ApplicationContext.instance.getSingleton(typeof(Jugador))

	}
}