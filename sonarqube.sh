#!/bin/bash

# Create a Docker network
docker network create sonarnet

# Run PostgreSQL container
docker run -d --name postgres \
  --network sonarnet \
  -e POSTGRES_USER=sonar \
  -e POSTGRES_PASSWORD=sonar \
  -e POSTGRES_DB=sonarqube \
  postgres:15

# Run SonarQube container
docker run -d --name sonarqube \
  -p 9000:9000 \
  --network sonarnet \
  -e SONAR_JDBC_URL=jdbc:postgresql://postgres:5432/sonarqube \
  -e SONAR_JDBC_USERNAME=sonar \
  -e SONAR_JDBC_PASSWORD=sonar \
  -e SONAR_ES_BOOTSTRAP_CHECKS_DISABLE=true \
  sonarqube:lts
