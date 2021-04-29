#!/usr/bin/env sh
candle src/aws-okta.wxs -dAwsOktaVer=${VER} -o "out/"
light -sval "out/aws-okta.wixobj" -o "out/aws-okta-${VER}.msi"
