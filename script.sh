#!/bin/bash

# Mettre en place le répertoire d'entrée et de sortie
# input à définir
# output à définir
input_dir="D:/images/uploads/2022/test"
output_dir="D:/out"

# Créer le répertoire de sortie si il n'existe pas
mkdir -p "$output_dir"

# Set les dimensions d'image minimum 
minimum_width=150
minimum_height=150

# Convertir les fichiers SVG en image PNG si nécéssaire
magick mogrify -format png -path "$output_dir" "$input_dir"/*.svg

# Check si il y a des images PNG dans le répertoire de sortie
if [ -z "$(ls -A "$output_dir"/*.png 2>/dev/null)" ]; then
    echo "No PNG files found in $output_dir"
    exit 1
fi

# Resize PNG files if necessary
for file in "$output_dir"/*.png; do
    # Obtenir les dimensions d'images actuelles
    image_width=$(identify -format "%w" "$file")
    image_height=$(identify -format "%h" "$file")
    

    # Check si l'image doit être resize
    # Si l'image est plus large (greater < ) que la largeur minimum || Si l'image est plus grande (greater < ) que la hauteur minimum, alors :
    if [[ -n "$image_width" && -n "$image_height" && ( "$image_width" -gt "$minimum_width" || "$image_height" -gt "$minimum_height" ) ]]; then
        # Resize l'image
        mogrify -resize "$minimum_width"x"$minimum_height" "$file"
    fi
done
