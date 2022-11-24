apt install pkg-config
cd /workspace/ACTINN-PyTorch
pip3 install -e .
pip3 install protobuf==3.20
gramine-sgx-gen-private-key
cd /workspace
make clean
make WRAP_KEY=`hexdump -e '16/1 "%02x"' wrap_key` SGX=1
sh train.sh . sgx /workspace workspace/data /workspace/results
sh test.sh . sgx /workspace workspace/data /workspace/results
