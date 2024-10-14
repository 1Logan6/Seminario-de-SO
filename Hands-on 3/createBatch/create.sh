#!/bin/bash

echo "Hola mundo" > mytext
cat mytext
mkdir backup
mv mytext backup/
ls backup
rm backup/mytext
rmdir backup
