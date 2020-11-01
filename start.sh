docker build -t anillc/obs . && \
docker run -v /root/obstest:/ooo -p 5900:5900 --rm -it anillc/obs
