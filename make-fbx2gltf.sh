#!/bin/bash

cd /root
git clone https://github.com/facebookincubator/FBX2glTF.git
cd FBX2glTF
cmake -H. -Bbuild -DCMAKE_BUILD_TYPE=Release
make -Cbuild -j4 install

