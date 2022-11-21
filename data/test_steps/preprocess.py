import pandas as pd
from sklearn.model_selection import train_test_split

target = "./"
raw = pd.read_csv("../train.csv")

train, test = train_test_split(raw, train_size=0.8)
train, valid = train_test_split(train, train_size=0.8)

y_train = train['label'].tolist()
X_train = train.drop('label', axis=1).transpose()
with open(f"{target}train_lab.csv", "w") as f:
    f.writelines([f"{k}\t{j}\n" for k, j in enumerate(y_train)])
X_train.to_hdf(f"{target}train.h5", key='dge', mode='w', complevel=3)

y_valid = valid['label'].tolist()
X_valid = valid.drop('label', axis=1).transpose()
with open(f"{target}test_lab.csv", "w") as f:
    f.writelines([f"{k}\t{j}\n" for k, j in enumerate(y_valid)])
X_valid.to_hdf(f"{target}test.h5", key='dge', mode='w', complevel=3)

y_test = test['label'].tolist()
X_test = test.drop('label', axis=1).transpose()
with open(f"{target}test/test_lab.csv", "w") as f:
    f.writelines([f"{k}\t{j}\n" for k, j in enumerate(y_test)])
X_test.to_hdf(f"{target}test/test.h5", key='dge', mode='w', complevel=3)
