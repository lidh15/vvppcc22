apt install pkg-config
cd /workspace/ACTINN-PyTorch
pip3 install -e .
pip3 install protobuf==3.20
gramine-sgx-gen-private-key -f
cd /workspace
sh prepare_dcap.sh
make clean
if [ -z `lsof -i:4433` ]
then
    cp python.manifest.template.nora python.manifest.template
    make WRAP_KEY=`hexdump -e '16/1 "%02x"' wrap_key` SGX=1
else
    echo "warning: dcap server is running doesn't mean dcap is available"
    echo "         you should make sure about that on your own"
    echo "         see https://github.com/gramineproject/gramine/issues/912"
    echo "         and https://github.com/gramineproject/gramine/issues/941"
    cp python.manifest.template.ra python.manifest.template
    make RA_TYPE=dcap SGX=1
    cd /
    ./restart_aesm.sh
    cd /workspace
fi
sh train.sh . sgx /workspace workspace/data /workspace/results
sh test.sh . sgx /workspace workspace/data /workspace/results
