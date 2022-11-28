cd gramine-1.3.1/CI-Examples/ra-tls-secret-prov
make app dcap RA_TYPE=dcap
cp gramine-1.3.1/CI-Examples/ra-tls-secret-prov/secret_prov_pf/server_dcap .
cp -R gramine-1.3.1/CI-Examples/ra-tls-secret-prov/ssl ./
./server_dcap wrap_key &