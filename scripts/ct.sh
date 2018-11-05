#!/bin/sh

IP=$(ip addr | grep 192 |awk -F"/" '{print $1}'|awk '{print $2}')
testDIR=".cover"

if [ ! -d $testDIR ] ; then
    mkdir $testDIR
fi

go test ./... -failfast -coverprofile=$testDIR/cover.profile
if [ $? != 0 ]; then
    echo ""
    echo -e "\033[31munittest failed, fix it first\033[0m"
    exit 1
fi
go tool cover -html=$testDIR/cover.profile -o $testDIR/cover.html

cd $testDIR

echo ""
echo -e "\033[32mLaunching browser on $IP:8000/cover.html \033[0m"
echo ""
python -m SimpleHTTPServer 8000 >/dev/null
