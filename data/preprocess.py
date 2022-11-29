import pandas as pd
import os
from sklearn.model_selection import train_test_split

target = "./"
raw = pd.read_csv("train.csv")
_, test = train_test_split(raw, train_size=0.9)

y = raw["label"].tolist()
X = raw.drop(columns=["label"]).transpose()
with open(f"{target}train_lab.csv", "w") as f:
    f.writelines([f"{k}\t{j}\n" for k, j in enumerate(y)])
X.to_hdf(f"{target}train.h5", key='dge', mode='w', complevel=3)

y = test["label"].tolist()
X = test.drop(columns=["label"]).transpose()
with open(f"{target}test_lab.csv", "w") as f:
    f.writelines([f"{k}\t{j}\n" for k, j in enumerate(y)])
X.to_hdf(f"{target}test.h5", key='dge', mode='w', complevel=3)

if "test.csv" in os.listdir(target):
    print("test.csv found!")
    pd.read_csv(f"{target}test.csv").transpose().to_hdf(f"{target}test/test.h5",
                                                        key='dge',
                                                        mode='w',
                                                        complevel=3)
