echo "usage: sh test.guest.sh work_dir sgx|direct actinn_dir data_dir result_dir"
echo "e.g. sh test.guest.sh . sgx /workspace workspace/data/encrypted /workspace/results"
export HDF5_USE_FILE_LOCKING="FALSE"
cd $1
python3 $3/ACTINN-PyTorch/classify.py \
    --predict /$4/test/test.h5 \
    --result $5/result.csv \
    --pretrained $5/model_epoch_5_iter_0.pth
python3 $3/ACTINN-PyTorch/evaluate.py $5/result.csv /$4/test/test_lab.csv
