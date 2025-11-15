REPO_ROOT=$(cd "${scriptroot}";pwd)
SDK_PATH=$REPO_ROOT/artifacts/bin/dotnet-tests
if [ ! -x "$SDK_PATH/dotnet" ]; then
    echo "Error: Could not find dotnet at $SDK_PATH/dotnet"
    return
fi

CONFIG=$1
if [ -n "$CONFIG" ]; then
    PKG_DIR=$REPO_ROOT/artifacts/packages/$CONFIG/Shipping
    if [ ! -d "$PKG_DIR" ]; then
        echo "Error: Could not find packages path $PKG_DIR for CONFIG=$CONFIG"
        return
    fi
else
    PKG_DIR=$REPO_ROOT/artifacts/packages/Release/Shipping
    if [ ! -d "$PKG_DIR" ]; then
      PKG_DIR=$REPO_ROOT/artifacts/packages/Debug/Shipping
    fi
    if [ ! -d "$PKG_DIR" ]; then
        echo "Error: Could not find packages path in $REPO_ROOT/artifacts/packages for Release, or Debug configurations"
        return
    fi
fi

echo "Adding $SDK_PATH to \$PATH"
export PATH=$SDK_PATH:$PATH
echo Setting BUILT_NUGETS_PATH="$PKG_DIR" to resolve locally built packages
export BUILT_NUGETS_PATH=$PKG_DIR
echo
echo "Use $REPO_ROOT/tests/Shared/TemplatesTesting/data/nuget8.config as your local nuget.config to ensure the packages can be restored."
