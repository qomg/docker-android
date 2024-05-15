FROM ubuntu:22.04

RUN apt-get update
RUN apt-get install -y unzip
RUN apt-get install -y zip
RUN apt-get install -y git
RUN apt-get install -y curl

# RUN apt-get install -y --no-install-recommends openjdk-8-jdk
# RUN apt-get install -y --no-install-recommends openjdk-11-jdk
RUN apt-get install -y --no-install-recommends openjdk-17-jdk

ENV JAVA_HOME="/usr/lib/jvm/java-17-openjdk-amd64"
ENV PATH="$JAVA_HOME/bin:$PATH"
RUN java --version

# Install Gradle command line tools

# Install Android SDK

ENV ANDROID_HOME="/opt/android-sdk" 
ENV ANDROID_SDK_HOME="$ANDROID_HOME" 
ENV ANDROID_SDK_ROOT="$ANDROID_HOME" 
ENV ANDROID_NDK="$ANDROID_HOME/ndk/latest" 
ENV ANDROID_NDK_ROOT="$ANDROID_NDK"
ENV ANDROID_NDK_HOME="$ANDROID_NDK"
ENV ANDROID_SDK_MANAGER="${ANDROID_HOME}/cmdline-tools/latest/bin/sdkmanager"

RUN curl -o sdk-tools.zip https://dl.google.com/android/repository/commandlinetools-linux-9477386_latest.zip

RUN mkdir --parents "$ANDROID_HOME"
RUN unzip -q sdk-tools.zip
RUN mkdir --parents "$ANDROID_HOME/cmdline-tools/latest"
RUN mv cmdline-tools/* "$ANDROID_HOME/cmdline-tools/latest"
RUN rm --force sdk-tools.zip

ENV PATH="$ANDROID_HOME/emulator:$ANDROID_HOME/cmdline-tools/latest/bin:$ANDROID_HOME/tools:$ANDROID_HOME/platform-tools:$PATH"

RUN mkdir --parents "$ANDROID_HOME/.android/"
RUN	echo '### User Sources for Android SDK Manager' > "$ANDROID_HOME/.android/repositories.cfg"

RUN yes | "$ANDROID_SDK_MANAGER" "platforms;android-33"
RUN yes | "$ANDROID_SDK_MANAGER" "platforms;android-32"
RUN yes | "$ANDROID_SDK_MANAGER" "platforms;android-31"
RUN yes | "$ANDROID_SDK_MANAGER" "platforms;android-30"
# RUN yes | "$ANDROID_SDK_MANAGER" "platforms;android-29"
# RUN yes | "$ANDROID_SDK_MANAGER" "platforms;android-28"
# RUN yes | "$ANDROID_SDK_MANAGER" "platforms;android-27"
# RUN yes | "$ANDROID_SDK_MANAGER" "platforms;android-26"

RUN yes | "$ANDROID_SDK_MANAGER" "build-tools;33.0.0"
RUN yes | "$ANDROID_SDK_MANAGER" "build-tools;32.0.0"
RUN yes | "$ANDROID_SDK_MANAGER" "build-tools;31.0.0"
RUN yes | "$ANDROID_SDK_MANAGER" "build-tools;30.0.3"

RUN yes | "$ANDROID_SDK_MANAGER" --licenses

ENTRYPOINT ["tail", "-f", "/dev/null"]