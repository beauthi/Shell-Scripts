#! /bin/sh

cours() {
if [ $# -ne 1 ]; then
	echo "Erreur : un seul argument attendu"
	exit 1
fi

if [ -e $1 ]; then
	echo "Erreur : le fichier $1 existe déjà dans le dossier courant"
	exit 1
fi

touch $1
echo "SUJET : $1 - " > $1
echo "" >> $1
TZ='Europe/France' date >> $1
echo "" >> $1
echo "PLAN : " >> $1
echo "" >> $1
echo "INFOS SUPPLEMENTAIRES : " >> $1
echo "" >> $1
echo "CONTENU :" >> $1
echo "" >> $1
vim $1
}

{
filename=${PWD##*/}
idx=1
find "$filename"_0"$idx"
ret=$?
while [ $ret -ne 1 ]; do
	idx=$(($idx + 1));
	if [ $idx -lt 10 ]; then
		find "$filename"_0"$idx"
	else
		find "$filename"_"$idx"
	fi
	ret=$?
done
} &> /dev/null
if [ $idx -lt 10 ]; then
	cours "$filename"_0"$idx"
else
	cours "$filename"_"$idx"
fi
