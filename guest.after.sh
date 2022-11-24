cd /workspace/vvppcc22-master/results
sh pf-decrypt.sh
cd ..
if [ -f data/test.csv ]; then
    path=
else
    path=/test_steps
fi
sh test.guest.sh . sgx /workspace workspace/vvppcc22-master/data$path /workspace/vvppcc22-master/results
