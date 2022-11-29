echo -e "current directory `pwd`"
if [ -f code.tgz ]; then
    echo "code.tgz detected"
else
    echo "please put code.tgz in current directory"
    exit 0
fi

if [ -f wppcc2022.tgz ]; then
    echo "wppcc2022.tgz detected"
else
    echo "please put wppcc2022.tgz in current directory"
    exit 0
fi

if [ -f /data/tee/test.csv ]; then
    echo "/data/tee/test.csv detected"
    n=`wc -l /data/tee/test.csv`
    m=$((${n% *} - 2))
    if [ $m -lt 1 ]; then
        echo "/data/tee/test.csv should contain at least 2 test samples!"
        exit 0
    fi
else
    echo "please put test.csv in /data/tee"
    exit 0
fi

if [ -f /data/tee/test_lab.csv ]; then
    echo "/data/tee/test_lab.csv detected"
else
    echo "test_lab.csv not detected in /data/tee"
    echo "please put test_lab.csv in /data/tee if you need auto evaluation"
    echo "creating empty test_lab.csv..."
    n=`wc -l /data/tee/test.csv`
    m=$((${n% *} - 2))
    t="\t"
    for i in `seq $m`; do t=$t"\n\t"; done
    echo $t > /data/tee/test_lab.csv
fi

rm -rf ACTINN-PyTorch vvppcc22-master ACTINN-PyTorch-main.zip vvppcc22-master.zip
docker stop HOST GUEST
tar zxvf code.tgz
unzip ACTINN-PyTorch-main.zip
mv ACTINN-PyTorch-main ACTINN-PyTorch
unzip vvppcc22-master.zip
cp /data/tee/test.csv vvppcc22-master/data
cp /data/tee/test_lab.csv vvppcc22-master/data/test
docker load -i wppcc2022.tgz
docker run --rm -it -v `pwd`:/workspace --device /dev/sgx_enclave --device /dev/sgx_provision --name HOST -d wppcc2022 /bin/bash
docker run --rm -it -v `pwd`:/workspace --name GUEST -d wppcc2022 /bin/bash
docker ps
