#!/bin/bash

cd /usr/local
curl -L https://dl.dagger.io/dagger/install.sh | sh

git clone https://github.com/dagger/todoapp
cd todoapp
dagger project update
dagger do build
