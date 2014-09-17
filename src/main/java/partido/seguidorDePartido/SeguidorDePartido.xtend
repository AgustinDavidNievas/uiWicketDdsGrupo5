package partido.seguidorDePartido

import java.io.Serializable
import organizador.partidos.criterios.Criterios
import java.util.List
import organizador.partidos.jugador.Jugador

class SeguidorDePartido implements Serializable {
	
	@Property List<Criterios> criterios
	@Property List<Jugador> jugadores
}