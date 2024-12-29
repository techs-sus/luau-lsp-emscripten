# for use in codespace
sudo apt remove -y --purge --auto-remove cmake

sudo apt update
sudo apt install -y software-properties-common lsb-release && \
sudo apt clean all

wget -O - https://apt.kitware.com/keys/kitware-archive-latest.asc 2>/dev/null | gpg --dearmor - | sudo tee /etc/apt/trusted.gpg.d/kitware.gpg >/dev/null

sudo apt-add-repository "deb https://apt.kitware.com/ubuntu/ $(lsb_release -cs) main"

sudo apt update
sudo apt install -y kitware-archive-keyring
sudo rm /etc/apt/trusted.gpg.d/kitware.gpg

sudo apt update
sudo apt install -y cmake

git clone https://github.com/emscripten-core/emsdk.git ~/emsdk

~/emsdk/emsdk install latest
~/emsdk/emsdk activate latest
source ~/emsdk/emsdk_env.sh

git clone https://github.com/JohnnyMorganz/luau-lsp lsp --recursive
cd lsp
sed -i -e 's/-Werror//g' CMakeLists.txt

mkdir build && cd build
emcmake cmake .. -DCMAKE_BUILD_TYPE=Release
cmake .. -DCMAKE_BUILD_TYPE=Release
cmake --build . --target Luau.LanguageServer.CLI --config Release