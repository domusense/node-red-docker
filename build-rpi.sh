#if [ $# -ne 1 ]; then
#    echo $0: usage: build-rpi.sh NODE_RED_VERSION
#    exit 1
#fi

#NODE_RED_VERSION=$1

NODE_RED_VERSION=10.3.0

# Build docker image
docker build -f rpi/Dockerfile -t domu/nodered-rpi:0.18.7 .

if [ $? -ne 0 ]; then
    echo "ERROR: Docker build failed for rpi image"
    exit 1
fi

# User data volume 
docker volume create --name node_red_user_data

if [ $? -ne 0 ]; then
    echo "Cannot create volume for user data."
    exit 1
fi

docker run -d -p 1880:1880 -v node_red_user_data:/data --name nodered domu/nodered-rpi:0.18.7 

if [ $? -ne 0 ]; then
    echo "ERROR: Docker container failed to start for rpi build."
    exit 1
fi

# docker tag nodered/node-red-docker:rpi nodered/node-red-docker:$NODE_RED_VERSION-rpi

#if [ $? -ne 0 ]; then
#    echo "ERROR: Docker tag failed for rpi image"
#    exit 1
#fi

#docker run -d domu/nodered-rpi:0.18.7

#docker push nodered/node-red-docker:rpi

#if [ $? -ne 0 ]; then
#    echo "ERROR: Docker push failed for rpi image."
#    exit 1
#fi
#
#docker push nodered/node-red-docker:$NODE_RED_VERSION-rpi
#
#if [ $? -ne 0 ]; then
#    echo "ERROR: Docker push failed for rpi image."
#    exit 1
#fi
