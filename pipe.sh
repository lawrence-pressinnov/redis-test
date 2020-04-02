#!/bin/bash

#
# docker exec -it redis-test_redis_1 bash /app/pipe.sh /app/user100.txt
#
cat $1 | redis-cli --pipe