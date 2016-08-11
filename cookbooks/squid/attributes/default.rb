# Add the openstreetmap PPA for custom squid packages
default[:apt][:sources] = node[:apt][:sources] | ["openstreetmap"]

default[:squid][:cache_mem] = "256 MB"
default[:squid][:cache_dir] = "ufs /var/spool/squid 256 16 256"
default[:squid][:access_log] = "/var/log/squid/access.log squid"
