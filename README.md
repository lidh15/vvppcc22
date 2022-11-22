# WPPCC 2022 TEE

## Definition

- guest: who provides data and requires model
- host: who provides TEE, takes encrypted data and returns encrypted model

## Experiments Setup

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

### Guest(甲方)

- For guest, SGX is not provided, run the container with `docker run --rm --name guest -it -v $WORKDIR:/workspace -d wppcc2022:guest /bin/bash`
- Enter guest container and go to workspace.
- **Make sure you've put your train.csv as well as test.csv in `data`**, go to `data` and run `sh preprocess.sh` and `sh pf-encrypt.sh`.


### Host(乙方)

#### Step 1: run without remote attestation

- Run a container with `docker run --rm --previleged --device /dev/sgx_enclave --device /dev/sgx_provision --name host1 -it -v $WORKDIR:/workspace -d wppcc2022:host /bin/bash`
- Enter host container and go to workspace.
- **Make sure you've put the preprocessed data in `data`** (this requirement is met by default because the host and the guest are mapping the same workspace).
- Firstly, run `make clean && make`, the manifest for gramine-direct should be made.
- Run `sh train.sh . direct /workspace workspace/data/test_steps /workspace/results` and you should see training summary printed, and model in `/workspace/results/`.
- Secondly, run `make clean && make SGX=1`, the manifest for gramine-sgx should be made.
- Run `sh train.sh . sgx /workspace workspace/data/test_steps /workspace/results` and you should see training summary printed, and model in `/workspace/results/` once again.

#### Step 2: run with remote attestation

- Follow gramine official PPML documentation, get [gramine-1.3.1](https://github.com/gramineproject/gramine/releases/tag/v1.3.1) from github and build `ra-tls-*` CI-examples.
- ?