
FROM phusion/baseimage:latest

LABEL maintainer="Liu Ding <liuding.ld@foxmail.com>"


# Set the locale
RUN apt-get clean && apt-get update && apt-get install -y locales

RUN DEBIAN_FRONTEND=noninteractive

ENV LANGUAGE=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LC_CTYPE=en_US.UTF-8
ENV LANG=en_US.UTF-8
ENV TERM xterm


####################################################
#  Tools
####################################################


RUN apt-get -y upgrade
RUN apt-get install -y wget curl git unzip


####################################################
#  Nodejs
####################################################
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN apt-get install -y nodejs


####################################################
#  Cordova
####################################################

RUN npm install -g cordova
RUN npm install -g plugman

RUN npm i -g cordova-android
RUN npm i -g cordova-ios


####################################################
#  JAVA
####################################################


RUN apt-get install -y openjdk-8-jdk


####################################################
#  Android
####################################################


ENV ANDROID_HOME /android
ENV PATH $PATH:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${ANDROID_HOME}/build-tools/28.0.3

RUN mkdir android && cd android && \
    wget --progress=bar:force "https://dl.google.com/android/repository/sdk-tools-linux-4333796.zip" -O tools.zip && \
    unzip tools.zip && rm tools.zip && \
    sdkmanager --list && \
    echo 'y' | sdkmanager "platform-tools" "platforms;android-28" "build-tools;28.0.3"


####################################################
#  Gradle
####################################################

ARG GRADLE_VERSION=4.10.3
ENV PATH $PATH:/opt/gradle/gradle-${GRADLE_VERSION}/bin

RUN mkdir /opt/gradle && cd /opt/gradle && \
    wget --progress=bar:force "https://downloads.gradle.org/distributions/gradle-${GRADLE_VERSION}-bin.zip" -O gradle.zip && \
    unzip gradle.zip && rm gradle.zip

