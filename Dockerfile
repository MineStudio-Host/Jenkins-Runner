FROM jenkins/inbound-agent

# Install Gradle
USER root
RUN apt-get update && apt-get install -y wget unzip
RUN wget https://services.gradle.org/distributions/gradle-8.13-milestone-2-bin.zip -P /tmp \
	&& unzip -d /opt/gradle /tmp/gradle-8.13-milestone-2-bin.zip \
	&& rm /tmp/gradle-8.13-milestone-2-bin.zip

# Set Gradle environment variables
ENV GRADLE_HOME /opt/gradle/gradle-8.13-milestone-2
ENV PATH $GRADLE_HOME/bin:$PATH

# Install Maven
RUN wget https://dlcdn.apache.org/maven/maven-3/3.9.9/binaries/apache-maven-3.9.9-bin.zip -P /tmp \
	&& unzip -d /opt/maven /tmp/apache-maven-3.9.9-bin.zip \
	&& rm /tmp/apache-maven-3.9.9-bin.zip

# Set Maven environment variables
ENV MAVEN_HOME /opt/maven/apache-maven-3.9.9
ENV PATH $MAVEN_HOME/bin:$PATH

# Install Java 11, 17, 21
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update \
	&& apt-get install -y openjdk-11-jdk \
	&& apt-get install -y openjdk-17-jdk \
	&& apt-get install -y openjdk-21-jdk