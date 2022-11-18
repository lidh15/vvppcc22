#!/bin/bash
if [ -f wrap_key ]; then
    echo "using wrap_key"
else
    echo "wrap_key not found"
    exit 0
fi
# why not use a loop...
gramine-sgx-pf-crypt encrypt -w wrap_key -i train.h5 -o encrypted/train.h5
gramine-sgx-pf-crypt encrypt -w wrap_key -i train_lab.csv -o encrypted/train_lab.csv
gramine-sgx-pf-crypt encrypt -w wrap_key -i test.h5 -o encrypted/test.h5
gramine-sgx-pf-crypt encrypt -w wrap_key -i test_lab.csv -o encrypted/test_lab.csv
gramine-sgx-pf-crypt encrypt -w wrap_key -i test/test.h5 -o encrypted/test/test.h5
gramine-sgx-pf-crypt encrypt -w wrap_key -i test/test_lab.csv -o encrypted/test/test_lab.csv
