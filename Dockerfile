FROM jenkins/inbound-agent

ENV OLDUSER=$(whoami)

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
RUN apt-get install -y unzip zip wget
USER jenkins
SHELL ["/bin/bash", "-c"]    
RUN curl -s "https://get.sdkman.io" | bash \
	&& source "$HOME/.sdkman/bin/sdkman-init.sh" \
	&& sdk install java 11.0.25-tem \
	&& sdk install java 17.0.13-tem \
	&& sdk install java 21.0.5-tem
