# lamutib

Lapis multi tenancy instance blueprint

A memory aware approach for multi tenancy environments with a dedicated application instance and a database per customer.

## Requirements

 * [OpenResty][resty] web server
 * [Lapis][lapis] web framework
 * [PostgreSQL][postgres] database

## Usage

This setup isn't simple but stable and nearly plattform independent.

### Web server

Download [OpenResty][resty], unzip, compile and install it.
```sh
wget http://openresty.org/download/ngx_openresty-1.7.0.1.tar.gz
tar xzvf ngx_openresty-1.7.0.1.tar.gz
cd ngx_openresty-1.7.0.1
./configure
make
sudo make install
```

Configure [nginx][nginx] with [LuaJIT][luajit] compiler, [PostgreSQL][postgres] client and exclude unused modules.
```sh
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
```

### Web Framework

Install [LuaRocks][luarocks] and [MoonScript][moon]
```sh
sudo luarocks install lapis
sudo luarocks install moonscript
sudo luarocks install moonrocks
```

### Database

Download and install [PostgreSQL][postgres]

Create a database.
```sh
sudo su postgres
createdb lamutib
```

### Boot'em up

Clone this repo and step into it.
```sh
git clone https://github.com/dgf/lamutib
cd lamutib
```

Compile [MoonScript][moon] files to Lua.
```sh
moonc .
```

Build environment, run database migrations and start the server.
```sh
lapis build
lapis migrate
lapis server
```

Or start [nginx][nginx] without the wrapper.
```sh
/usr/local/openresty/nginx/sbin/nginx -p `pwd`/ -c nginx.conf.compiled
```

## Specifications

Install [busted][busted] testing environment.
```sh
sudo luarocks install busted 1.11.1-1
```

Run the specifications.
```sh
busted spec/rest.moon
```

And this is were *Lua rocks* really! It runs the entiry specification
with a complete walkthrough in less than one tenth of a second.
```sh
time busted spec/rest.moon

3 successes / 0 failures / 0 pending : 0.084445 seconds.

busted spec/rest.moon  0.05s user 0.02s system 56% cpu 0.127 total
```

## Benchmark

And now the interesting part of this blueprint.
The application runs with one master and one worker process and it
serves hundert of requests per second with under 30 MB of your RAM!
Try it out, load the `bench.jmx` file with [JMeter][jmeter] and fire it up.

 [busted]: http://olivinelabs.com/busted/
 [jmeter]: https://jmeter.apache.org/
 [lamutib]: https://github.com/dgf/lamutib
 [lapis]: http://leafo.net/lapis/
 [lua]: http://www.lua.org/
 [luajit]: http://luajit.org/
 [luarocks]: http://luarocks.org/
 [moon]: http://moonscript.org/
 [nginx]: http://wiki.nginx.org/Main
 [postgres]: http://www.postgresql.org/
 [resty]: http://openresty.org/
