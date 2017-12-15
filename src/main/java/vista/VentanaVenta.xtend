package vista

import org.uqbar.arena.windows.MainWindow
import modelo.ModeloVenta
import org.uqbar.arena.widgets.Panel
import org.uqbar.arena.layout.VerticalLayout
import org.uqbar.arena.widgets.TextBox
import static extension org.uqbar.arena.xtend.ArenaXtendExtensions.*
import org.uqbar.arena.widgets.Button
import dominio.Producto
import org.uqbar.arena.widgets.tables.Table
import org.uqbar.arena.widgets.tables.Column
import org.uqbar.arena.windows.Dialog
import org.uqbar.arena.widgets.Label
import org.uqbar.arena.widgets.NumericField
import org.uqbar.arena.bindings.NotNullObservable
import org.uqbar.arena.layout.ColumnLayout

class VentanaVenta extends MainWindow<ModeloVenta> {
	
	val elementSelected = new NotNullObservable("productoSeleccionado")
	
	new() {
		super(new ModeloVenta)
	}
	
	override createContents(Panel mainPanel) {
		this.title = "Venta de Productos"
		mainPanel.layout = new VerticalLayout
		
		val Panel panelSuperiorDatos = new Panel(mainPanel).layout = new ColumnLayout(2)
		new Label(panelSuperiorDatos).text= "Nombre " 
		new TextBox(panelSuperiorDatos) => [
			value <=> "nombreProducto"
			width = 200
		]
		new Label(panelSuperiorDatos).text= "Code" 
		new TextBox(panelSuperiorDatos) => [
			value <=> "codeProducto"
			width = 50
		]
		new Label(panelSuperiorDatos).text= "Price" 
		new NumericField(panelSuperiorDatos) => [
			value <=> "precioProducto"
			width = 100
		] 
		new Label(panelSuperiorDatos).text= "IVA"
		new NumericField(panelSuperiorDatos) => [
			value <=> "IVAProducto"
			width = 100
		]
		
		new Button(mainPanel) => [
			caption = "Agregar Producto Nuevo"
			onClick(|this.modelObject.agregarProductoNuevo())
			setAsDefault
			disableOnError
		]
		
		var tablaTareas = new Table<Producto>(mainPanel, typeof(Producto)) => [
			numberVisibleRows = 10
			items <=> "repo"
			value <=> "productoSeleccionado"
		]
		new Column<Producto>(tablaTareas) => [
			fixedSize = 200
			title = "Nombre"
			bindContentsToProperty("description")
		]
		new Column<Producto>(tablaTareas) => [
			fixedSize = 100
			title = "Código"
			bindContentsToProperty("code")
		]
		new Column<Producto>(tablaTareas) => [
			fixedSize = 100
			title = "Precio sin IVA"
			bindContentsToProperty("priceWithoutIVA")
		]
		new Column<Producto>(tablaTareas) => [
			fixedSize = 100
			title = "Precio final"
			bindContentsToProperty("price")
		]
		new Column<Producto>(tablaTareas) => [
			fixedSize = 100
			title = "Agregado"
			bindContentsToProperty("estaAgregado").transformer =
				[ Boolean estaAgregado | 	if (estaAgregado) "SI"	else "NO" ]
		]	
		
		val Panel panelBotonera = new Panel(mainPanel).layout = new ColumnLayout(2)
		new Button(panelBotonera) => [
			caption = "Agregar Al Carro"
			onClick(|this.modelObject.agregarAlCarro())
			bindEnabled(elementSelected)
		]
		val Panel panelPrecio = new Panel(panelBotonera).layout = new ColumnLayout(2)
		new Label(panelPrecio).text= "Precio Total $"
		new Label(panelPrecio) => [
			value <=> "precioTotal"
		] 
	}
	
	def openDialog(Dialog<?> dialog) {
		dialog.open
	}
	
}