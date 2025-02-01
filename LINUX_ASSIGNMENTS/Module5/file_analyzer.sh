#!/bin/bash
var=0
varf=0
directory=""
keyword=""
filename="" 
location=0
founddirectory=""

echo "" > errorfile.log

search() {





	for file in $(ls -F "$1" | grep -v "\/$");do
	if ! [[ -z "$(find "$1" -maxdepth 1 -name "$file")" ]] && ! [[ -z "$(grep -w "$2" <<< "$(cat "$1/$file")")" ]];then
		var=1
		return 
	fi
	done
	touch allfile.txt
	ls -F "$1" > allfile.txt

	if [[ -z "$(grep "\/$" < allfile.txt)" ]];then 
		return
	else
		mapfile -t newarr < <(grep "\/$" < allfile.txt)
		for folder in "${newarr[@]}"; do
			search "$1/$folder" "$2"
			if [[ var -eq 1 ]];then
				return
			fi
		done
	fi
}


searchf() {

        for file in $(ls -F "$1" | grep -v "\/$");do
        if [[ "$file" == "$2"  ]] && ! [[ -z "$(grep -w "$3" <<< "$(cat "$1/$file")")" ]];then
                varf=1
                return 
        fi
        done
        touch allfile.txt
        ls -F "$1" > allfile.txt

        if [[ -z "$(grep "\/$" < allfile.txt)" ]];then 
                return
        else
                mapfile -t newarr < <(grep "\/$" < allfile.txt)
                for folder in "${newarr[@]}"; do
                        searchf "${1}/${folder%/}" "$2" "$3"
                        if [[ varf -eq 1 ]];then
                               return
                        fi
                done
        fi
}

directoryfind() {

if [[ "$1" == "$PWD" ]] && [[ "$1" == "$2"  ]];then
founddirectory="$1"
location=1
return
fi

if [[ "$(echo "$1" | awk -F/ '{print $NF}')" == "$2" ]];then
founddirectory="$1"
location=1
return

else

touch allfiles.txt
ls -F "$1" > allfiles.txt
if [[ -z "$(grep "\/$" < allfiles.txt)" ]];then
return 

else
mapfile -t newarray < <(grep "\/$" < allfiles.txt)
for fol in "${newarray[@]}";do
directoryfind "${1}/${fol%/}" "$2"
if [[ "$location" -eq 1 ]];then
return

fi
done

fi

fi

} 


if [[ "$1" == "--help" ]];then
cat<<EOF
$0 is the script file which accepts following arguments with same order as given here: 
Option 1: ./<script_name>.sh -d <directory to search> -k <keyword to search>
Option 2: ./<script_name>.sh -f <file name to search directly> -k <keyword to search>
EOF

exit 0


fi

while getopts ":d:k:f:" opt; do
	case "$opt" in 
		d) 
			directory=$OPTARG;;
		k)
			keyword=$OPTARG;;
		f)
			filename=$OPTARG;;
		\?)
			echo "Invalid Option" > errorfile.log;
			exit 1;;
		:) 
			echo "Option -$OPTARG requires an argument" > errorfile.log;
			exit 1;;
	esac
done

if [[ "$1" == "-d" ]];then

directoryfind "$PWD" "$2"
if ! [[ -n "$founddirectory" ]];then
echo "Given directory name is not available" > errorfile.log
exit 1
fi

echo "$founddirectory" 
search "$founddirectory" "$keyword"
if [[ var -eq 1 ]];then
echo "Keyword found"



if [[ -f "$PWD/errorfile.log" ]];then
if [[ -s "$PWD/errorfile.log" ]];then
cat errorfile.log
fi
fi

else
echo "Keyword not found"
fi

fi

if [[ "$1" == "-f" ]];then

searchf "$PWD" "$filename" "$keyword"
if [[ varf -eq 1 ]];then
echo " Keyword Found"

if [[ -f "$PWD/errorfile.log" ]];then
if [[ -s "$PWD/errorfile.log" ]];then
cat errorfile.log
fi
fi


else
echo " Keyword not found"
fi


fi


echo ""

echo "Feedback on running this script:"

echo "Script name : $0"

echo "Total number of arguments passed : $#"

echo "Exit Status Code : $?"

echo "All arguments passed in command line : $@"
