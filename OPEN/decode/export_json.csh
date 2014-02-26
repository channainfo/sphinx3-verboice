##!/bin/csh

x=`less ./Out_nbest1/test1.nbest | grep [កខគឃងចឆជឈញដឋឌឍណតថទធនបផពភមយលឡរអសហវ] | cut -d " " -f4,18`
echo \{ 
echo $'\t'\"results\"\:\[ 

a=0
for i in $x 
do
	arr[a]=$i
	((a=a+1))
done

#echo "a = `expr $a`"

le=$((a - 2))

#echo "last elemnt  $a -1 = $le"

for ((  b = 0 ;  b < $a; b++))
do
    	
	
	if test $b -eq $le
	 then 
          echo $'\t'$'\t'"{\"result\":\"${arr[++b]}\", \"confidence\":${arr[--b]}}"
	  break	
	fi
	 echo  $'\t'$'\t'"{\"result\":\"${arr[++b]}\", \"confidence\":${arr[--b]}},"
         ((++b))
done

echo     $'\t'\]\,
echo     $'\t'\"error\"\:\"\" 
echo \} 

