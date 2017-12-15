package repositorio

import dominio.Producto
import java.util.List
import org.eclipse.xtend.lib.annotations.Accessors

@Accessors
class RepoProductos {
	var List<Producto> repo = newArrayList
	static var RepoProductos instance
	
	val Producto teclado = new Producto("tec", "Teclado Genius", 200)
	val Producto mouse = new Producto("mou", "Mouse Ryzer", 500)
	val Producto monitor = new Producto("mon", "Monitor Samsung", 3000)
	
	private new() {
		repo = #[teclado, mouse, monitor]
	}

	public static def getInstance() {
		if (instance === null) {
			instance = new RepoProductos
		}
		return instance
	}
	
	def getProducto(String cod){
		repo.filter[prod | prod.code == cod]
	}
	
}