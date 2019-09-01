//.....................................................................................................................ALQUIMISTA
object alquimista {
  var itemsDeCombate = []
  var itemsDeRecoleccion = []
  
  //---Punto 1 
  
  method tieneCriterio() {
    return self.cantidadDeItemsDeCombateEfectivos() >= self.cantidadDeItemsDeCombate() / 2
  }
  
  method cantidadDeItemsDeCombate() {
    return itemsDeCombate.size()
  }
  
  method cantidadDeItemsDeCombateEfectivos() {
    return itemsDeCombate.count({ itemDeCombate =>
      itemDeCombate.esEfectivo()
    })
  }
  
  //---Punto 2 
  
  method esBuenExplorador() {
  	return self.cantidadItemsRecoleccion() >= 3
  }
  
  method cantidadItemsRecoleccion() {
  	return itemsDeRecoleccion.size()
  }
  
  //---Punto 3
  
  method capacidadOfensiva() {
  	return  self.capacidadOfensivaDeItemsDeCombate().sum()
  }
  
  method capacidadOfensivaDeItemsDeCombate(){
  	return itemsDeCombate.map({unItem => unItem.capacidadOfensiva()})
  }
  
  //---Punto 4
  
  method esProfesional(){
  	return self.promedioCalidadItems() > 50 and self.todosLosItemsDeCombateSonEfectivos() and self.esBuenExplorador()
  }
  
  method promedioCalidadItems() {
  	if (self.cantidadTotalItems() != 0) return self.calidadItemsCombate() + self.calidadItemsRecoleccion() / self.cantidadTotalItems()
  	return 0
  }
  
  method calidadItemsCombate() {
  	if (itemsDeCombate.size() != 0) return itemsDeCombate.sum({unItem => unItem.calidad()}) 
  	return 0
  }
  
  method calidadItemsRecoleccion() {
  	if (itemsDeRecoleccion.size() != 0) return 30 + self.calidadMaterialesRecoleccion() / 10
  	return 0
  }
  
  method calidadMaterialesRecoleccion(){
    if (itemsDeRecoleccion.size() != 0)	return itemsDeRecoleccion.sum({unItem => unItem.calidad()})
    return 0
  } 
  
  method cantidadTotalItems(){
  	return itemsDeCombate.size() + itemsDeRecoleccion.size()
  }
  
  
  method todosLosItemsDeCombateSonEfectivos(){
  	return itemsDeCombate.all({unItem => unItem.esEfectivo()})
  }
  
//--- Metodos para el testing

  method agregarItemDeCombate(unItem){
  	itemsDeCombate.add(unItem)
  	
  }  
  
    method agregarItemDeRecoleccion(unItem){
  	itemsDeRecoleccion.add(unItem)
  	
  }  
}

//--------------------------------------------------------------------------------------------------------------

object bomba {
  var danio = 15
  var materiales = []
  
  method esEfectivo() {
    return danio > 100
  }
  
  method capacidadOfensiva(){
  	return danio/2
  }
  
  method calidad() {
  	return materiales.min({unMaterial => unMaterial.calidad()}).calidad()
  }
  
//--- Metodos para el testing

  method cambiarDanio(unDanio){
	danio = unDanio
  }
  
  method agregarMaterial(unMaterial){
  	materiales.add(unMaterial)
  }  
   
}

//--------------------------------------------------------------------------------------------------------------

object pocion {
  var materiales = []
  var poderCurativo = 0
  
  method esEfectivo() {
    return poderCurativo > 50 and self.fueCreadoPorAlgunMaterialMistico()
  }
  
  method fueCreadoPorAlgunMaterialMistico() {
    return materiales.any({ unMaterial => unMaterial.esMistico()})
  }
  
  method capacidadOfensiva() {
  	return poderCurativo + 10*self.cantidadDeMaterialesMisticos()
  }
  
  method cantidadDeMaterialesMisticos() {
  	return materiales.count({unMaterial => unMaterial.esMistico()})
  }
  
  method calidad() {
  	return materiales.findOrElse({unMaterial=>unMaterial.esMistico()}, {materiales.head()}).calidad() 
  }  
  
//--- Metodos para el testing

  method cambiarPoderCurativo(poder){
  	poderCurativo = poder
  }  
  
  method agregarMaterial(unMaterial){
  	materiales.add(unMaterial)
  }
  
  
}

//--------------------------------------------------------------------------------------------------------------

object debilitador {
  var materiales = []
  var potencia = 0
  var mejor1 = 0
  var mejor2 = 0
  var listaDeCalidades
  
  method esEfectivo() {
    return potencia > 0 and self.fueCreadoPorAlgunMaterialMistico().negate()
  }
  
   method fueCreadoPorAlgunMaterialMistico() {
    return materiales.any({unMaterial => unMaterial.esMistico()})
  }
  
  
  method capacidadOfensiva(){
  	if (self.fueCreadoPorAlgunMaterialMistico()){
  		return 12*self.cantidadMateriales()
  	}
  	return 5
  }
  
  method cantidadMateriales(){
  	return materiales.size()
  }
  
    method cantidadDeMaterialesMisticos(){
  	return materiales.count({unMaterial => unMaterial.esMistico()})
  }
  
  
  method calidad(){
  	return self.mejoresMateriales().sum() / 2 
   }
 
  method mejoresMateriales(){
  	self.obtenerMejor1()
  	self.obtenerMejor2()
  	return [mejor1, mejor2]
  }
  
  method obtenerMejor1(){
  	listaDeCalidades = self.calidadMateriales()
  	if (listaDeCalidades.size() != 0) mejor1 = listaDeCalidades.max()
  	else mejor1 = 0
  }
  
  method obtenerMejor2(){
  	self.borrarMejor1()
    if (listaDeCalidades.size() != 0) mejor2 = listaDeCalidades.max()
    else mejor2 = 0
  }

  method  borrarMejor1(){
  	self.obtenerMejor1()
  	listaDeCalidades.remove(mejor1)
  }
  
  method calidadMateriales(){
  	return materiales.map({unMaterial => unMaterial.calidad()})
  }
  
 //--- Metodos para el testing
 
   method agregarMaterial(unMaterial){
  	materiales.add(unMaterial)
  }
  
 }
 
 //--------------------------------------------------------------------------------------------------------------
 

object unMaterialMistico {
	var calidad = 20
	
	method esMistico(){
		return true
	}
	
	method calidad(){
		return calidad
	}
}

 	
object otroMaterialMistico {
	var calidad = 30
	
	method esMistico(){
		return true
	}
	
	method calidad(){
		return calidad
	}
}


object unMaterial {
	var calidad = 10
	
	method esMistico(){
		return false
	}
	
	method calidad(){
		return calidad
	}
} 	
 	
 	
object otroMaterial{
	var calidad = 5
	
	method esMistico(){
		return false
	}
	
	method calidad(){
		return calidad
	}
} 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 