# WPPCC 2022 TEE

## Definition

- guest: who provides data and requires model (甲方)
- host: who provides TEE, takes encrypted data and returns encrypted model (乙方)

## Not experients

- Do this:

    ```shell
    unzip ACTINN-PyTorch.zip
    mv ACTINN-PyTorch-main ACTINN-PyTorch
    unzip vvppcc22.zip
    # Suppose you have guest and host containers ready.
    docker exec -it guest bash
    > cd /workspace && sh guest.before.sh && exit
    docker exec -it host bash
    > cd /workspace && sh host.sh && exit
    docker exec -it guest bash
    > cd /workspace && sh guest.after.sh && exit
    ```

## Experiments

### Setup

- Build runtime environment with `Dockerfile.{host,guest}`:

    ```shell
    docker build . -f Dockerfile.host -t wppcc2022:host
    docker build . -f Dockerfile.guest -t wppcc2022:guest
    ```

- Let this directory be your `WORKDIR`:

    ```shell
    vim README.md  # you should see me now!
    export WORKDIR=`pwd`
    ```

### Guest

#### Preprocess data

- For guest, SGX is not provided, run the container with `docker run --rm --name guest -it -v $WORKDIR:/workspace -d wppcc2022:guest /bin/bash`
- Enter guest container and go to workspace.
- Run `gramine-sgx-gen-private-key` first.
- Install ACTINN-PyTorch via `pip3 install -e .` in ACTINN-PyTorch directory.
- You may want to have a different working directory from host, check `guest.before.sh`.
- **Make sure you've put your train.csv as well as test.csv in `data`**, go to `data` and run `sh preprocess.sh` and `sh pf-encrypt.sh`.
- If RA is not available, go to `results` and run `sh pf-encrypt.sh`.

#### After the model trained

- If RA is available, close the document, scripts here are working with RA not accessible.
- Go to `results` and run `sh pf-decrypt.sh` to reveal the trained model.
- Go outside and run `sh test.guest.sh` and you should see test summary printed.

### Host

#### Step 1: run without remote attestation

- Run a container with `docker run --rm --privileged --device /dev/sgx_enclave --device /dev/sgx_provision --name host -it -v $WORKDIR:/workspace -d wppcc2022:host /bin/bash`
- Enter host container and go to workspace.
- Run `gramine-sgx-gen-private-key` first.
- Install ACTINN-PyTorch via `pip3 install -e .` in ACTINN-PyTorch directory.
- Make sure `protobuf==3.20.0`.
- You may need to `apt install pkg-config`.
- Let `python.manifest.template.test` be `python.manifest.template` in this step!
- **Make sure you've put the preprocessed data in `data`** (this requirement is met by default because the host and the guest are mapping the same workspace).
- Firstly, run `make clean && make`, the manifest for gramine-direct should be made.
- Run `sh train.sh . direct /workspace workspace/data/test_steps /workspace/results` and you should see training summary printed, and model in `/workspace/results/`.
- Secondly, run `make clean && make SGX=1`, the manifest for gramine-sgx should be made.
- Run `sh train.sh . sgx /workspace workspace/data/test_steps /workspace/results` and you should see training summary printed, and model in `/workspace/results/` once again.

#### Step 2: run with remote attestation

- Make sure the environment preparation in Step 1 is done.
- Follow [gramine official PPML documentation](https://gramine.readthedocs.io/en/stable/tutorials/pytorch/index.html), get [gramine-1.3.1](https://github.com/gramineproject/gramine/releases/tag/v1.3.1) from github and build `ra-tls-*` CI-examples.
- If the CI-examples succeeded, close this document and follow official PPML tutorial.
- If the CI-examples failed, copy `wrap_key` from guest to host, rep run ``make clean && make WRAP_KEY=`hexdump -e '16/1 "%02x"' wrap_key` SGX=1`` to put the key into manifest without ra-tls.
- Run `sh train.sh . sgx /workspace workspace/data /workspace/results` and you should see training summary printed, and model in `/workspace/results/` once again.
- Run `sh test.sh . sgx /workspace workspace/data /workspace/results` and you should see test summary printed.
