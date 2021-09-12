FROM ubuntu:latest

RUN apt update && \
    apt install ca-certificates tzdata wget unzip && \
    wget -O proxypool-linux-amd64.zip https://github.com/jth445600/hello-world/raw/master/proxypool-linux-amd64/proxypool-linux-amd64.zip && \
    unzip proxypool-linux-amd64.zip && \
    chmod +x /proxypoolv0.7.3 && \
    sed -i "s/port:/port: $PORT/g" /config.yaml && \
    sed -i "s/127.0.0.1/$DOMAIN/g" /config.yaml && \
    rm -rf /var/cache/apk/* 
RUN cd /var && \
    swapoff /var/swap && \
    dd if=/dev/zero of=swap bs=1M count=2048 && \
    mkswap /var/swap && \
    swapon /var/swap
ENTRYPOINT ["/proxypoolv0.7.3", "-c", "/config.yaml"]
