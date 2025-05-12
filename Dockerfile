# 使用官方 Python 基础镜像
FROM python:3.11-slim

# 设置工作目录
WORKDIR /app

# 复制项目文件到容器中
COPY . /app

# 安装依赖
RUN pip install --upgrade pip && pip install -r docs/requirements.txt

# 暴露默认端口（如果需要）
EXPOSE 8080

# 设置默认启动命令
CMD ["mkdocs", "serve", "--dev-addr=0.0.0.0:8080"]