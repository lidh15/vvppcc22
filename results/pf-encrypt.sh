#!/bin/bash
if [ -f /workspace/wrap_key ]; then
    echo "using wrap_key"
else
    echo "wrap_key not found"
    dd if=/dev/urandom of=wrap_key bs=16 count=1
    mv wrap_key /workspace
fi
protected=/workspace/results
# why not use a loop...
gramine-sgx-pf-crypt encrypt -w /workspace/wrap_key -i result.csv -o $protected/result.csv
gramine-sgx-pf-crypt encrypt -w /workspace/wrap_key -i model_epoch_5_iter_0.pth -o $protected/model_epoch_5_iter_0.pth
