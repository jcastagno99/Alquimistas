object alquimista {
  var itemsDeCombate = []
  var itemsDeRecoleccion = []
  
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
  
  method esBuenExplorador() {
  	return self.tieneAlMenos3ItemsDeRecoleccion()
  }
  
  method tieneAlMenos3ItemsDeRecoleccion() {
  	return itemsDeRecoleccion.size()
  }
  
  method capacidadOfensiva() {
  	return  itemsDeCombate.map({unItem => unItem.capacidadOfensiva()}).sum()
  }
}

object bomba {
  var danio = 15
  
  method capacidadOfensiva(){
  	return danio/2
  }
  
  method esEfectivo() {
    return danio > 100
  }
}

object pocion {
  var materiales = []
  var poderCurativo = 0
  
  method capacidadOfensiva(){
  	return poderCurativo + 10*self.cantidadDeMaterialesMisticos()
  }
  
  method cantidadDeMaterialesMisticos(){
  	return materiales.count({unMaterial => unMaterial.esMistico(unMaterial)})
  }
  
  method esMistico(unMaterial){
  	return ["flor roja", "uni"].contains(unMaterial) // el ejercicio no especifica ningun criterio, asi que tomo a "flor roja" y "uni" como los unicos materiales misticos
  }
  
  method esEfectivo() {
    return poderCurativo > 50 and self.fueCreadoPorAlgunMaterialMistico()
  }
  
  method fueCreadoPorAlgunMaterialMistico() {
    return materiales.any({ unMaterial =>
      unMaterial.esMistico(unMaterial)
    })
  }
}

object debilitador {
  var materiales = []
  var potencia = 0
  
  method esEfectivo() {
    return potencia > 0 and self.fueCreadoPorAlgunMaterialMistico().negate()
  }
  
  method capacidadOfensiva(){
  	if (self.fueCreadoPorAlgunMaterialMistico()){
  	 return 12*self.cantidadDeMaterialesMisticos()
  	}
  	return 5
  }
  
  method cantidadDeMaterialesMisticos(){
  	return materiales.count({unMaterial => unMaterial.esMistico(unMaterial)})
  }
  
  method fueCreadoPorAlgunMaterialMistico() {
    return materiales.any({ unMaterial =>
      unMaterial.esMistico(unMaterial)
    })
  }

  method esMistico(unMaterial){
  	return ["flor roja", "uni"].contains(unMaterial) // el ejercicio no especifica ningun criterio, asi que tomo a "flor roja" y "uni" como los unicos materiales misticos
  }
  

}