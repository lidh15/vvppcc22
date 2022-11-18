#!/bin/bash
echo "preparing test steps"
python3 test_steps/preprocess.py
echo "preparing"
python3 preprocess.py
echo "copying"
# if [ -f test.csv ]; then
#     mv test.h5 test/
# fi
cp train.h5 test.h5
cp train_lab.csv test_lab.csv