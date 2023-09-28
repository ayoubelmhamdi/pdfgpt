# Université Moulay Ismail
## Faculté des Sciences
### Mémoire du Projet de Fin d’Etudes

Ce mémoire a été réalisé par Abdelmajid ES-SAADI dans le cadre de l'obtention du diplôme de Master Spécialisé en Techniques de Rayonnements en Physique Médicale (TRPM). Le projet porte sur les différentes applications en oncologie des méthodes de simulation par Monte Carlo.

Le mémoire a été soutenu le 23 septembre 2028 devant un jury composé des professeurs Ismail ESSAOUDI, Zouhir EL AMRAOUIL, Rajae SBIHI et Mohammed KHALIS.

Remerciements:
- Nous remercions DIEU pour nous avoir donné la force et la volonté de réaliser ce travail.
- Nous remercions l'organisme de la faculté des sciences de Meknès pour nous avoir offert cette formation.
- Nous remercions particulièrement notre encadrant, le Pr. Mohammed Khalis, pour son aide, sa patience et ses conseils pertinents.
- Nous remercions également l'équipe de recherche de l'Agence d'Energie Atomique Japonaise pour nous avoir fourni la licence du code PHITS.
- Nous remercions nos enseignants au Master en Techniques de Rayonnement en Physique Médicale de la faculté des sciences de Meknès pour leur contribution à notre formation.
- Nous remercions nos collègues et nos familles pour leur soutien moral.

Table des matières:
- Introduction générale
- Chapitre 1: Notions physiques en oncologie
- Chapitre 2: Généralités sur la méthode de Monte Carlo
- Chapitre 3: Codes de simulations par Monte Carlo
- Chapitre 4: Simulation de transport des particules par Monte Carlo
- Chapitre 5: Simulation par le code PHITS
- Chapitre 6: Résultats et discussions
- Conclusion générale
- Références

Dans le chapitre 1, nous abordons les notions physiques en oncologie, notamment la radiothérapie et la hadronthérapie. Nous expliquons les différentes interactions des photons et des ions avec la matière.

Le chapitre 2 présente les généralités sur la méthode de Monte Carlo, y compris les générateurs de nombres aléatoires et les méthodes d'échantillonnage.

Le chapitre 3 traite des codes de simulations par Monte Carlo, tels que Penelope, EGS, MCNP, PHITS et GEANT4.

Le chapitre 4 se concentre sur la simulation de transport des particules par Monte Carlo, en expliquant la géométrie, la génération des particules et les algorithmes de transport.

Le chapitre 5 décrit la simulation par le code PHITS, en détaillant la structure du fichier d'entrée et les modèles physiques utilisés.

Le chapitre 6 présente les résultats et les discussions obtenus à partir des simulations réalisées.

En conclusion, nous résumons les principales conclusions de notre travail.

Ce mémoire est accompagné d'une liste de références utilisées pour approfondir les sujets abordés.


# UNIVERSITE MOULAY ISMAIL FACULTE DES SCIENCES

## Es : somme des énergies par unité de longueur des particules sortantes (électrons) du volume considéré.

Nous considérons un petit rayon r du cylindre, et donc le TEL ne prend pas en compte les électrons secondaires qui vont déposer leur énergie en dehors du cylindre. En bas, le cylindre possède un rayon assez élevé R, et donc nous pouvons faire l’approximation que TEL = αEe-

