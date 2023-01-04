docker rmi -f $(docker images -f 'dangling=true' -q) > /dev/null 2>&1
