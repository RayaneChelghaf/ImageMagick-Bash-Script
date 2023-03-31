# ImageMagick-Bash-Script
## ImageMagick script to automate resize and file conversion 

Ce script shell Bash a pour but de convertir des images SVG en images PNG dans un répertoire d'entrée spécifique, tout en conservant l'extension d'origine pour les fichiers autres que les SVG.

Il commence par définir les répertoires d'entrée et de sortie. Si le répertoire de sortie n'existe pas, il le crée à l'aide de la commande mkdir.

Ensuite, le script parcourt chaque fichier dans le répertoire d'entrée à l'aide d'une boucle for.

Pour chaque fichier, il récupère son extension à l'aide de la commande ${file##*.}.

Si l'extension est "svg", il utilise la commande convert d'ImageMagick pour convertir le fichier en PNG en utilisant les options -define, -strip, -set et +adjoin, qui permettent de définir le format PNG, de supprimer les informations de profil et de texte, de définir le nom de fichier de sortie sur le nom de fichier d'entrée sans l'extension, de créer plusieurs fichiers de sortie si nécessaire et d'ajouter l'extension .png au nom de fichier de sortie.

Si l'extension est différente de "svg", le script utilise la commande cp pour copier le fichier dans le répertoire de sortie, en conservant l'extension d'origine.

Après avoir terminé la conversion de tous les fichiers, le script vérifie s'il y a des fichiers PNG dans le répertoire de sortie à l'aide de la commande ls.

Si aucun fichier PNG n'est trouvé, le script affiche un message d'erreur et se termine avec le code d'erreur 1.

Enfin, le script parcourt tous les fichiers PNG dans le répertoire de sortie et vérifie si leur taille est inférieure à une taille minimale spécifiée. Si la taille est inférieure à la taille minimale, il utilise la commande mogrify pour redimensionner l'image en utilisant les dimensions minimales spécifiées. L'argument de taille minimale spécifié est évidemment modifiable, et on peut éventuellement définir une taille maximale.