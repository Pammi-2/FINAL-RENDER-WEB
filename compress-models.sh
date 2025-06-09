#!/bin/bash
mkdir -p static/models_compressed

# Recorre todas las subcarpetas dentro de static/models
for folder in static/models/*/
do
  folder_name=$(basename "$folder")
  mkdir -p static/models_compressed/"$folder_name"

  # Procesa todos los archivos .glb dentro de cada subcarpeta, si existen
  found_glb=false
  for file in "$folder"/*.glb
  do
    if [ ! -e "$file" ]; then
      break
    fi
    found_glb=true
    filename=$(basename "$file" .glb)
    npx gltf-pipeline -i "$file" -o "static/models_compressed/${folder_name}/${filename}_draco.glb" -d
  done

  if [ "$found_glb" = false ]; then
    echo "No .glb files found in $folder, skipping..."
  fi
done









