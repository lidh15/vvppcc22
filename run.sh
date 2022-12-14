mkdir -p results data/test
rm -f GUEST.log HOST.log
docker exec GUEST sh -c "cd /workspace && sh guest.before.sh > GUEST.log"
docker exec HOST sh -c "cd /workspace && sh host.sh > HOST.log"
docker exec GUEST sh -c "cd /workspace && sh guest.after.sh >> GUEST.log"
echo "workflow finished."
echo "please check GUEST.log and HOST.log for log and evaluation results"
echo "please check `pwd`/vvppcc22-master/results/result.csv for prediction results"
