#!/bin/bash
clear
typeset -i n=0
typeset -i j=1
typeset -i k=0
typeset -i matches=0
typeset -i cont=1
typeset fields=""
echo "enter table name"
read tblName
while [ $cont -eq 1 ]
do
if [ -f $tblPATH/$tblName ]
then
	#echo "update $tblName using:"
    awk -F: 'BEGIN{i=1;str=""}{if (NR==2){while(i<=NF){str=i") "$i;print str;i++;}}}' $tblPATH/$tblName
	#awk -F: 'BEGIN{printf "enter key to search with: ";getline key<"-";printf "enter value: ";getline keyVal<"-";printf "enter key to update: ";getline updatedCol<"-";printf "enter new value to insert: ";getline newVal<"-";} (NR==1){updatedColDatatype=$updatedCol} gsub($updatedCol, newVal){if($key==keyVal) {str=$0}}(updatedColDatatype="text") {print str}' $tblPATH/$tblName 
	n=`awk -F: 'END{print NF}' $tblPATH/$tblName`
	read -p "enter key to select with:  " key
	if [ $key -le $n ]
	then
		read -p "enter value: " keyVal
		matches=`cut -d: -f$key $tblPATH/$tblName | grep -c $keyVal` 
		if [ $matches -ne 0 ]
		then 
		    typeset -i arr[$n]
		    read -p "enter the fields you want to select: " fields
			arr=($(echo $fields | awk -v n=$n 'BEGIN{FS=" ";i=1;}{for(i;i<=NF;i++){if($i>n){printf "Invalid Input\n";} else print $i;}}'))
			#${arr[@]}
			awk -F: -v key=$key -v keyVal=$keyVal -v fields="$fields" 'BEGIN{i=1;FS=":";}{if($key==keyVal) {split(fields,FIELDS," ");for(;i<=NF;i++){if(FIELDS[i]!=0)print $FIELDS[i]}}}' $tblPATH/$tblName
			echo "Rows matched: $matches  Changed: "					
		else
			echo "No Matched records"
		fi	
	else
		echo "invalid Key"

	fi
	#done	
else 
	echo "No such Table"
fi
select x in "Update" "Back"  
do
	case $x in
		"Update") cont=1 break;;
		"Back") cont=0 break;;
        esac
done
done





