
if [ -z $1 ]
then
    echo "no password found as first param"
    exit;
fi

if [ -z $2 ]
then
    echo "no host directory found as second param"
    exit;
fi

if [ -z $3 ]
then
    echo "no container directory found as third param"
    exit;
fi

clear && 
docker kill ssh; 
docker rm ssh; 
docker build -t ssh --build-arg passwd=$1 . && 
docker run -d -p 2222:22 --name ssh -v $2:$3 ssh && 
ssh -p 2222 root@localhost
