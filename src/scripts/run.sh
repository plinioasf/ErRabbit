#!/usr/bin/env bash
# ErRabit Run Script

settingLocation="settings.properties";
java -jar ErRabbitServer-1.0.0-SNAPSHOT2.war --spring.config.location=file:$settingLocation
