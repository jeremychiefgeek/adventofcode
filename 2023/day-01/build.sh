#!/bin/bash
dirname=build
mkdir -p -- "$dirname"
odin run . -out:build/day-01.exe
