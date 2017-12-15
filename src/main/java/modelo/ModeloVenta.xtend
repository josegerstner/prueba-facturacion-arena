package modelo

import dominio.Producto
import java.util.List
import repositorio.RepoProductos
import org.uqbar.commons.model.annotations.Observable
import org.eclipse.xtend.lib.annotations.Accessors
import org.uqbar.commons.model.annotations.Dependencies

@Observable
@Accessors
class ModeloVenta {
	var String codeProducto
	var String nombreProducto
	var double precioProducto=0d
	var double IVAProducto=0d
	var int flag=0
	var List<Producto> repo = newArrayList
	var Producto productoSeleccionado
	
	new(){
		RepoProductos.instance.repo.forEach[producto | repo.add(producto)]
	}
	
	def getProductoNuevo(){
		new Producto(codeProducto, nombreProducto, precioProducto)
	}
	
	def agregarAlCarro(){
		productoSeleccionado.setEstaAgregado
		sumarFlag
	}
	def agregarProductoNuevo(){
		if(codeProducto!==null && codeProducto!=="" && nombreProducto!==null && nombreProducto!==""){
			repo.add(this.getProductoNuevo())
			codeProducto=""
			nombreProducto=""
			precioProducto=0d
			IVAProducto=0d
			sumarFlag
		}
	}
	
	@Dependencies("flag")
	def double getPrecioTotal(){
		repo.filter[producto | producto.estaAgregado].fold(0d, [ acum, producto | acum + producto.price ])
	}
	
	@Dependencies("flag")
	def getRepo(){
		repo
	}
	
	def sumarFlag(){
		flag++
	}
}