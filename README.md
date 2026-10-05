reponses tp ci-cd

2. registry gitlab
    registry privee :
    c'est un serveur qui stocke les images docker (nom + tag) mais accessible que par les gens autorises, pas comme docker hub public.
    l'interet : le code et les images restent prives, les droits sont ceux du projet gitlab, l'image est stockee a cote du code et on sait quel commit a produit quelle version... et en plus c'est en local donc rapide et pas de limite de pull.   

3. runner en local
    runner :
    c'est l'agent qui execute les jobs. gitlab lui ne fait que lire le .gitlab-ci.yml et mettre les jobs en attente, le runner les recupere, clone le repo, lance les scripts dans un conteneur et renvoie les logs, le statut et les artefacts.   

5. .gitlab-ci.yml
    fichier yml :
    un format texte pour ecrire de la config, base sur l'indentation (espaces, jamais de tabulations), avec des cle: valeur, des listes avec des tirets... on le retrouve partout (docker compose, kubernetes, github actions...).   

a quoi sert .gitlab-ci.yml :
il est a la racine du repo et decrit tout le pipeline : les stages, les jobs, l'image de chaque job, les commandes, quand ils se lancent (rules), le cache, les artefacts... a chaque push/merge request/tag gitlab le lit et cree le pipeline. vu qu'il est versionne il evolue avec le code.   

etapes possibles :
on les definit nous meme dans stages:, par defaut c'est .pre, build, test, deploy, .post.
en general : check/lint -> build -> test -> securite/qualite -> package (image docker) -> release -> deploy -> notify.
les jobs d'un meme stage tournent en parallele, et un stage attend que le precedent soit fini (sauf avec needs:).   
