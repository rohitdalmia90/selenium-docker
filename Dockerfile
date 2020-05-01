FROM openjdk:8u191-jre-alpine3.8

RUN apk add curl jq

#workspace
WORKDIR /usr/share/project

#add jar under target from host
ADD target/selenium-docker.jar        selenium-docker.jar        
ADD target/selenium-docker-tests.jar  selenium-docker-tests.jar
ADD target/libs                       libs

#Add suite files
ADD book-flight-module.xml            book-flight-module.xml
ADD search-module.xml                 search-module.xml


#Add healthCheck Script
ADD healthCheck.sh                    healthCheck.sh

#ENTRYPOINT java -cp selenium-docker.jar:selenium-docker-tests.jar:libs/* -DBROWSER=$BROWSER -DHUB_HOST=$HUB_HOST org.testng.TestNG $MODULE

ENTRYPOINT sh healthCheck.sh