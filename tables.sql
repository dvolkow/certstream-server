CREATE TABLE certs.domains
(
  `insert_time` DateTime DEFAULT now(),
  `domain` String,
 )
ENGINE = ReplacingMergeTree
ORDER BY (insert_time, domain)
SETTINGS index_granularity = 8192
