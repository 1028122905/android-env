FROM registry.cn-guangzhou.aliyuncs.com/kenward/ubuntu:22.04
COPY ./ubuntu-2204-source.list /etc/apt/source.list
RUN apt update
#安装必需工具
RUN apt install wget clang cmake git ninja-build pkg-config libgtk-3-dev liblzma-dev libstdc++-12-dev -y
#安装解压工具
RUN apt install xz-utils -y
#设置工作目录
WORKDIR /development
#下载android sdk 命令行工具
RUN wget https://dl.google.com/android/repository/commandlinetools-linux-6609375_latest.zip
#安装zip解压工具
RUN apt install unzip -y
#解压
RUN unzip commandlinetools-linux-6609375_latest.zip && mkdir /development/android-sdk/cmdline-tools/latest -p &&  cp /development/tools/* /development/android-sdk/cmdline-tools/latest -r
#添加git全局安全目录
RUN git config --global --add safe.directory /development/flutter
#安装jdk11
RUN apt update && apt install openjdk-17-jdk -y
#设置PATH环境变量
ENV PATH="$PATH:/development/flutter/bin"
ENV PATH="$PATH:/development/android-sdk/cmdline-tools/latest/bin"
#安装android sdk; flutter配置adnroid sdk目录
RUN yes | sdkmanager --licenses && sdkmanager "build-tools;29.0.3" "platforms;android-29"
