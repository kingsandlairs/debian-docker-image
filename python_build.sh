#!/bin/bash

apt-get update && apt-get upgrade

# fetch python
curl -O https://www.python.org/ftp/python/3.8.0/Python-3.8.0.tar.xz  

# untar python
tar -xf Python-3.8.0.tar.xz  

# enter in directory of python
cd Python-3.8.0

./configure --enable-optimizations

make && make altinstall
