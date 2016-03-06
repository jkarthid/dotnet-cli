#
# Copyright (c) .NET Foundation and contributors. All rights reserved.
# Licensed under the MIT license. See LICENSE file in the project root for full license information.
#

COMMONSOURCE="${BASH_SOURCE[0]}"
while [ -h "$SOURCE" ]; do # resolve $SOURCE until the file is no longer a symlink
  COMMONDIR="$( cd -P "$( dirname "$COMMONSOURCE" )" && pwd )"
  COMMONSOURCE="$(readlink "$COMMONSOURCE")"
  [[ $COMMONSOURCE != /* ]] && COMMONSOURCE="$COMMONDIR/$COMMONSOURCE" # if $SOURCE was a relative symlink, we need to resolve it relative to the path where the symlink file was located
done
COMMONDIR="$( cd -P "$( dirname "$COMMONSOURCE" )" && pwd )"

source "$COMMONDIR/_prettyprint.sh"

<<<<<<< HEAD
# TODO: Replace this with a dotnet generation
export TFM=dnxcore50
export REPOROOT=$(cd $COMMONDIR/../.. && pwd)
export OUTPUT_ROOT=$REPOROOT/artifacts/$RID
export STAGE1_DIR=$OUTPUT_ROOT/stage1
export STAGE1_COMPILATION_DIR=$OUTPUT_ROOT/stage1
export STAGE2_DIR=$OUTPUT_ROOT/stage2
export STAGE2_COMPILATION_DIR=$OUTPUT_ROOT/stage2
export HOST_DIR=$OUTPUT_ROOT/corehost
export TEST_BIN_ROOT="$REPOROOT/artifacts/tests"
export TEST_PACKAGE_DIR="$TEST_BIN_ROOT/packages"

export RELEASE_SUFFIX=dev
=======
# Other variables are set by the outer build script
>>>>>>> e13a23b120504b87fb2ab7765511fdae38dedbd4
export CHANNEL=$RELEASE_SUFFIX

[ -z "$DOTNET_INSTALL_DIR" ] && export DOTNET_INSTALL_DIR=$REPOROOT/.dotnet_stage0/$RID
[ -z "$DOTNET_CLI_VERSION" ] && export DOTNET_CLI_VERSION=0.1.0.0
[ -z "$DOTNET_ON_PATH" ] && export DOTNET_ON_PATH=$STAGE2_DIR && export PATH=$STAGE2_DIR/bin:$PATH
[ -z "$CONFIGURATION" ] && export CONFIGURATION=Debug

#TODO this is a workaround for a nuget bug on ubuntu. Remove
export DISABLE_PARALLEL=""
[[ "$RID" =~ "ubuntu" ]] && export DISABLE_PARALLEL="--disable-parallel"

unset COMMONSOURCE
unset COMMONDIR
