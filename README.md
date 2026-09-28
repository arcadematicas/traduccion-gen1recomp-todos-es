# 🇪🇸 Traducción al español — **todos los juegos** (gen1recomp)

[![Licencia: GPL-3.0](https://img.shields.io/badge/licencia-GPL--3.0-blue.svg)](LICENSE)
[![Última versión](https://img.shields.io/github/v/release/arcadematicas/traduccion-gen1recomp-todos-es?label=versi%C3%B3n&color=brightgreen)](https://github.com/arcadematicas/traduccion-gen1recomp-todos-es/releases)
[![Juegos](https://img.shields.io/badge/juegos-8-red.svg)](#)
[![gen1recomp](https://img.shields.io/badge/gen1recomp-0.3%2B-orange.svg)](https://github.com/bryanthaboi/gen1recomp)

**Un solo mod** de traducción al español para **los 8 juegos** de
[**gen1recomp**](https://github.com/bryanthaboi/gen1recomp):

| Generación | Juegos |
|---|---|
| **Gen 1** | 🔴 Rojo · 🔵 Azul · 🟡 Amarillo |
| **Gen 2** | 🥇 Oro · 🥈 Plata · 🔮 Cristal |
| **Gen 3** | 🔥 FireRed · 🍃 LeafGreen |

> **Versión:** `v1.0.0` · **Motor:** gen1recomp 0.3+

El mod detecta la versión que estás jugando (`GameVersion.get()`) y aplica
automáticamente **solo los catálogos de esa generación**.

## ✨ Qué traduce

| | Gen 1 (RBY) | Gen 2 (GSC) | Gen 3 (FRLG) |
|---|:---:|:---:|:---:|
| 💬 Diálogos | 2 789 | 3 042–3 968 | 11 369 |
| 🖥️ Textos del motor | 2 031 | 1 997 | 1 938 |
| ⚔️ Nombres de movimientos | 165 | 249 | 354 |
| 🎒 Nombres de objetos | 152 | 214 | 307 |
| 📖 Descripciones de objetos | — | 251 (Pokédex) | 306 |
| 🧭 Lugares / mapa | — | 96 | 105 |
| 🏠 Decoraciones / radio | — | 53 / 8 | — |
| 🎬 Intro del Profesor Oak | — | ✓ | ✓ |

Incluye además: categorías de la Pokédex, estados de batalla, entrenadores,
**pantalla de nombres con acentos/ñ/¿¡** (fuente propia en Gen 1) y las
**tablas de texto** de Gen 3 (clases de entrenador, menús, naturalezas…).

## 🚀 Instalación

1. **Descarga** el `.zip` desde [**Releases**](https://github.com/arcadematicas/traduccion-gen1recomp-todos-es/releases).
2. **Extrae** el contenido en:

   ```
   <gen1recomp>/.local/share/pokemon-love2d/mods/translation-es-all/
   ```
3. En el **lanzador de mods**, activa **`translation-es-all`**.
4. ¡A jugar! El mod se ajusta solo a cada juego. 🎮

> ⚠️ Si tenías los mods anteriores (`translation-es`,
> `translation-es-goldilvercrystal`, `translation-es-firered`), **desactívalos**:
> este mod ya los incluye.

### 🔄 Autoactualización

El manifest declara el repositorio, así que el gestor de mods **detecta y ofrece
las actualizaciones** automáticamente.

## ⚠️ Limitaciones conocidas

No son parcheables con la API de mods actual (se leen directamente de los datos):

- Nombres de **habilidades** (Gen 2/3) y descripciones de movimientos/habilidades
- Textos de la **Pokédex** de Gen 3 (`pokedex/entries.lua`)
- **Easy Chat** (Gen 3)
- ~1 100 diálogos de Gen 3 sin correspondencia en el corpus oficial

## 🗂️ Estructura

```
manifest.json   identidad, los 8 juegos y el rango de versión del motor
main.lua        detecta la generación y aplica el catálogo correspondiente
lang/
  gen1/  dialogue, strings, species_names, move_names, item_names, …
  gen2/  gold/silver/crystal_dialogue, rom_text, landmarks, dex_entries, …
  gen3/  dialogue{,_firered,_leafgreen}, strings, move_names, item_names, …
assets/font/    fuente con acentos para Gen 1
```

## 🙏 Créditos

- **Fransis** — traducción y adaptación.
- [**PokeCorpus**](https://github.com/abcboy101/poke-corpus) — textos oficiales.
- [**gen1recomp**](https://github.com/bryanthaboi/gen1recomp) — motor y sistema de mods.

## 📄 Licencia

**GPL-3.0** — las traducciones derivan de PokeCorpus (GPL-3.0). Consulta [LICENSE](LICENSE).

---

<p align="center"><em>Ocho juegos, un solo mod. 🇪🇸</em></p>
