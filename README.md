# ImageMagick-Bash-Script
# # ImageMagick script to automate resize and file conversion 

Ce script prend un répertoire d'entrée contenant des fichiers SVG et des images avec d'autres extensions. Il crée un répertoire de sortie s'il n'existe pas et convertit tous les fichiers SVG en images PNG tout en conservant l'extension d'origine. Si un fichier d'entrée est déjà au format PNG, il le copie simplement dans le répertoire de sortie. Si un fichier avec une autre extension est présent, il le copie également tel quel dans le répertoire de sortie.

Si des fichiers PNG sont créés, le script vérifie si au moins un fichier PNG existe dans le répertoire de sortie. Si tel n'est pas le cas, il quitte le script. Si des fichiers PNG existent dans le répertoire de sortie, le script redimensionne les images PNG qui ont une largeur ou une hauteur supérieure à 150 pixels en utilisant la commande "mogrify".