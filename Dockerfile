# 使用官方 Python 基础镜像
FROM dockerpull.cn/python:3.11-slim

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

# 安装依赖，使用清华 PyPI 镜像源
RUN pip install --upgrade pip -i https://pypi.tuna.tsinghua.edu.cn/simple \
    && pip install -r docs/requirements.txt -i https://pypi.tuna.tsinghua.edu.cn/simple

# 暴露默认端口（如果需要）
EXPOSE 8080

# 设置默认启动命令
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8080"]

