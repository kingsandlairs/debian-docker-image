git clone --recurse-submodules https://github.com/maemo-leste/image-builder.git
cd image-builder/arm-sdk
./init.sh   # (only needed on first run)
zsh -f
source sdk
load devuan DEVICE_NAME maemo
build_image_dist
