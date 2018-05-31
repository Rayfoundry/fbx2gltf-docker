FROM nvidia/cudagl:9.0-runtime-centos7

# Update yum repos
RUN yum update -y

# Install some yum packages
RUN yum install -y\
    git \
    wget

# Install and build cmake 3
RUN yum install -y gcc-c++ \
    make &&\
    cd /root &&\
    wget https://cmake.org/files/v3.11/cmake-3.11.2.tar.gz &&\
    tar -xvzf cmake-3.11.2.tar.gz

#add newer gcc
RUN yum install -y \
    scl-utils \
    centos-release-scl &&\
    yum install -y devtoolset-7-gcc* &&\
    source /opt/rh/devtoolset-7/enable 

RUN source /opt/rh/devtoolset-7/enable &&\
    cd /root/cmake-3.11.2 &&\
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

