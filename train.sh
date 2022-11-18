echo "bash train.sh work_dir sgx|direct actinn_dir data_dir result_dir"
export HDF5_USE_FILE_LOCKING="FALSE"
cd $1
gramine-$2 ./python $3/ACTINN-Pytorch/classify.py --data_prefix $4 --model_dir $5
