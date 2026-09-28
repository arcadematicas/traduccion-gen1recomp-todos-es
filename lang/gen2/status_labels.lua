-- Etiquetas de estado de batalla (HUD) - Gold/Crystal
-- IDs del sistema Gen 2: sleep, poison, toxic, paralyze, burn, freeze, confuse
-- Formato plano: id -> label (string, como espera la API: patch(id, { label = value }))
return {
  ["sleep"] = "DOR",
  ["poison"] = "ENV",
  ["toxic"] = "ENV",
  ["paralyze"] = "PAR",
  ["burn"] = "QUE",
  ["freeze"] = "CON",
  ["confuse"] = "CONF",
}
