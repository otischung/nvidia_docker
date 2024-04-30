FROM ros:humble-ros-base
ARG TARGETPLATFORM

WORKDIR /tmp

RUN apt update && \
    apt -y upgrade && \
    apt -y install wget axel curl ncdu gcc g++ make cmake git python3-pip python3-venv && \
    apt -y autoremove && \
    apt -y autoclean && \

##### Nvidia cuda installation #####
# cuda toolkit 12.4 Update 1
    if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        echo "Install cuda in amd64." >> log.txt && \
        axel -n 20 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
        dpkg -i cuda-keyring_1.1-1_all.deb && \
        apt update && \
        apt -y install cuda-toolkit-12-4; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        echo "Install cuda in arm64." >> log.txt && \
        axel -n 20 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/arm64/cuda-keyring_1.1-1_all.deb && \
        dpkg -i cuda-keyring_1.1-1_all.deb && \
        apt update && \
        apt -y install cuda-toolkit-12-4 cuda-compat-12-4; \
    else \
        echo "Error when installing cuda 12.4 update 1!!!" >> log.txt; \
    fi && \

# cudnn 9.1.0
    if [ "$TARGETPLATFORM" = "linux/amd64" ]; then \
        echo "Install cudnn in amd64." >> log.txt && \
        axel -n 20 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/x86_64/cuda-keyring_1.1-1_all.deb && \
        dpkg -i cuda-keyring_1.1-1_all.deb && \
        apt update && \
        apt -y install cudnn-cuda-12; \
    elif [ "$TARGETPLATFORM" = "linux/arm64" ]; then \
        echo "Install cudnn in arm64." >> log.txt && \
        axel -n 20 https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2204/arm64/cuda-keyring_1.1-1_all.deb && \
        dpkg -i cuda-keyring_1.1-1_all.deb && \
        apt update && \
        apt -y install cudnn-cuda-12; \
    else \
        echo "Error when installing cudnn 9.1.0!!!" >> log.txt; \
    fi && \

# python pip
    pip3 install --no-cache-dir --upgrade pip && \
    pip3 install --no-cache-dir torch torchvision torchaudio && \

# Clear tmp
    rm -rf /tmp/*

# Add nvcc to PATH
ENV PATH="$PATH:/usr/local/cuda/bin"

WORKDIR /
CMD ["/bin/bash", "-l"]
