#!/bin/bash
#
# docker exec -it redis-test_redis_1 bash /app/gen.sh 100 user /app/user100.txt
#




gen_redis_protocol() {
#
# License: MIT
# Author: Michael Weibel
#
	cmd=$1
	proto=""
	proto+="*"
	
	number_of_words=0
	byword=""
	for word in $cmd
	do
		number_of_words=$[number_of_words+1]
		byword+="$"
		byword+=${#word}
		byword+="\\r\\n"
		byword+=$word
		byword+="\\r\\n"
	done
	proto+=${number_of_words}
	proto+="\\r\\n"
	proto+=${byword}
	printf $proto
}
random_number() {
	nombre=$RANDOM
	let "nombre %= $1"
	echo "$nombre"
}
generate_inserts() {
	NBMAX=$1
	index=1

	while [ "$index" -le $NBMAX ]
	do
	  k=$(random_number 10)$(random_number 10)$(random_number 10)$(random_number 10)$(random_number 10)$(random_number 10)$(random_number 10)$(random_number 10)$(random_number 10)
	  command="SADD $2:$k"
	  first=$(random_number 100)
	  command+=" taxo_$first"

	  nb_p=$(random_number 20)
	  i=1
	  while [ "$i" -le $nb_p ]
	  do
	  	v=$(random_number 100)
	    command+=" taxo_$v"
	    let "i += 1"
	  done
	  #echo "$command"
	  gen_redis_protocol "$command"
	  let "index += 1"
	done
}

generate_inserts $1 $2 > $3