package partido.vista

import org.apache.wicket.markup.html.WebPage
import org.uqbar.wicket.xtend.WicketExtensionFactoryMethods
import organizador.partidos.partido.Partido

class BusquedaDeJugadoresPage extends WebPage{
	
	extension WicketExtensionFactoryMethods = new WicketExtensionFactoryMethods
	
	new(Partido partido){
		
	}
	
}