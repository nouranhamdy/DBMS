
#!/bin/bash
clear
typeset -i NF
typeset -i i=1
dt=""
cl=""
tablePATH=""
dty=""
col=""


function validation
{

typeset -i serialPK=0
record=""
tablePATH=$1
dty=$2
col=$3	

if [ $dty='serial' ] 
then
	serialPK=`awk -F: 'END{print $1}' $tablePATH`
	if [[ $x = +([1-9]) ]]
	then
		serialPK=$serialPK+1
		record="$record:$serialPK"
	else
		serialPK=1
		record="$record:$serialPK"
	fi
else
    echo "$col: "
    read x
	if [ $dty='int' ]
	then
		if [[ $x = +([0-9]) ]]
		then
			record = $record:$x
	else
			echo "not int, try again"
			$record=$(validation $tablePATH $dty $col)
		fi
	elif [ $dty='text' ]
	then
		if [[ $x = +([a-zA-Z0-9]) ]]
		then
			record = $record:$x
	else
			echo "not text, try again"
			$record=$(validation $tablePATH $dty $col) 
		fi


	fi
fi
echo $record
}

echo "enter table name"
read tblName
echo "$tblPATH/$tblName"
tablePATH="$tblPATH/$tblName"
if [ -f $tablePATH ]
then   
	dt=`cat $tablePATH | head -1`
	echo $dt
	cl=`cat $tablePATH | head -2 | tail -1`
	echo $cl
	NF=`awk -F: 'END{print NF}' $tablePATH`
	echo $NF
	while [ $i -lt $NF ]
	do
	dty=`echo $dt | cut -d: -f$i`
	col=`echo $cl | cut -d: -f$i`
	$record=$(validation $tablePATH $dty $col)
	i=$i+1
	done
	echo $record >> $tablePATH
	echo "Record inserted"
else
	echo "No such table"
fi 