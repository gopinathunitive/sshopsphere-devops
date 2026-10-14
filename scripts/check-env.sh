#!/usr/bin/env bash

set -u

echo "================================"
echo " ShopSphere Environment Audit"
echo "================================"

check_command() {
  local cmd="$1"

  if command -v "$cmd" >/dev/null 2>&1; then
    printf "[OK]      %s: " "$cmd"
    "$cmd" --version 2>/dev/null | head -n 1
  else
    printf "[MISSING] %s\n" "$cmd"
  fi
}

check_command git
check_command node
check_command npm
check_command docker

echo
echo "Checking Docker Compose..."

if command -v docker >/dev/null 2>&1 &&
   docker compose version >/dev/null 2>&1; then
  docker compose version
else
  echo "[MISSING or UNAVAILABLE] Docker Compose"
fi

echo
echo "Environment audit completed."