![Schémas d’illustrations pour la prise en compte du calcul du TEL](https://example.com/image.png)

Plus ce paramètre est grand, plus les dégâts biologiques aux tissus traversés sont importants.

## 1.3.5 Définition de la dose

### Dose physique

La dose déposée ou dose absorbée par les tissus, notée D et exprimée en Gray (J/kg), représente l’énergie moyenne déposée par les particules ionisantes dans un volume de masse dm, et est donnée par la relation suivante :

dD = n

D’autre part, la dose est définie comme le produit de la fluence F et du pouvoir d’arrêt massique μ sous la forme :

D = F * μ

### Dose biologique

La dose biologique ou dose équivalente, notée Dy, est exprimée en Gray Équivalent Cobalt (60Co) et est définie par :

Dy = D * EBR

avec EBR : l’Efficacité Biologique Relative, sans unité. Pour les protons (protonthérapie), on utilise EBR = 1.1 quelles que soient les conditions de calcul. Cependant, EBR est entre 2 et 3 pour les ions de carbone (carbonethérapie).

## Interaction particule - matière biologique

L’interaction des particules ionisantes avec la matière biologique a pour effet d’endommager l’ADN directement ou indirectement par destruction de la molécule d’eau en deux radicaux libres actifs chimiquement qui attaquent la matière par des réactions chimiques. La figure 1.12 présente une illustration de cette interaction.

![Séquence schématisée des effets biologiques](https://example.com/image.png)

## 1.4 Conclusion

Le traitement des tumeurs cancéreuses utilise des particules ionisantes, qui transportent de l’énergie aux tumeurs en déclenchant les processus d’ionisation des tissus cibles. La connaissance de ces processus de transport des particules utilisées est indispensable pour optimiser le traitement et minimiser le risque sur les tissus sains environnants.

# CHAPITRE 2

## GÉNÉRALITÉS SUR LA MÉTHODE DE MONTE CARLO

### 2.1 Introduction

Les calculs de Monte Carlo font appel à une méthode statistique basée sur l'utilisation des nombres aléatoires comparables à ceux produits par les jeux de hasard dans les casinos. Dans ce contexte, on distingue deux grands domaines où la méthode de Monte Carlo peut être utilisée avec succès.

### Problèmes déterministes

Ce sont des problèmes de nature déterministe faisant appel aux calculs numériques, par exemple :

- Estimation des surfaces.
- Calculs d’intégrales multiples.
- Résolution d’équations différentielles.
- Résolution de systèmes d’équations algébriques.
- Résolution de problèmes d’optimisation combinatoire.

### Phénomènes et processus aléatoires

- Mouvement de particules.
- Systèmes stochastiques de gestion ou de production.
- Reconnaissance de formes (analyse d’images, de paroles, ...).
- Systèmes de commande décrits par des équations différentielles ordinaires ou des équations aux différences.

### 2.2 Générateur de nombres aléatoires

#### 2.2.1 Principe

La simulation Monte Carlo repose toujours sur un générateur de nombres aléatoires fiable. On appelle nombres aléatoires des variables aléatoires indépendantes uniformément distribuées sur l'intervalle [0,1].

#### 2.2.2 Nombres véritablement aléatoires

Les nombres vraiment aléatoires sont imprévisibles, ils ne sont pas générés par un processus déterministe et doivent être produits par un processus physique aléatoire, par exemple la désintégration radioactive, l'impact de la séparation des rayons cosmiques sur les détecteurs ou la synchronisation de la génération de bruit dans les circuits électroniques.

#### 2.2.3 Nombres pseudo-aléatoires

À l'aide d'un ordinateur, nous pouvons utiliser des nombres dits pseudo-aléatoires, qui sont générés par un algorithme conçu pour produire une séquence de nombres non corrélés et uniformément répartis dans un intervalle donné. Les chiffres semblent complètement aléatoires d’un point de vue extérieur, mais ils montrent un schéma récurrent.

En pratique, nous n’utilisons pas de vrais nombres aléatoires, désormais nous appellerons les nombres pseudo-aléatoires nombres aléatoires.

En général, un générateur de nombres aléatoires doit répondre aux conditions de base suivantes :

- La distribution des nombres aléatoires doit être uniformément répartie dans un intervalle spécifique, et doit répondre à des tests de cohérence et d’indépendance.
- La séquence comporte un grand nombre de nombres uniques avant de répéter la boucle.
- La génération de nombres aléatoires est très rapide.

### 2.3 Les méthodes principales d’échantillonnage

#### 2.3.1 Principe

La méthode de Monte Carlo (MC) consiste à échantillonner la distribution de probabilités décrivant un processus physique en utilisant des nombres aléatoires. Il existe trois méthodes principales d’échantillonnage : la méthode d’inversion directe, la méthode de réjection et la méthode de composition.

#### 2.3.2 La méthode d’inversion directe

Nous utilisons la méthode d’inversion directe lorsque la fonction de répartition de la variable aléatoire, qui renvoie la probabilité de prendre une valeur inférieure ou égale à a, peut être inversée. Puisque y = F(x) est uniformément distribué entre 0 (la probabilité que la variable aléatoire ne prenne aucune valeur) et 1 (la probabilité que la variable aléatoire prenne n’importe quelle valeur), la variable x = F^(-1)(y) obéit à la fonction de distribution p(x) = F'(x). Il suffit donc de générer une suite de valeurs R uniformément réparties entre 0 et 1, puis d’utiliser x = F^(-1)(R) pour obtenir les valeurs selon p(x).

Par exemple, la profondeur d’interaction des rayons gamma pénétrant dans un matériau d’épaisseur d et de coefficient d’atténuation μ est une variable aléatoire caractérisée par la fonction de partition :

La relation entre F(x) et p(x) est donnée par :

Avec μ un paramètre. La fonction de distribution est alors :

Si R est uniformément distribué dans l'intervalle [0, 1], alors la variable

sera automatiquement distribuée selon p(x).

La probabilité que la variable x soit supérieure à d est la probabilité que le rayon gamma n’interagisse pas dans le matériau. Elle est égale à :

Il détermine ainsi la proportion d’impacts qui n’entraînent pas d’interactions d’épaisseur de matériau et caractérise en quelque sorte l’inefficacité du processus de simulation pour cette tâche.

#### 2.3.3 La méthode de réjection

Une autre méthode d’échantillonnage a été proposée par Von Neumann. Elle consiste à tirer uniformément une variable aléatoire R dans l'intervalle [0,1] d’une distribution (autre que p(x)) et à la tester au hasard pour déterminer si elle est acceptée ou rejetée. Ces méthodes de rejet conduisent à une technique très générale d’échantillonnage à partir de n’importe quelle fonction de densité de probabilité (PDF) et à déterminer sa valeur correspondante en utilisant la règle d’échelle affine :

dans le domaine variable D = [Xmin, Xmax] d’une variable aléatoire. La valeur de x pour le deuxième graphe est affectée en fonction de p(x), tandis que le deuxième graphe R’ est uniformément réparti entre 0 et 1.

Cela permet de conserver x si R0 est inférieur ou égal à f(x) = p(x), et si non on le rejette.

#### 2.3.4 La méthode de composition

Si les deux méthodes précédentes ne sont pas applicables, une méthode combinant les deux peut être utilisée.

Soit deux fonctions de densités de probabilités normalisées à 1 : f(x) et g(x) définies par la relation suivante :

On utilise alors la méthode directe pour sélectionner x en utilisant f(x) comme fonction de densité de probabilité normalisée. Ensuite, on applique la méthode de rejet sur la fonction g(x).

### 2.4 Précision d’un code Monte Carlo

#### 2.4.1 Incertitudes physiques

Quelle que soit la précision des données physiques utilisées dans un code de Monte Carlo, la qualité des résultats est inévitablement limitée par le modèle de diffusion utilisé. La manière dont les sections efficaces sont tabulées, interpolées et échantillonnées peut introduire des erreurs supplémentaires.

#### 2.4.2 Incertitudes statistiques

Les résultats des calculs de Monte Carlo sont également soumis à une incertitude statistique. Pour éviter les fluctuations statistiques, un certain nombre de particules (des centaines à des milliards de particules) doivent être simulées.

En effet, plus le nombre d’histoires N généré est important, plus l’incertitude associée à la grandeur calculée dans le volume d’intérêt sera petite, et plus le résultat estimé par MC est proche de la réalité. L’incertitude statistique associée à σ correspondant à l’écart-type sur la moyenne G, est déterminée à partir de la relation suivante :

Où :

- σ : est l'incertitude statistique associée à la moyenne G.
- N : est la taille de l’échantillon, c’est-à-dire le nombre de valeurs dans l’échantillon.
- gj : représente les valeurs individuelles dans l’échantillon.
- G : est la moyenne des valeurs dans l’échantillon.

Ce type d’incertitude est lié aux modèles physiques utilisés pour déterminer la section efficace et le pouvoir d’arrêt. Ainsi, il est affecté par les erreurs de programmation.

### 2.5 Efficacité d’une simulation Monte Carlo

L’efficacité ε d’une simulation permet de comparer les performances de deux méthodes de simulation. L’efficacité est définie par la relation :

Où ΔY est l’incertitude de l’estimation, ΔT est le temps de calcul et G est la moyenne.

L’efficacité d’un code de Monte Carlo dépend en grande partie de la qualité de son générateur de nombres aléatoires.

### 2.6 Estimation de la valeur π par Monte Carlo

La méthode de Monte Carlo permet la résolution de certains problèmes numériques déterministes. Elle résout les problèmes de façon approchée avec une simulation.

Dans ce paragraphe, nous présentons brièvement l’approximation du nombre π par l’estimation de la surface d’un quart de disque de forme circulaire de rayon 1.

#### 2.6.1 Algorithme

Dans ce cas, on tire au hasard des coordonnées x et y, chacune dans l'intervalle [0, 1[. Si x^2 + y^2 < 1, alors le point P de coordonnées (x,y) appartient au quart de disque D de centre (0,0) et de rayon 1. La probabilité que count_inside appartienne à D est 7/4 (rapport de l'aire de D et du carré l'englobant). Donc, si on tire au hasard num_points points, et si count_inside d'entre eux appartiennent à D, on obtient une approximation de π/4 égale à :

π/4 ≈ count_inside / num_points

#### 2.6.2 Code de simulation

```python
import random
import matplotlib.pyplot as plt

num_points = 1000000
count_inside = 0

for _ in range(num_points):
    x = random.uniform(0, 1)
    y = random.uniform(0, 1)
    if x**2 + y**2 < 1:
        count_inside += 1

pi_approx = 4 * count_inside / num_points

print("Approximation de pi :", pi_approx)

plt.figure(figsize=(5, 5))
plt.scatter(x_inside, y_inside, color='red', s=1)
plt.scatter(x_outside, y_outside, color='blue', s=1)
plt.show()
```

Ce code utilise la méthode de Monte Carlo pour estimer la valeur de π en approximant la surface d'un quart de disque de rayon 1. Il génère un grand nombre de points aléatoires dans un carré de côté 1 et compte combien de ces points se trouvent à l'intérieur du quart de disque. L'approximation de π est ensuite calculée en utilisant la formule π/4 ≈ count_inside / num_points. Le code affiche également un graphique des points générés, avec les points à l'intérieur du quart de disque en rouge et les points à l'extérieur en bleu.
# Nombre de points à utiliser pour l'estimation
num_points = 10000

# Compteur pour les points dans le cercle
count_inside = 0

# Listes pour stocker les coordonnées des points dans et hors du cercle
x_inside = []
y_inside = []
x_outside = []
y_outside = []

## CHAPITRE 2. GÉNÉRALITÉS SUR LA MÉTHODE DE MONTE CARLO

La méthode de Monte Carlo est une technique utilisée pour estimer des valeurs en utilisant des nombres aléatoires. Dans ce cas, nous utilisons la méthode de Monte Carlo pour estimer la valeur de pi.

Pour ce faire, nous générons un grand nombre de points aléatoires dans un carré et nous comptons combien de ces points se trouvent à l'intérieur d'un cercle inscrit dans ce carré.

En utilisant la formule de l'aire d'un cercle, nous pouvons estimer la valeur de pi en calculant le rapport entre le nombre de points à l'intérieur du cercle et le nombre total de points.

Dans notre cas, nous allons générer 10 000 points aléatoires. Nous allons ensuite vérifier si chaque point se trouve à l'intérieur ou à l'extérieur du cercle en utilisant la formule de la distance entre deux points.

Nous allons stocker les coordonnées des points à l'intérieur et à l'extérieur du cercle dans des listes séparées.

Enfin, nous allons calculer le rapport entre le nombre de points à l'intérieur du cercle et le nombre total de points pour estimer la valeur de pi.
## Boucle pour générer des points aléatoires

Pour générer des points aléatoires, nous utilisons une boucle. Une boucle est une instruction qui répète une action plusieurs fois. Dans notre cas, nous voulons générer un certain nombre de points aléatoires.

Voici comment nous faisons cela en utilisant une boucle :

```python
for i in range(num_points):
    # Code pour générer un point aléatoire
```

Dans cette boucle, `num_points` est le nombre de points que nous voulons générer. La variable `i` est utilisée pour compter le nombre de fois que la boucle a été exécutée.

À l'intérieur de la boucle, nous écrivons le code pour générer un point aléatoire. Cela peut être n'importe quel code qui génère un point aléatoire, en fonction de ce que vous voulez faire avec les points.

Par exemple, si nous voulons générer des points aléatoires dans un carré de 10x10, nous pouvons utiliser le code suivant :

```python
import random

for i in range(num_points):
    x = random.uniform(0, 10)
    y = random.uniform(0, 10)
    print(f"Point {i+1}: ({x}, {y})")
```

Dans cet exemple, nous utilisons la fonction `random.uniform(a, b)` pour générer des nombres aléatoires entre `a` et `b`. Nous utilisons ensuite ces nombres pour définir les coordonnées `x` et `y` de chaque point. Enfin, nous imprimons les coordonnées de chaque point à l'écran.

C'est ainsi que nous utilisons une boucle pour générer des points aléatoires.
## Générer des coordonnées x et y aléatoires

Pour générer des coordonnées x et y aléatoires, nous utilisons une fonction qui nous donne un nombre aléatoire entre -1 et 1 pour chaque coordonnée. 

## Calculer la distance par rapport à l'origine (0,0)

La distance par rapport à l'origine (0,0) est calculée en utilisant la formule mathématique de la distance entre deux points dans un plan. Nous élevons au carré les coordonnées x et y, puis nous les additionnons et prenons la racine carrée du résultat. Cela nous donne la distance du point par rapport à l'origine.

## Vérifier si le point est à l'intérieur ou à l'extérieur du cercle

Si la distance calculée est inférieure ou égale à 1, cela signifie que le point est à l'intérieur du cercle. Si la distance est supérieure à 1, cela signifie que le point est à l'extérieur du cercle.

## Calculer Pi en utilisant le nombre de points à l'intérieur et à l'extérieur du cercle

Pour calculer Pi, nous utilisons le rapport entre le nombre de points à l'intérieur du cercle et le nombre total de points générés. Nous multiplions ce rapport par 4 pour obtenir une estimation de Pi.
# Simplification du texte

## Affichage du résultat de l'estimation de Pi

Pour afficher le résultat de l'estimation de Pi, nous utilisons la fonction `print()` en Python. Dans cet exemple, nous affichons que Pi est estimé à 4.
# Créer un graphique pour visualiser les points dans et hors du cercle

Pour créer un graphique qui montre les points à l'intérieur et à l'extérieur d'un cercle, nous allons utiliser la méthode de Monte Carlo. Cette méthode est utilisée pour estimer des valeurs en utilisant des nombres aléatoires.

## CHAPITRE 2. GÉNÉRALITÉS SUR LA MÉTHODE DE MONTE CARLO

Pour commencer, nous allons tracer les points à l'intérieur et à l'extérieur du cercle sur notre graphique. Les points à l'intérieur du cercle seront représentés en bleu et les points à l'extérieur en rouge.

Voici le code pour créer le graphique :

```python
fig, ax = plt.subplots()
ax.set_aspect('equal', 'box')
ax.scatter(x_inside, y_inside, color='blue', marker='.')
ax.scatter(x_outside, y_outside, color='red', marker='.')
```

Dans ce code, "x_inside" et "y_inside" représentent les coordonnées des points à l'intérieur du cercle, tandis que "x_outside" et "y_outside" représentent les coordonnées des points à l'extérieur du cercle.

En utilisant ce graphique, nous pourrons visualiser les points dans et hors du cercle, ce qui nous aidera à comprendre la méthode de Monte Carlo plus facilement.
Ajouter un cercle à l'intérieur d'un carré pour représenter un cercle de taille 1.
# Simulation de transport des particules par Monte Carlo

## Introduction

La simulation du transport des particules dans la matière est réalisée en utilisant la méthode Monte Carlo. Cette méthode permet de suivre l'histoire des particules primaires et secondaires créées lors des interactions avec la matière.

## Simulation de transport d'une particule dans la matière

La simulation du transport d'une particule dans la matière par Monte Carlo se déroule en plusieurs étapes :

### Définition de la géométrie

Il s'agit de définir les dimensions et la forme des milieux d'interaction où se déroule la simulation. On utilise des paramètres tels que les caractéristiques chimiques du milieu et les dimensions du milieu pour définir la géométrie de simulation.

### Génération des particules

On définit les informations associées à la particule, telles que la source de génération, la position initiale, l'énergie et la direction initiale.

### Tirage aléatoire de la position avant la prochaine interaction

On utilise la loi de Beer-Lambert pour déterminer la distance parcourue par la particule avant la prochaine interaction. Cette distance est tirée aléatoirement en utilisant un nombre aléatoire entre 0 et 1.

### Vérification de la position prochaine

On vérifie si la position prochaine de la particule est à l'intérieur de la géométrie définie. Si c'est le cas, la particule est avancée à cette position et son énergie est modifiée en fonction de l'interaction.

Le suivi de la particule est arrêté lorsque sa position prochaine est en dehors de la géométrie définie.

## Transport de photons

Pour les photons, les interactions principales sont l'effet photoélectrique, la diffusion Rayleigh, la diffusion Compton et la création de paires. Le type d'interaction est déterminé en utilisant les sections efficaces tabulées qui dépendent du matériau. Un nombre aléatoire est tiré pour sélectionner l'interaction correspondante.

Ces étapes permettent de simuler le transport des particules dans la matière en utilisant la méthode Monte Carlo.
# Simplification du texte

## Chapitre 4: Simulation de transport des particules par Monte Carlo

### 4.4 Transport d'électrons et de positrons

Les électrons et les positrons sont des particules qui se déplacent de la même manière dans la matière. Ils subissent de nombreuses interactions avec une faible perte d'énergie le long de leur trajet. Pour suivre leur trajectoire, on utilise une technique appelée "histoire condensée".

#### 4.4.1 La technique d'histoire condensée

Cette technique consiste à regrouper les interactions élémentaires des électrons en étapes et à échantillonner les effets globaux (énergie, direction, déplacement latéral) à partir de distributions appropriées.

#### 4.4.2 Algorithme de transport des électrons

Pour transporter les électrons, on peut les déplacer le long d'une ligne en ignorant les déviations dues aux diffusions multiples. Cependant, la taille des pas doit être suffisamment petite pour accepter cette approximation.

### 4.5 Transport des protons et des ions de carbone

Le transport des protons et des ions de carbone est modélisé en divisant leur trajet en petites étapes. Il est régi par trois processus principaux : le pouvoir d'arrêt, la diffusion coulombienne et les interactions nucléaires.

#### 4.5.1 Pouvoir d'arrêt

Les ions perdent leur énergie en interagissant avec les électrons atomiques. La perte d'énergie pour chaque étape est calculée à partir des valeurs de pouvoir d'arrêt.

#### 4.5.2 Diffusion

Les protons se dispersent lorsqu'ils ralentissent en interagissant avec les noyaux. On peut utiliser des fonctions de densité de probabilité pour calculer l'angle de diffusion à la fin de chaque étape.

#### 4.5.3 Interactions nucléaires

Les particules d'un faisceau ionique interagissent avec les noyaux atomiques, ce qui peut entraîner la production de neutrons, d'autres particules et d'isotopes à vie courte.

### 4.6 Conclusion

Dans ce chapitre, nous avons examiné les étapes du transport des particules dans un milieu biologique, tel que le transport des photons, des électrons, des protons et des ions de carbone. Nous utiliserons le code Monte Carlo PHITS pour simuler ces processus.

## Chapitre 5: Simulation par le code PHITS

### 5.1 Introduction

PHITS (Particle and Heavy Ion Transport code System) est un code de simulation de transport de particules largement utilisé dans le monde entier. Il peut simuler le transport de différentes particules sur une large gamme d'énergie en utilisant divers modèles de réactions nucléaires et bibliothèques de données.

### 5.2 Description du fichier d'entrée

Le fichier d'entrée de PHITS est un texte qui permet de définir les paramètres et les variables nécessaires à la simulation. Il comprend des sections pour définir les caractéristiques des particules à simuler, la géométrie de l'espace virtuel et les matériaux utilisés.

### 5.3 Les modèles physiques dans PHITS

PHITS utilise différents modèles physiques pour simuler les réactions nucléaires et le transport des particules. Certains de ces modèles incluent JAM et INCL4.6 pour la cascade hadronique, JQMD pour les ions lourds, SMM pour la fragmentation statistique, GEM pour l'évaporation statistique et JENDL-4.0 pour les données nucléaires.

### 5.4 Conclusion

Dans ce chapitre, nous avons présenté le fonctionnement du code PHITS et les modèles physiques utilisés pour la simulation de transport des particules.
# Ajouter une légende pour les points

Les points sur la figure 5.3 représentent différents modèles physiques utilisés dans ce code. 

# Introduction

L'utilisation d'un faisceau de particules pour traiter les tumeurs cancéreuses nécessite une étude préliminaire détaillée. Cette étude vise à détruire uniquement les tumeurs tout en préservant les organes sains. Pour cela, nous utilisons une simulation basée sur le code PHITS, qui donne des résultats proches de la réalité.

Dans ce travail, nous utilisons le code PHITS pour simuler le transport des particules utilisées en hadronthérapie (protons, 12C, neutrons...). Nous déterminons les caractéristiques balistiques des protons et des ions de carbone 12, ainsi que le suivi des particules secondaires qui contribuent à la déposition de dose.

# Matériel et Méthode

La première étape de la simulation consiste à créer un objet simple en forme de parallélépipède de dimensions 20 cm x 20 cm x 40 cm.

Ensuite, nous créons une source de faisceau cylindrique de protons avec un diamètre de 8 cm et une énergie de 140 MeV. Le faisceau est dirigé le long de l'axe z.

Nous utilisons de l'eau comme matériau dans cette simulation, avec une masse volumique de 1 g/cm³. Nous incluons également du polyéthylène (C2H) dans la simulation pour valider le code utilisé.

La source est positionnée à une distance de 40 cm de l'objet.

# Validation du code PHITS

Dans cette partie préliminaire, nous simulons le transport des ions carbone (12C) d'énergie 200,2 MeV/u dans le polyéthylène (C2H) à l'aide du code PHITS. Nous comparons les résultats de la simulation avec les mesures expérimentales réalisées par la NASA au Laboratoire des Radiations du Département de l'Énergie. Cela nous permet d'évaluer la fiabilité du code.

Les résultats de la simulation et les mesures sont présentés dans la figure 6.2. Les résultats de la simulation sont en accord avec l'expérience, avec une petite différence au niveau du pic de Bragg. Cette différence s'explique par plusieurs paramètres, notamment le pas de simulation et la méthode utilisée pour calculer la dose.

En conclusion, cette petite différence est acceptable en raison des incertitudes des mesures expérimentales et des modèles physiques utilisés dans le code PHITS.

# Simulation du transport des protons

Dans cette partie, nous simulons le transport d'énergie par un faisceau contenant 10^7 protons monoénergétiques dans l'eau. En utilisant l'observable tally, nous déterminons la dose absorbée le long de l'axe du faisceau et latéralement par la cible.

## Caractéristique longitudinale des protons

La figure 6.3 montre la courbe de la dose absorbée par l'objet en fonction de la profondeur obtenue par le code PHITS. Les protons déposent le maximum d'énergie à une profondeur spécifique (z = 13,75 cm) où se trouve le pic de Bragg. Au-delà de ce pic, la dose absorbée est faible, ce qui indique une dispersion longitudinale du faisceau faible. Cela rend le traitement par des protons avantageux par rapport aux rayons X et aux électrons.

## Contribution en profondeur des particules secondaires

Les collisions des protons avec les électrons et les noyaux du milieu cible produisent des particules secondaires, telles que des neutrons, des photons, des deutérons, du tritium et des électrons. Ces particules contribuent à une faible dose, principalement avant et au pic de Bragg. Après le pic de Bragg, la dose est déposée principalement par les particules neutrons et photons dont la trajectoire dépasse 20 cm dans l'eau. Les isotopes lourds 7H et 3H sont arrêtés par le milieu avant le pic de Bragg.
# Afficher le graphique

La matière est importante, ce qui s'accompagne d'une diminution d'énergie au fur et à mesure jusqu'à une énergie faible qui sera déposée intégralement sous forme de pic.

| Énergies (MeV) | Position du pic de Bragg | Largeur à mi-hauteur (cm) |
|----------------|-------------------------|--------------------------|
| 50             | 2,1                     | 0,2                      |
| 95             | 6,9                     | 0,3                      |
| 140            | 13,8                    | 0,4                      |
| 200            | 25,8                    | 0,6                      |

**Tableau 6.1** - Largeur à mi-hauteur pour différentes énergies de protons.

D'après le tableau 6.1, nous constatons que lorsque la profondeur dans l'eau augmente, la largeur à mi-hauteur augmente. Cela traduit une dispersion du faisceau de protons et une perte de précision du dépôt de dose avec la profondeur.

## 6.5 Simulation de transport d'ions Carbone 12

Nous reprenons le matériel et la géométrie utilisés précédemment en remplaçant la source de protons par une source d'ions de carbone 12 d'énergie E=264 MeV. La dose absorbée en profondeur par le fantôme est calculée dans la section tally, précisément par [T-Deposit].

**Dose en profondeur**

Le code PHITS donne la courbe de la dose en profondeur sur la figure 6.9 :

![Figure 6.9](image.png)

La courbe (figure 6.9) montre que les ions de carbone 12 primaires sont principalement responsables de la dose déposée, environ 93%, dans le fantôme avant et au pic de Bragg. Cependant, les particules secondaires ne contribuent qu'à 7% de la dose totale déposée.

Au pic de Bragg pour z = 13,8 cm, tous les ions de carbone 12 du faisceau primaire sont arrêtés par le milieu, marquant la fin de leur parcours. Après le pic de Bragg, il y a une apparition d'une queue de dose appelée queue de fragmentation, qui est due aux particules secondaires (protons, neutrons, 10B, 4He, 12C...) se produisant par la fragmentation et qui sont responsables de la dose déposée.

1. Le taux de dose : égal à la dose déposée à la position z donnée sur celle déposée au pic de Bragg.

## Étude des fragments

Le suivi des fragments par le code PHITS permet d'obtenir les résultats de la figure 6.10. Les particules secondaires contribuent principalement à la dose totale, mais avec une faible dose. Les particules H*, fragments 10B et 4He contribuent à la dose déposée, mais le taux de contribution des neutrons ne dépasse pas 0,02%. Avant le pic de Bragg, leur contribution est faible par rapport aux ions de carbone incidents, et après le pic, la courbe de dose totale est presque confondue avec celle de toutes les particules secondaires.

La distribution de dose des fragments 12C et 10B montre une chute sous forme de pic, indiquant la fin de leur parcours. Les fragments légers sont émis vers l'avant et leur parcours dans l'eau est long, environ 40 cm, tandis que le parcours des fragments lourds est court.

Le tableau 6.2 donne le parcours et le taux de contribution en dose des différentes particules secondaires.

**Tableau 6.2** - Taux de contribution en dose (%) pour différentes particules secondaires dans l'eau.

## 6.6 Comparaison entre l'ion carbone et un ion lourd et léger

Nous comparons les caractéristiques d'un ion carbone d'énergie E=270 MeV/u d'une part avec un ion léger H* et d'autre part avec un ion lourd 7Ne.

### 6.6.1 Ion carbone et proton

La dispersion longitudinale

Le code PHITS permet d'obtenir la dose en profondeur, figure 6.11.

![Figure 6.11](image.png)

Le tableau 6.3 résume les résultats de la figure 6.11, en donnant la largeur à mi-hauteur et le taux de dispersion en profondeur des deux ions.

**Tableau 6.3** - Données de largeur à mi-hauteur et de taux de dispersion en profondeur pour différents ions.

À partir du tableau, on peut conclure que :
- Le faisceau de protons a une faible précision de dépôt de dose par rapport aux ions carbone.
- Les ions carbone ont une faible dispersion en profondeur par rapport aux protons.

### 6.6.2 Ion carbone et ion de néon

La dispersion longitudinale

La simulation par le code PHITS d'un faisceau d'ions carbone et d'un faisceau d'ions néon permet d'obtenir les courbes de la figure 6.12.

![Figure 6.12](image.png)

Nous constatons que la dose déposée avant le pic de Bragg par les ions carbone est quasi-ment constante et faible par rapport aux ions de néon. Après le pic, la queue de fragmentation des ions néon est plus importante que celle des ions carbone. Cependant, la dispersion en profondeur est la même pour les deux ions.

Dans le tableau 6.4, nous calculons le taux de dose par rapport à celle déposée au pic de Bragg à l'entrée z=0 du fantôme et juste après le pic z=27,6 cm.

**Tableau 6.4** - Taux de dose par rapport au pic de Bragg pour les ions de carbone et les ions de néon.

## 6.7 Conclusion

Un dépôt d'énergie modéré et quasi constant en entrée et maximal en fin de parcours par les ions de carbone 12 et de protons, une faible dispersion en profondeur et latéralement permettent d'irradier précisément le volume ciblé pour détruire les tumeurs tout en protégeant les organes sains situés en entrée. Cette caractéristique met en évidence l'intérêt balistique des ions pour un traitement par rapport aux électrons et aux rayons X.

Le traitement avec les ions carbone est plus efficace que celui des protons. En effet, les ions de carbone 12 ont une efficacité biologique relative entre 2 et 4, tandis que celle des protons est quasiment constante avec une valeur EBR = 1,1.

## Conclusion générale

Dans ce travail, nous avons présenté un aperçu du principe d'interaction des particules avec la matière, nécessaire pour comprendre le transport et le transfert d'énergie d'une particule dans un milieu biologique. Nous avons également abordé la méthode de Monte Carlo, qui repose sur l'échantillonnage aléatoire et permet d'estimer la valeur de pi, ainsi que d'autres problèmes étudiés.

Nous avons étudié les résultats de transport de protons et d'ions carbone par le code PHITS. Nous avons validé notre code en comparant les mesures dans le polyéthylène données par la NASA avec les courbes de Bragg obtenues par simulation. Nous avons ensuite réalisé une simulation d'un faisceau de protons et d'ions carbone 12 dans l'eau, et les résultats obtenus sont conformes aux travaux publiés dans ce domaine.

Nous avons également étudié la fragmentation des ions carbone 12 et son impact sur la dose déposée. Nous avons comparé les caractéristiques des ions carbone avec celles des ions légers et des ions lourds, montrant ainsi l'efficacité des ions carbone dans le traitement des tumeurs.

Ce travail représente une initiation à la recherche en physique médicale, et son expansion sera une perspective pour les années à venir. Il permettra d'améliorer notre connaissance du comportement des ions dans un milieu biologique, d'étudier les fragments produits et leurs propriétés, et d'améliorer les moyens de radioprotection contre les particules secondaires, notamment les neutrons.

# Afficher le graphique

K. GUNZERT-MARX, D. SCHARDT et R. S. SIMON, "Fast neutrons produced by nuclear fragmentation in treatment irradiations with 12C beam", Radiation protection dosimetry, vol. 110, n° 1-4, p. 595-600, 2004.

D. SCHARDT et al., "Nuclear fragmentation of high-energy heavy-ion beams in water", Advances in Space Research, vol. 17, n° 2, p. 87-94, 1996.

67

REFERENCES

[50] N. Marsurugi, A. FukuMuRA, M. Komori, T. KANAI et T. KOHNO, "Influence of fragment reaction of relativistic heavy charged particles on heavy-ion radiotherapy", Physics in Medicine & Biology, vol. 48, n° 11, p. 1605, 2003.

[51] H. MACCABEE et M. RITTER, "Fragmentation of high-energy oxygen-ion beams in water", Radiation Research, vol. 60, n° 3, p. 409-421, 1974.

[52] J. LLACER, C. TOBIAS, W. HOLLEY et T. KANAI, "On-line characterization of heavy-ion beams with semiconductor detectors", Medical physics, vol. 11, n° 3, p. 266-278, 1984.

[53] E. HAETTNER, H. IWASE, M. KRAMER, G. KRAFT et D. SCHARDT, "Experimental study of nuclear fragmentation of 200 and 400 MeV/u 12C ions in water for applications in particle therapy", Physics in medicine & biology, vol. 58, n° 23, p. 8265, 2013.

68
