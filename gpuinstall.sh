#!/bin/bash
#这一行是表示使用 /bin/bash 作为脚本的解释器

distribution=$(. /etc/os-release;echo $ID$VERSION_ID)

curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.repo | sudo tee /etc/yum.repos.d/nvidia-docker.repo

yum install -y nvidia-container-toolkit

curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun

sudo systemctl start docker

docker pull registry.cn-shanghai.aliyuncs.com/tcc_public/aigc:stable

docker run --gpus all  -p 8888:8888 -p 7860:7860 -p 6666:22 \
-v /mydata/models/sd:/workspace/stable-diffusion-webui/models/Stable-diffusion \
-v /mydata/models/lora:/workspace/stable-diffusion-webui/models/Lora \
--name sd \
registry.cn-shanghai.aliyuncs.com/tcc_public/aigc:stable

watch -n 3 nvidia-smi