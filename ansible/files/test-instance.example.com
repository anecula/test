server {
  listen *:80;
  server_name test-instance.example.com;

  access_log  off;
  error_log   /var/log/nginx/https_redirect-error.log notice;

  root /var/www/html;
  index index.html index.htm index.nginx-debian.html;

   location / {
                try_files $uri $uri/ =404;
        }

}
