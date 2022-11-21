echo "bash test.sh work_dir sgx|direct actinn_dir data_dir result_dir"
export HDF5_USE_FILE_LOCKING="FALSE"
cd $1
gramine-$2 ./python $3/ACTINN-PyTorch/classify.py \
    --predict $4/test/test.h5 \
    --result $5/result.csv \
    --pretrained $5/LASTmodel_epoch_5_iter_0.pth
gramine-$2 ./python $3/ACTINN-PyTorch/evaluate.py $5/result.csv $5/test_lab.csv
