-- translation-es-all: traducción al español de TODOS los juegos de gen1recomp.
--
-- Un solo mod para: Rojo/Azul/Amarillo (Gen 1), Oro/Plata/Cristal (Gen 2) y
-- FireRed/LeafGreen (Gen 3).  Los catálogos viven bajo lang/gen1, lang/gen2 y
-- lang/gen3; este main.lua detecta la versión con GameVersion.get() y aplica
-- SOLO los suyos (los catálogos difieren por generación: p. ej. los nombres de
-- movimientos/objetos son la localización oficial de cada generación, y algunas
-- claves de diálogo colisionan entre Gen 1 y Gen 2 con textos distintos).
--
-- El motor descarta sin error los registros que no existen en la generación en
-- curso, pero ramificamos igualmente para no gastar tiempo ni arriesgar choques.
return function(mod)
  local function catalog(rel)
    local path = "lang/" .. rel .. ".lua"
    local body = mod:read(path)
    if not body then return {} end
    local chunk, err = loadstring(body, path)
    if not chunk then
      mod.log:warn("%s has a syntax error: %s", path, tostring(err))
      return {}
    end
    local ok, table_ = pcall(chunk)
    if not ok or type(table_) ~= "table" then
      mod.log:warn("%s did not return a table: %s", path, tostring(table_))
      return {}
    end
    return table_
  end

  local counts = {}
  local function bump(key) counts[key] = (counts[key] or 0) + 1 end

  local function each(rel, apply)
    local n = 0
    for key, value in pairs(catalog(rel)) do
      if type(value) == "string" and value ~= "" then
        apply(key, value); n = n + 1
      end
    end
    return n
  end

  -- ---- versión / generación -----------------------------------------
  local vid = "red"
  local okV, GameVersion = pcall(require, "src.core.GameVersion")
  if okV and GameVersion and GameVersion.get then vid = GameVersion.get() or vid end
  local gen = 1
  if vid == "gold" or vid == "silver" or vid == "crystal" then gen = 2
  elseif vid == "firered" or vid == "leafgreen" then gen = 3 end

  local function namingHook(rel)
    local grid = catalog(rel)
    if grid.upper then
      mod.hooks:wrap("ui.naming.grid", function(next, base, ctx)
        local want = ctx.lower and grid.lower or grid.upper
        return want or base
      end)
    end
  end

  ------------------------------------------------------------------
  if gen == 1 then
    -- pantalla de nombres con acentos (Gen 1 necesita fuente propia)
    for id, page in pairs(catalog("gen1/font")) do
      if type(page) == "table" and type(page.image) == "string"
          and mod:read(page.image) then
        page.image = mod.assets:path(page.image)
      end
      mod.content.font:register(id, page)
    end
    for seq, code in pairs(catalog("gen1/charmap")) do
      mod.content.font:register("charmap:" .. seq, { seq = seq, code = code })
    end
    namingHook("gen1/naming")

    each("gen1/dialogue", function(id, v) mod.content.text:override(id, v); bump("dialogue") end)
    each("gen1/strings", function(s, v) mod.content.strings:override(s, v); bump("strings") end)
    each("gen1/species_names", function(id, v) mod.content.pokemon:patch(id, { name = v }); bump("species") end)
    each("gen1/move_names", function(id, v) mod.content.moves:patch(id, { name = v }); bump("moves") end)
    each("gen1/item_names", function(id, v) mod.content.items:patch(id, { name = v }); bump("items") end)
    each("gen1/trainer_names", function(id, v) mod.content.trainers:patch(id, { name = v }); bump("trainers") end)
    each("gen1/status_labels", function(id, v) mod.content.statuses:patch(id, { label = v }); bump("statuses") end)
    each("gen1/dex_kinds", function(id, v) mod.content.pokemon:patch(id, { dexEntry = { kind = v } }); bump("dexkinds") end)

    -- Nombres de lugar en los DATOS (data.field.townMap.locations): los usan el
    -- TownMap del motor (via Strings) y, sobre todo, el banner de ubicación del
    -- mod quality_of_life, que lee el dato directamente y NO pasa por Strings.
    for mapId, loc in pairs(catalog("gen1/locations")) do
      if type(loc) == "table" and type(loc.name) == "string" then
        mod.content.field:patch("townMap", { locations = { [mapId] = loc } })
        bump("places")
      end
    end

    local body = mod:read("lang/gen1/literal_handlers.lua")
    if body then
      local chunk, err = loadstring(body, "lang/gen1/literal_handlers.lua")
      if not chunk then error(err) end
      local setup = chunk()
      if type(setup) == "function" then setup(mod) end
    end

  ------------------------------------------------------------------
  elseif gen == 2 then
    namingHook("gen2/naming")

    each("gen2/strings", function(s, v) mod.content.strings:override(s, v); bump("strings") end)
    each("gen2/rom_text", function(label, v) mod.content.rom_text:override(label, v); bump("romtext") end)
    each("gen2/species_names", function(id, v) mod.content.pokemon:patch(id, { name = v }); bump("species") end)
    each("gen2/dex_kinds", function(id, v) mod.content.pokemon:patch(id, { dexEntry = { kind = v } }); bump("dexkinds") end)
    for id, entry in pairs(catalog("gen2/dex_entries")) do
      if type(entry) == "table" and type(entry.text) == "string" then
        local patch = { dexEntry = { text = entry.text } }
        if type(entry.text2) == "string" then patch.dexEntry.text2 = entry.text2 end
        mod.content.pokemon:patch(id, patch); bump("dexentries")
      end
    end
    each("gen2/item_names", function(id, v) mod.content.items:patch(id, { name = v }); bump("items") end)
    each("gen2/move_names", function(id, v) mod.content.moves:patch(id, { name = v }); bump("moves") end)
    each("gen2/trainer_names", function(id, v) mod.content.trainers:patch(id, { name = v }); bump("trainers") end)
    each("gen2/status_labels", function(id, v) mod.content.statuses:patch(id, { label = v }); bump("statuses") end)
    each("gen2/radio_channels", function(id, v) mod.content.radio_channels:patch(id, { name = v }); bump("radio") end)
    each("gen2/landmarks", function(id, v) mod.content.landmarks:patch(id, { name = v }); bump("landmarks") end)
    each("gen2/decorations", function(id, v) mod.content.decorations:patch(id, { name = v }); bump("decorations") end)

    local layer = "gold_dialogue"
    if vid == "crystal" then layer = "crystal_dialogue"
    elseif vid == "silver" then layer = "silver_dialogue" end
    each("gen2/" .. layer, function(id, v) mod.content.text:override(id, v); bump("dialogue") end)

    local OAK_TEXTS = {
      _OakText1 = "¡Hola! ¡Perdona\npor la espera!\012¡Bienvenido\nal mundo de\011los POKéMON!\012Me llamo OAK.\012Pero me llaman\nPROFESOR POKéMON.",
      _OakText2 = "Este mundo está\nhabitado por unas\012criaturas llamadas\nPOKéMON.",
      _OakText4 = "La gente y los\nPOKéMON conviven\012ayudándose unos\na otros.\012Algunos juegan con\nlos POKéMON, otros\011luchan con ellos.",
      _OakText5 = "Pero aún hay\nmuchas cosas que\011no sabemos.\012Quedan muchos\nmisterios por\011resolver. Por eso\012estudio a diario\na los POKéMON.",
      _OakText6 = "¿Cómo has dicho\nque te llamas?",
      _OakText7 = "{PLAYER},\n¿estás preparado?\012Tu propia historia\nPOKéMON está a\011punto de empezar.\012Te divertirás y\nte enfrentarás a\011duros desafíos.\012¡Te espera un\nmundo de sueños y\012aventuras con\nPOKéMON! ¡Vamos!\012¡Nos vemos!",
    }
    mod.events:on("intro.oak_speech.started", function(payload)
      local speech = payload and payload.speech
      if speech and speech.texts then
        for k, v in pairs(OAK_TEXTS) do speech.texts[k] = v end
      end
    end)

  ------------------------------------------------------------------
  else -- Gen 3 (FireRed / LeafGreen)
    each("gen3/strings", function(s, v) mod.content.strings:override(s, v); bump("strings") end)

    local layer = (vid == "leafgreen") and "dialogue_leafgreen" or "dialogue_firered"
    each("gen3/dialogue", function(id, v) mod.content.text:override(id, v); bump("dialogue") end)
    each("gen3/" .. layer, function(id, v) mod.content.text:override(id, v); bump("dialogue") end)

    each("gen3/move_names", function(id, v) mod.content.moves:patch(id, { name = v }); bump("moves") end)

    local item_names = catalog("gen3/item_names")
    local item_descs = catalog("gen3/item_descriptions")
    local item_ids = {}
    for id in pairs(item_names) do item_ids[id] = true end
    for id in pairs(item_descs) do item_ids[id] = true end
    for id in pairs(item_ids) do
      local patch = {}
      if type(item_names[id]) == "string" then patch.name = item_names[id] end
      if type(item_descs[id]) == "string" then patch.description = item_descs[id] end
      if patch.name or patch.description then
        mod.content.items:patch(id, patch); bump("items")
        if patch.description then bump("itemdesc") end
      end
    end
  end

  mod.events:on("game.ready", function()
    local total = 0
    for _, n in pairs(counts) do total = total + n end
    mod.log:info("Spanish all-games v1.0.0 [%s gen%d]: %d cadenas", vid, gen, total)
  end)
end
