config = require "lapis.config"

config { "development", "test", "production" }, ->
  port 8080
  num_workers 1
  worker_connections 7
  code_cache "off"
  postgresql_url "postgres://lamutib:SecreT@127.0.0.1/lamutib"

