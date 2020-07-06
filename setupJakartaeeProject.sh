#!/bin/bash

if [ "$#" -ne 2 ]; then
    echo "Please specify the artifactId and the groupId."
    exit 1
fi
artifactId="$1"
groupId="$2"
echo "artifactId=$artifactId groupId=$groupId"
scriptPath="$( cd "$( dirname "${BASH_SOURCE[0]}" )" >/dev/null 2>&1 && pwd )"

# main
mkdir -p $artifactId/$artifactId/src/main
mkdir -p $artifactId/$artifactId/src/main/java/$groupId/service/ping/boundary
mkdir -p $artifactId/$artifactId/src/main/resources/META-INF
mkdir -p $artifactId/$artifactId/src/main/webapp

cp $scriptPath/main_pom.xml $artifactId/$artifactId/pom.xml
cp $scriptPath/JAXRSConfiguration.java $artifactId/$artifactId/src/main/java/$groupId
cp $scriptPath/PingResource.java $artifactId/$artifactId/src/main/java/$groupId/service/ping/boundary
cp $scriptPath/beans.xml $artifactId/$artifactId/src/main/webapp
cp $scriptPath/microprofile-config.properties $artifactId/$artifactId/src/main/resources/META-INF

# test 
mkdir -p $artifactId/$artifactId-st/src/test
mkdir -p $artifactId/$artifactId-st/src/test/java/$groupId/service/ping/boundary
mkdir -p $artifactId/$artifactId-st/src/test/resources

cp $scriptPath/test_pom.xml $artifactId/$artifactId-st/pom.xml
cp $scriptPath/PingResourceClient.java $artifactId/$artifactId-st/src/test/java/$groupId/service/ping/boundary
cp $scriptPath/PingResourceIT.java $artifactId/$artifactId-st/src/test/java/$groupId/service/ping/boundary

# determine OS
UNAME=$(uname)
if [[ "$UNAME" == "Linux" || "$UNAME" == "Darwin" ]] ; then
  find . -name '*.java' -print0 | xargs -0 sed -i "" "s/\[artifactId\]/$artifactId/g"
  find . -name '*.java' -print0 | xargs -0 sed -i "" "s/\[groupId\]/$groupId/g"
  find . -name '*.xml' -print0 | xargs -0 sed -i  "" "s/\[artifactId\]/$artifactId/g"
  find . -name '*.xml' -print0 | xargs -0 sed -i  "" "s/\[groupId\]/$groupId/g"
elif [[ "$UNAME" == CYGWIN* || "$UNAME" == MINGW* ]] ; then
  # windows 10 gitbash
  # find . -type f -name "*.nfo" -exec sed -i'' -e 's/2019/2018/g' {} +
  find . -type f -name "*.java"  -exec sed -i'' -e 's/\[artifactId\]/$artifactId/g' {} +
  find . -type f -name "*.java"  -exec sed -i'' -e 's/\[groupId\]/$groupId/g'       {} +
  find . -type f -name "*.xml"   -exec sed -i'' -e 's/\[artifactId\]/$artifactId/g' {} +
  find . -type f -name "*.xml"   -exec sed -i'' -e 's/\[groupId\]/$groupId/g'       {} +
fi

echo "JakartaEE/microprofile project $groupId.$artifactId created."
exit 0
