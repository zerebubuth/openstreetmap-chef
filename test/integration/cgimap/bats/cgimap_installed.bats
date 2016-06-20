#!/usr/bin/env bats

@test "openstreetmap-cgimap binary is installed in PATH" {
  run which openstreetmap-cgimap
  [ "$status" -eq 0 ]
}
