#!/bin/bash

mkdir cinco

for i in $(seq 5)
do
    mkdir cinco/dir${i}

    for j in $(seq 4)
    do
	touch cinco/dir${i}/arq${j}.txt

	for k in $(seq ${j})
	do
	    echo "${j}" >> cinco/dir${i}/arq${j}.txt
	done
    done
done
