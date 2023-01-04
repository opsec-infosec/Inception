docker rm $(docker ps --filter status=exited -q) > /dev/null 2>&1
