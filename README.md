# Memoria TFM EBIS / EUNEIZ en LaTeX

Proyecto LaTeX estructurado para reproducir la maqueta del PDF original.

## Compilación recomendada

```bash
latexmk -xelatex main.tex
```

El PDF se genera en `build/main.pdf`.

También puede compilarse manualmente:

```bash
xelatex -output-directory=build main.tex
xelatex -output-directory=build main.tex
xelatex -output-directory=build main.tex
```

## Estructura

- `ebis-tfm.cls`: clase con tipografía, márgenes, cabeceras, títulos e índices.
- `config/metadata.tex`: metadatos editables del TFM.
- `frontmatter/`: portadas, autoría, resumen, agradecimientos e índices.
- `chapters/`: un archivo por capítulo.
- `backmatter/`: bibliografía y anexos.
- `assets/`: logotipos extraídos del documento de referencia.
- `references.bib`: base bibliográfica preparada para futuras ampliaciones.

## Tipografía

Se usa **Carlito**, sustituto métricamente compatible con Calibri, para preservar saltos de línea y proporciones sin redistribuir fuentes propietarias.

## Notas de mantenimiento

Los capítulos, secciones y marcadores PDF se generan mediante comandos semánticos. Los saltos de página explícitos se conservan porque forman parte de la maqueta del documento recibido.
