#!/bin/bash

# Mettre en place le répertoire d'entrée et de sortie
input_dir="D:/images/uploads/2022/test"
output_dir="D:/out"

# Créer le répertoire de sortie s'il n'existe pas
mkdir -p "$output_dir"

# Set les dimensions d'image minimum 
minimum_width=150
minimum_height=150


# Convertir tout les fichiers dans le répertoire d'entrée en image PNG
for file in "$input_dir"/*; do
    # Obtenir le type d'extension du fichier
    extension="${file##*.}"
    
    # Convertir le fichier en image PNG si c'est un SVG
    if [[ "$extension" == "svg" ]]; then
        # Convertir le fichier SVG en image PNG
        convert -define png:format=png24 -strip "$file" -set filename: "%t" +adjoin "$output_dir/$(basename "$file" .$extension).png"
    elif [[ "$extension" != "png" ]]; then
        # Copier les fichiers dans le répertoire de sortie en conservant leur extension d'origine
        cp "$file" "$output_dir/$(basename "$file" .$extension).$extension"
    else
        # Si le fichier est déjà en PNG, copier le fichier sans le modifier
        cp "$file" "$output_dir/$(basename "$file")"
    fi
done

# Vérifier s'il y a des images PNG dans le répertoire de sortie :
# Si la chaîne est vide, la substitution de commande "$(ls -A "$output_dir"/*.png" exécute la commande ls pour lister tous les fichiers PNG dans le répertoire de sortie.
# -A affiche tous les fichiers, y compris les fichiers cachés.
# 2>/dev/null est utilisé pour rediriger la sortie d'erreur vers /dev/null, ce qui supprime les messages d'erreur.
if [ -z "$(ls -A "$output_dir"/*.png 2>/dev/null)" ]; then
    echo "No PNG files found in $output_dir"
    exit 1
fi

# Resize les images PNG si nécessaire
for file in "$output_dir"/*.png; do
    # Obtenir les dimensions d'images actuelles
    image_width=$(identify -format "%w" "$file")
    image_height=$(identify -format "%h" "$file")
    
    # Check si l'image doit être resize :
    # Si l'image est plus large (greater < ) que la largeur minimum || Si l'image est plus grande (greater < ) que la hauteur minimum, alors :
    if [[ -n "$image_width" && -n "$image_height" && ( "$image_width" -gt "$minimum_width" || "$image_height" -gt "$minimum_height" ) ]]; then
        # Resize l'image
        mogrify -resize "$minimum_width"x"$minimum_height" "$file"
    fi
done
