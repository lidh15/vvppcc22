FROM gramineproject/gramine:latest

RUN apt-get update && \
    apt-get install -y unzip python3-distutils bsdmainutils make gcc lsof vim && \
    apt-get clean

RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
python3 /tmp/get-pip.py && \
rm -rf /tmp/* && \
pip3 install --upgrade setuptools && \
pip3 install tables==3.7.0 pandas==1.5.2 scikit-learn==1.1.3 tqdm==4.47.0 numpy==1.23.5

ENV LC_ALL=C.UTF-8
ENV LANG=C.UTF-8
ENV PYTHONPATH=/usr/local/lib/python3.8/site-packages
