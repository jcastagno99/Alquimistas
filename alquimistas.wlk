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
  	return self.calidadItemsCombate() + self.calidadItemsRecoleccion() / self.cantidadTotalItems()
  }
  
  method calidadItemsCombate() {
  	return itemsDeCombate.sum({unItem => unItem.calidad()}) 
  }
  
  method calidadItemsRecoleccion() {
  	return 30 + self.calidadMaterialesRecoleccion() / 10
  }
  
  method calidadMaterialesRecoleccion(){
  	return itemsDeRecoleccion.sum({unItem => unItem.calidad()})
  }
  
  method cantidadTotalItems(){
  	return itemsDeCombate.size() + itemsDeRecoleccion.size()
  }
  
  
  method todosLosItemsDeCombateSonEfectivos(){
  	return itemsDeCombate.all({unItem => unItem.esEfectivo()})
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
  
}

//--------------------------------------------------------------------------------------------------------------

object debilitador {
  var materiales = []
  var potencia = 0
  var mejor1 = 0
  var mejor2 = 0
  
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
  	return self.calidadMejoresMateriales().sum() / 2 
  }
  
  method calidadMejoresMateriales(){
  	return self.mejoresMateriales().map({unMaterial => unMaterial.calidad()})
  	
  }
  
  method mejoresMateriales(){
  	self.obtenerMejor1()
  	self.obtenerMejor2()
  	return [mejor1, mejor2]
  }
  
  method obtenerMejor1(){
  	mejor1 = materiales.max({unMaterial => unMaterial.calidad()})
  }
  
  method obtenerMejor2(){
  	mejor2 = materiales.borrarMejor1().max({unMaterial => unMaterial.calidad()})
  }

  method  borrarMejor1(){
  	self.obtenerMejor1()
  	materiales.remove(mejor1)
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
 	

object unMaterial {
	var calidad = 10
	
	method esMistico(){
		return false
	}
	
	method calidad(){
		return calidad
	}
} 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 	
 