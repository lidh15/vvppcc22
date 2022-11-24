#!/bin/bash
if [ -f /workspace/wrap_key ]; then
    echo "using wrap_key"
else
    echo "wrap_key not found"
    dd if=/dev/urandom of=wrap_key bs=16 count=1
    mv wrap_key /workspace
fi
protected=/workspace/data
# why not use a loop...
gramine-sgx-pf-crypt encrypt -w /workspace/wrap_key -i train.h5 -o $protected/train.h5
gramine-sgx-pf-crypt encrypt -w /workspace/wrap_key -i train_lab.csv -o $protected/train_lab.csv
gramine-sgx-pf-crypt encrypt -w /workspace/wrap_key -i test.h5 -o $protected/test.h5
gramine-sgx-pf-crypt encrypt -w /workspace/wrap_key -i test_lab.csv -o $protected/test_lab.csv
gramine-sgx-pf-crypt encrypt -w /workspace/wrap_key -i test/test.h5 -o $protected/test/test.h5
gramine-sgx-pf-crypt encrypt -w /workspace/wrap_key -i test/test_lab.csv -o $protected/test/test_lab.csv
