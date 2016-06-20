#!/usr/bin/env bats

@test "openstreetmap-cgimap service is started" {
  run service cgimap status
  [[ ${lines[2]} =~ "active (running)" ]]
}

@test "PID file has been created" {
  run stat /var/run/web/cgimap.pid
  [ "$status" -eq 0 ]
}
