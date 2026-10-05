reponses tp git

b. remote en local
    difference depot local et remote :
    le depot local est sur notre machine avec les fichiers de travail, on peut coder, tester et commit sans reseau... le remote sert juste de reference pour synchroniser l'equipe, c'est un depot bare sans working directory, juste pour push et pull.   

c. creation d'une equipe
    fichiers a commit et ignorer :
    on commit les sources dans src/, les scripts gradle (gradlew, build.gradle...), le README et .gitignore.
    on ignore tout ce qui est genere : le dossier build/, le cache .gradle, et les dossiers d'ide comme .idea ou .vscode pour pas polluer le repo.   

lier DEV1 au remote :
on fait git remote add origin $REMOTE, et pour envoyer la branche : git push -u origin master.   

contenu de $REMOTE :
il n'y a aucun fichier de code visible, juste les dossiers internes de git (objects, refs, HEAD...), c'est normal vu que c'est un repo cree en --bare.   

d. travail en equipe

4.a git lol :
on voit pas le commit de DEV1 sur DEV2, git ne synchronise rien tout seul en arriere-plan...   

4.b git fetch :
origin/master avance d'un commit sur l'arbre, mais notre branche locale master reste a l'ancien commit, les branches sont decalees.   

4.c App.java :
le code n'a pas bouge (toujours num1+num2), normal car fetch recupere juste les commits dans l'historique sans toucher aux fichiers de travail.   

4.d etape pour finir :
il faut fusionner avec git merge origin/master, et la ca fait un fast-forward direct.   

6.a git pull vs etape 4 :
git pull fait les deux d'un coup (le fetch puis le merge direct), sans devoir taper les deux commandes separement.   

e. gestion des conflits
    conflit sur App.java :
    le push est rejete car on n'est pas a jour, et le pull met un conflit dans le fichier... parce que DEV1 et DEV2 ont modifie les memes lignes en meme temps.
    pour resoudre : on ouvre App.java, on supprime les balises <<<<<<< et >>>>>>>, on garde le code qu'on veut, puis git add App.java et git commit pour valider le merge.   

7.b modif @author :
meme probleme, conflit sur la ligne de l'auteur vu qu'il y a deux noms differents... faut rouvrir le fichier, choisir le bon nom, git add et commit.   

i. a comprendre
    commit atomique :
    un commit qui fait une seule tache precise (un bugfix, une petite feature...), court, propre, et qui laisse le projet fonctionnel.   

purger un secret :
d'abord revoquer le token/mot de passe tout de suite, puis reecrire l'historique avec git-filter-repo (ou bfg) pour le virer de tous les anciens commits, et enfin git push --force.   

prevenir les fuites :
mettre les cles dans un fichier .env bien liste dans .gitignore, et mettre un hook avec gitleaks ou trufflehog pour bloquer le commit avant de push.