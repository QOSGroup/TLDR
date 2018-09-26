# Nginx


### 静态页面

```
    server {

        listen       80;
        server_name  tendermint.qos.com;

        location / {
            root   /usr/local/openresty/nginx/html/tendermint/docs;
            index  index.html index.htm;
        }
    }
```
