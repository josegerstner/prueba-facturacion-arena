package validador

import dominio.Producto
import java.util.List

class ValidarProducto {
	static var ValidarProducto instance
	
	private new(){}
	
	public static def getInstance() {
		if (instance === null) {
			instance = new ValidarProducto
		}
		return instance
	}
	
	def validarStock(List<Producto> lista, Producto producto){
		if(!lista.contains(producto)){
			throw new UserException("Pruducto inválido")
		}
	}
}