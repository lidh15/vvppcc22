unzip -u gramine-1.3.1.zip
cd gramine-1.3.1/CI-Examples/ra-tls-secret-prov
make app dcap RA_TYPE=dcap
cp -r ssl /workspace/
cd secret_prov_pf
cp wrap_key /workspace/
RA_TLS_ALLOW_DEBUG_ENCLAVE_INSECURE=1 \
RA_TLS_ALLOW_OUTDATED_TCB_INSECURE=1 \
./server_dcap wrap_key &
cd /workspace