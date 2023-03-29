#!/bin/bash

# Mettre en place le répertoire d'entrée et de sortie
# input à définir
# output à définir
input_dir="input" 
# (D:\images\uploads\2022\test)
output_dir="output"
#  (D:\out)

# Créer le répertoire de sortie si il n'existe pas
mkdir -p "$output_dir"

# Set les dimensions d'image minimum 
minimum_width=600
minimum_height=600

# Convertir les fichiers SVG en image PNG si nécéssaire
magick mogrify -format png -path "$output_dir" "$input_dir"/*.svg

# Loop sur chaque image dans le répertoire d'entrée
for file in "$input_dir"/*.png; do
    # Obtenir les dimensions d'images actuelles
    image_width=$(identify -format "%w" "$file")
    image_height=$(identify -format "%h" "$file")
    
    # Check si l'image doit être resize
    # Si l'image est plus large (greater < ) que la largeur minimum || Si l'image est plus grande (greater < ) que la hauteur minimum, alors :
    if [[ -n "$image_width" && -n "$image_height" && ( "$image_width" -gt "$minimum_width" || "$image_height" -gt "$minimum_height" ) ]]; then
        # Resize l'image
        mogrify -resize "$minimum_width"x"$minimum_height" "$file"
    fi
    
    # Copie le fichier dans le répertoire de sortie
    cp "$file" "$output_dir"
done
