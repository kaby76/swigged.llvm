#

find . -type f -print > all_files
for f in `cat all_files`
do

#    echo $f
    grep -e '-g' $f > ooo.txt 2>&1
    n=`cat ooo.txt | wc | awk '{print $1}'`
    grep -q -e 'Binary' ooo.txt
    nb=$?
    if [ $nb -ne 0 ]
    then
        if [ $n -gt 0 ]
        then
	    echo =====================
	    echo $f
	    cat ooo.txt
        fi
    fi
done

