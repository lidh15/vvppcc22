cd /workspace/ACTINN-PyTorch
pip3 install -e .
gramine-sgx-gen-private-key
cd /workspace/vvppcc22-master/data
unzip train.zip
sh preprocess.sh
if [ -f test.csv ]; then
    sh pf-encrypt.sh
else
    cd test_steps
    sh ../pf-encrypt.sh
    cd ..
fi
cd ../results
sh pf-encrypt.sh
