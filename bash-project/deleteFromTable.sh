#!/bin/bash
clear
echo "enter table from which you want to delete"
read tblName
if [ -f $tblPATH/$tblName ]
then

