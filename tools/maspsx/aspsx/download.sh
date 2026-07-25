#/bin/sh

mkdir -p psyq

wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq3.3.tar.gz
tar xvzf psyq3.3.tar.gz -C psyq
wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq3.5.tar.gz
tar xvzf psyq3.5.tar.gz -C psyq
# wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq3.6.tar.gz
# tar xvzf psyq3.6.tar.gz -C psyq
wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq4.0.tar.gz
tar xvzf psyq4.0.tar.gz -C psyq
wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq4.1.tar.gz
tar xvzf psyq4.1.tar.gz -C psyq
wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq4.3.tar.gz
tar xvzf psyq4.3.tar.gz -C psyq
wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq4.4.tar.gz
tar xvzf psyq4.4.tar.gz -C psyq
wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq4.5.tar.gz
tar xvzf psyq4.5.tar.gz -C psyq
wget https://github.com/mkst/esa/releases/download/psyq-binaries/psyq4.6.tar.gz
tar xvzf psyq4.6.tar.gz -C psyq

rm *.tar.gz
