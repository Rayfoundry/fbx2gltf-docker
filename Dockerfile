FROM centos:centos6

# Update yum repos
RUN yum update -y

# Install some yum packages
RUN yum install -y\
    git \
    wget

# Install and build cmake 3
RUN yum install -y gcc-c++ &&\
    cd /root &&\
    wget https://cmake.org/files/v3.10/cmake-3.10.0.tar.gz &&\
    tar -xvzf cmake-3.10.0.tar.gz

# Install gcc 4.8
RUN wget http://people.centos.org/tru/devtools-2/devtools-2.repo -O /etc/yum.repos.d/devtools-2.repo &&\
    yum install devtoolset-2-gcc devtoolset-2-binutils &&\
    yum install devtoolset-2-gcc-c++

RUN cd cmake-3.10.0 &&\
    ./bootstrap &&\
    make &&\
    make install &&\
    cd .. &&\
    rm -Rf cmake-3.10.0 &&\
    rm -f cmake-3.10.0.tar.gz

# Build FBX2glTF
RUN cd /root &&\
    git clone https://github.com/facebookincubator/FBX2glTF.git &&\
    cd FBX2glTF &&\
    cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=Release &&\
    make -Cbuild -j4 install

#WORKDIR root/FBX2glTF

#CMD ls