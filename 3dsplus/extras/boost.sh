#!/bin/bash
sleep 3
n=0
p1=$(pidof citra-qt | head -n 1)
pmax=$(($p1+100))
while [ "$n" -le "100" ]
do 
pid=$(($p1+$n))
renice -11 $pid 2>/dev/null
#echo $pid/$pmax
n=$(($n+1))
done

