echo "sh train.sh work_dir sgx|direct actinn_dir data_dir result_dir"
echo "e.g. sh train.sh code/test_steps sgx /workspace workspace/data/encrypted /workspace"
export HDF5_USE_FILE_LOCKING="FALSE"
cd $1
chown -R root:root /$4/
gramine-$2 ./python $3/ACTINN-PyTorch/classify.py --data_prefix $4 --model_dir $5
