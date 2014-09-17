package partido.home

import org.uqbar.commons.model.CollectionBasedHome
import organizador.partidos.jugador.Jugador
import org.apache.commons.collections15.Predicate
import organizador.partidos.jugador.Estandar
import organizador.partidos.jugador.Tipo
import java.util.List
import com.google.common.collect.Lists
import organizador.partidos.jugador.Solidario

class HomeJugadores extends CollectionBasedHome<Jugador> {
	
	List<String> nombres8
	List<Jugador> jugadoresEstandar
	List<Jugador> jugadoresSolidarios

	def void init() {
		nombres8 = newArrayList("Gabriel", "Juan", "Ramon", "PechinioFrio", "Lucas", "Oscar", "Facundo", "Gonzalo")
		jugadoresEstandar = Lists.newArrayList(nombres8.map[nombre|create(nombre, new Estandar, 42)])
		jugadoresSolidarios = Lists.newArrayList(nombres8.map[nombre|create(nombre, new Solidario, 10)])
	}

	def create(String pNombre, Tipo tipo, int edad) {
		var jugador = new Jugador(pNombre, tipo, edad)
		this.create(jugador)
		return jugador
	}

	
	override def Predicate<Jugador> getCriterio(Jugador example) {
		null
	}

	override createExample() {
		new Jugador("Adolf", new Estandar, 20)
	}

	override def getEntityType() {
		typeof(Jugador)
	}

}
