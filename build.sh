#!/bin/bash

 docker build -f src/Dockerfile -t jkaninda/toolkit:latest .
 
 docker compose up -d

