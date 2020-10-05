NUM_FIXED_NOTES=7
ZETTEL_PATH="/Users/colinpinney/Documents/Zettelkasten"
if [ ! -f $ZETTEL_PATH/Drop\ Box/Zettelkasten.goodnotes ]
then
	echo "No GoodNotes export found."
	exit
fi
rm -rf $ZETTEL_PATH/Backup/*
cp -R $ZETTEL_PATH/Odin $ZETTEL_PATH/Backup/
NUM_NOTES=($ZETTEL_PATH/Odin/*.md)
NUM_NOTES=$((${#NUM_NOTES[@]}-$NUM_FIXED_NOTES))
ls -tpr $ZETTEL_PATH/Odin/ | grep -v '/$' | tail -n +$(($NUM_FIXED_NOTES+1)) | tr '\n' '\0' | xargs -0 rm -- 
cp -R $ZETTEL_PATH/Drop\ Box $ZETTEL_PATH/Backup/
unzip -qq $ZETTEL_PATH/Drop\ Box/Zettelkasten.goodnotes -d $ZETTEL_PATH/Drop\ Box/GoodNotes/
{
	seq $(($NUM_NOTES+1)) | xargs -I read
	while IFS="" read -r p || [ -n "$p" ]
	do
		p=$(echo $p | cut -c2-38)
		ex -s "$ZETTEL_PATH/Drop\ Box/GoodNotes/search/$p" 
	done
} < $ZETTEL_PATH/Drop\ Box/GoodNotes/index.search.pb
find $ZETTEL_PATH/Drop\ Box/GoodNotes/search/* -not -name "*.md" | while read f
do
	ex -s "$f" < /Users/colinpinney/Documents/Scripts/commands.vim
done
rm -rf $ZETTEL_PATH/Drop\ Box/*
rm -rf $ZETTEL_PATH/Odin/\?\?*