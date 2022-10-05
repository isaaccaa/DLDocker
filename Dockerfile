# 从pytorch版镜像开始构建
FROM ufoym/deepo:pytorch-py38-cu113
RUN  pip config set global.index-url https://pypi.tuna.tsinghua.edu.cn/simple && \
		 /usr/local/bin/python -m pip install --upgrade pip && \
		 python -m pip --no-cache-dir install --upgrade \
		      inquirer \
					jsonschema\
					librosa\
					rich\
					scipy\
					xmltodict\
					streamlit\
					pytorch-lightning
# 安装SSH
RUN echo "deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal main restricted universe multiverse\n \
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-security main restricted universe multiverse \n \
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-updates main restricted universe multiverse\n	\
deb https://mirrors.tuna.tsinghua.edu.cn/ubuntu/ focal-backports main restricted universe multiverse\n"\
            > /etc/apt/sources.list        \
            && apt update && apt install -y \ 
			openssh-server \
			neovim \
			iputils-ping \
			libsndfile1 \
			&& apt clean \
			&& rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp* \
			&& echo "PermitRootLogin yes" >> /etc/ssh/sshd_config
RUN mkdir /var/run/sshd
RUN echo 'root:root' |chpasswd

COPY install_ubuntu.sh /root/
RUN chmod +x /root/install_ubuntu.sh

EXPOSE 22
CMD ["/usr/sbin/sshd","-D" ]
