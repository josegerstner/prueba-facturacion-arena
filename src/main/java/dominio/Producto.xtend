package dominio

import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Observable

@Observable
@Accessors
class Producto {
	int id
	String code
	String description
	double price
	double IVA = 21d
	boolean estaAgregado
	
	new(int _id, String _c, String _d, double _p){
		id = _id
		code = _c
		description = _d
		price = _p
		estaAgregado = false
	}
	new(String _c, String _d, double _p){
		code = _c
		description = _d
		price = _p
	}
	
	def getPrice(){
		price * (1 + (IVA/100))
	}
	
	def getPriceWithoutIVA(){
		price
	}
	
	def setEstaAgregado(){
		this.estaAgregado=!this.estaAgregado
	}	
	override toString(){
		this.description
	}
}