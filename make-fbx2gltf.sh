#!/bin/bash

cp -R /root/fbxsdk/* /usr

cd /root
git clone https://github.com/facebookincubator/FBX2glTF.git
cd FBX2glTF
cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=Release
make -Cbuild -j4 install

