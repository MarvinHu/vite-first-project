# 使用官方的Node.js镜像作为基础镜像
FROM node:14

# 设置工作目录
WORKDIR /app

# 复制 package.json 和 package-lock.json 到容器中
COPY package*.json ./

# 安装依赖
RUN npm ci

# 复制源代码到容器中
COPY . .

# 构建React应用
RUN npm run build

# 使用官方的Nginx镜像作为基础镜像
FROM nginx:1.21

# 将React应用的构建产物复制到Nginx镜像中
COPY --from=0 /app/build /usr/share/nginx/html

# 使用Nginx作为Web服务器并提供React应用
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]