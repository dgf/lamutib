#!/bin/bash
#
#
#

# install make dependencies
aptitude update
aptitude -y install build-essential libpcre3-dev libpq-dev
aptitude -y install luarocks postgresql

# get openresty
wget http://openresty.org/download/ngx_openresty-1.7.0.1.tar.gz
tar xzvf ngx_openresty-1.7.0.1.tar.gz
cd ngx_openresty-1.7.0.1

# configure build
./configure \
--with-http_postgres_module \
--with-luajit \
--without-http_autoindex_module \
--without-http_browser_module \
--without-http_fastcgi_module \
--without-http_geo_module \
--without-http_lua_upstream_module \
--without-http_map_module \
--without-http_memcached_module \
--without-http_memc_module \
--without-http_proxy_module \
--without-http_redis2_module \
--without-http_redis_module \
--without-http_scgi_module \
--without-http_split_clients_module \
--without-http_ssi_module \
--without-http_upstream_ip_hash_module \
--without-http_userid_module \
--without-http_uwsgi_module \
--without-lua51 \
--without-lua_redis_parser \
--without-lua_resty_mysql \
--without-lua_resty_redis \
--without-lua_resty_upstream_healthcheck

# make and install
make
sudo make install

# install lua webframework
sudo luarocks install lapis
sudo luarocks install moonscript
sudo luarocks install moonrocks

# create DB
sudo -u postgres psql -c "CREATE USER \"lamutib\" WITH ENCRYPTED PASSWORD 'SecreT';"
sudo -u postgres createdb -O "lamutib" "lamutib"

exit 0

#EOF

