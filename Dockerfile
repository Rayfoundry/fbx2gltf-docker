FROM amazonlinux:2

# Update yum repos
RUN yum update -y

# Install some yum packages
RUN yum install -y\
    git \
    tar \
    wget

# Install updated toolchain
RUN yum install -y \
    gcc \
    gcc-c++ \
    make

# Install and build cmake 3
RUN cd /root &&\
    wget https://cmake.org/files/v3.11/cmake-3.11.2.tar.gz &&\
    tar -xvzf cmake-3.11.2.tar.gz &&\
    cd cmake-3.11.2 &&\
    gcc --version &&\
    ./bootstrap &&\
    make &&\
    make install &&\
    cd .. &&\
    rm -Rf cmake-3.11.2 &&\
    rm -f cmake-3.11.2.tar.gz

ADD make-fbx2gltf.sh /root/make-fbx2gltf.sh
RUN chmod +x /root/make-fbx2gltf.sh

#Build FBX2glTF
ENTRYPOINT ["/bin/bash", "/root/make-fbx2gltf.sh"]

