import pandas as pd
import os

target = "./"
raw = pd.read_csv("train.csv")

y = raw["label"].tolist()
X = raw.drop(columns=["label"]).transpose()
with open(f"{target}train_lab.csv", "w") as f:
    f.writelines([f"{k}\t{j}\n" for k, j in enumerate(y)])
X.to_hdf(f"{target}train.h5", key='dge', mode='w', complevel=3)

if "test.csv" in os.listdir(target):
    print("test.csv found!")
    pd.read_csv(f"{target}test.csv").transpose().to_hdf(f"{target}test/test.h5",
                                                        key='dge',
                                                        mode='w',
                                                        complevel=3)
