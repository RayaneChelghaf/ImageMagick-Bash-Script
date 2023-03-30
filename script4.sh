#!/bin/bash

# Mettre en place le répertoire d'entrée et de sortie
input_dir="D:/images/uploads/2022/test"
output_dir="D:/out"

# Créer le répertoire de sortie si il n'existe pas
mkdir -p "$output_dir"

# Set les dimensions d'image minimum 
minimum_width=150
minimum_height=150


# Convertir tout les fichiers dans le répertoire d'entrée en image PNG
for file in "$input_dir"/*; do
    # Obtenir le type d'extention du fichier
    extension="${file##*.}"
    
    # Convertir le fichier en image PNG si ce n'en est pas déjà un
    if [[ "$extension" == "svg" ]]; then
        convert "$file" "$output_dir/$(basename "$file" ".$extension").png"
       
                # Si on veut spécifier le format et garder l'extention :


                    # convertir le fichier d'entrée au format PNG et conserver l'extension originale dans le nom de fichier de sortie.
                    # Le spécificateur de format %d sera remplacé par un identifiant unique pour chaque fichier de sortie afin d'éviter l'écrasement de fichiers existants.


                    # convert -format png "$file" "$output_dir/$(basename "$file" ".$extension")_%d.$extension"
                    # (garder cette commande dans cet ordre transforme tout les fichiers en svg)

                    # Si on souhaite écraser les fichiers existants, on pouvez utiliser l'option -f (force) de la commande convert.
                    # Cela permettra à convert d'écraser les fichiers existants sans demander de confirmation. :


                    # convert -force "$file" "$output_dir/$(basename "$file" .$extension).png" 
                    # (force et f ne sont pas compatible)


    elif [[ "$extension" != "png" ]]; then
        cp "$file" "$output_dir"
    fi
done
# Check si il y a des images PNG dans le répertoire de sortie :
# Si la chaîne est vide, la substitution de commande "$(ls -A "$output_dir"/*.png" exécute la commande ls pour lister tous les fichiers PNG dans le répertoire de sortie.
# -A affiche tous les fichiers, y compris les fichiers cachés.
# 2>/dev/null est utilisé pour rediriger la sortie d'erreur vers /dev/null, ce qui supprime les messages d'erreur.
   if [ -z "$(ls -A "$output_dir"/*.png 2>/dev/null)" ]; then
    echo "No PNG files found in $output_dir"
    exit 1
fi

# Resize les images PNG si nécéssaire
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
