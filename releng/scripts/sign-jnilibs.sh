#!/bin/bash
###############################################################################
# Copyright (c) 2021 Kichwa Coders Canada Inc.
#
# This program and the accompanying materials
# are made available under the terms of the Eclipse Public License 2.0
# which accompanies this distribution, and is available at
# https://www.eclipse.org/legal/epl-2.0/
#
# SPDX-License-Identifier: EPL-2.0
###############################################################################

# To use this script, run it on a built jar to extract all .jnilib files, sign them
# and repack the file. 
#
# To activate jnilib signing for an orbit bundle, create a file in the project
# called eclipse-sign-jnilibs.properties to activate the eclipse-sign-jnilibs
# profile defined in the parent pom.

set -u # run with unset flag error so that missing parameters cause build failure
set -e # error out on any failed commands
set -x # echo all commands used for debugging purposes

JAR=$1
echo "Signing jnilibs in $JAR"
mkdir -p sign-jnilibs
cd sign-jnilibs
jar --extract --file=$JAR
for j in `find * -name \*\.jnilib`; do
    mv $j $j-tosign
    curl -o $j -F file=@$j-tosign https://cbi.eclipse.org/macos/codesign/sign
    rm $j-tosign
    jar --update --file=$JAR $j
done
