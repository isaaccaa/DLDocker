# DLDocker

## 说明

这是一个本人自用的, 基于 [ufoym/deepo](https://github.com/ufoym/deepo) 的环境, 在这里安装了若干常用的软件及Python包:

软件:

* OpenSSH Server
* NeoVim
* iputils-ping
* libsndfile1

Python 包:

* inquirer
* jsonschem
* libros
* ric
* scip
* xmltodic
* streamli
* pytorch-lightning

Ubuntu 源与 pip 源均已替换为清华源.

同时还有一个一键安装 Ubuntu 常用软件的 shell 脚本, 可以方便进一步定制终端环境.

## 使用方法

### 安装 NVIDIA Container Toolkit

[NVIDIA Container Toolkit](https://github.com/NVIDIA/nvidia-docker)

### 构建Docker镜像

```shell
docker build -t isaac/ptl:v0 . --network host 
```

参数 `-t` 说明了镜像的名称, 由于构建过程中需要联网, 因此要设置网络 `--network host` .

### 启用容器

```shell
sudo docker run --gpus all -itd -p 10122:22 -v PATH1:PATH2 isaac/ptl:v0
```

要传入 `--gpus` 参数就可以让docker调用GPU了.

`-itd` 表明交互式、终端、后台

`-p xxx:22` 实现了一个端口映射, 将容器外的xxx端口映射到容器内的22, 用来实现SSH连接.

`-v DIR:DIR` 把容器外物理机的文件夹映射到容器内

### SSH连接容器

```shell
ssh root@ip -p port
```

默认密码是 `root`

### 进一步定制终端环境

在容器内的家目录下会看到一个 `install_ubuntu.sh` 运行它:

```
chmod +x ./install_ubuntu.sh
./install_ubuntu.sh
```
