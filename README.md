La technologie utilisée est le framework flutter en language dart sur l'edteur de code Android Studio
L'application comporte deux pages gérer à l'aide d'une BottomNavigationBar:
La première page devait initialement contenir des statistiques sur les regions et/ou les départements (manque de temps)
La deuxième page contient une carte avec la possibillité d'afficher soit, des points pour les region, soit pour les départements.
A l'origine mon intention était d'augmenté la taille de ces ronds en fonction du nombre de faits et d'indiqué en-dessous le nombre de faits.

Trois API on été utilisé afin de produire cette application:

https://data.opendatasoft.com/api/explore/v2.1/catalog/datasets/contours-geographiques-tres-simplifies-des-departements-2019@public/records?select=geo_point_2d%2C%20nom_dep%2C%20insee_dep&order_by=nom_dep&limit=100
Celle-ci contient les lattitudes et longitudes des préfectures des départements

https://data.opendatasoft.com/api/explore/v2.1/catalog/datasets/regions-et-collectivites-doutre-mer-france@toursmetropole/records?select=geo_point_2d%2C%20reg_code%2C%20reg_name%20&limit=20
Celle-ci contient les lattitudes et longitudes des chef-lieu de chaque régions

https://tabular-api.data.gouv.fr/api/resources/acc332f6-92be-42af-9721-f3609bea8cfc/data/
Et enfin celle-ci contient toutes les informations utiles pour réaliser les statistiques.

Afin de réalisé ce projet "Claude.ai" a été utilisé pour m'aider dans la conception de cette application

Voici le lien de la vidéo présentative:
https://youtube.com/shorts/YMksKmYLunQ?si=qyGDcK_ersMqfBSE
