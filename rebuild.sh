#!/usr/bin/env bash

nixos-rebuild switch --flake $1 --use-remote-sudo --verbose