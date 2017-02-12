#! /bin/sh

if [ $# -ne 1 ]; then
	echo "Erreur : un seul argument attendu"
	exit 1
fi

if [ -e $1 ]; then
	echo "Erreur : le fichier $1 existe déjà dans le dossier courant"
	exit 1
fi

touch $1
echo "SUJET : " > $1
echo "" >> $1
date >> $1
echo "" >> $1
echo "PLAN : " >> $1
echo "" >> $1
echo "INFOS SUPPLEMENTAIRES : " >> $1
echo "" >> $1
echo "CONTENU :" >> $1
echo "" >> $1
vim $1
