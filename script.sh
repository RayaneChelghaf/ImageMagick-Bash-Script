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



























# .svg -> png -> même nom de fichier png (alpha) :
# -alpha
# mogrify png *.svg


# magick mogrify -format png -path "d:\out" *.svg




# .6000 -> 4000 ////// -> 600 -> 400 : 

# mogrify -resize 600x400 *.png

# mogrify '*.png[!150x150<]'
# mogrify '*.png[!150x150>]'




# convert et spécifier répertoire de destination :

# #!/bin/bash
# files=*.png
# minimumWidth=150
# minimumHeight=150
# for f in $files
# do
#     imageWidth=$(identify -format "%w" "$f")
#     imageHeight=$(identify -format "%h" "$f")
#     if [ "$imageWidth" -gt "$minimumWidth" ] || [ "$imageHeight" -gt "$minimumHeight" ]; then
#         mogrify -resize ''"$minimumWidth"x"$minimumHeight"'' $f
#     fi
# done






# #!/bin/bash

# # Mettre en place le répertoire d'entrée et de sortie
# input_dir="input" (D:\images\uploads\2022\test)
# output_dir="output" (D:\out)

# # Créer le répertoire de sortie si il n'existe pas
# mkdir -p "$output_dir"

# # Set the minimum image dimensions
# minimum_width=150
# minimum_height=150

# # Convertir les fichiers SVG en image PNG si nécéssaire
# magick mogrify -format png -path "$output_dir" "$input_dir"/*.svg

# # Loop through each image file in the input directory
# for file in "$input_dir"/*.png; do
#     # Get the current image dimensions
#     image_width=$(identify -format "%w" "$file")
#     image_height=$(identify -format "%h" "$file")
    
#     # Check si l'image doit être resize
#     if [ "$image_width" -gt "$minimum_width" ] || [ "$image_height" -gt "$minimum_height" ]; then
#         # Resize l'image
#         mogrify -resize "$minimum_width"x"$minimum_height" "$file"
#     fi
    
#     # Copy le fichier dans le répertoire de sortie
#     cp "$file" "$output_dir"
# done











