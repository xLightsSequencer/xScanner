# xScanner

xScanner is a network scanner for lighting controllers. It discovers and identifies lighting hardware on your network, including controllers that support E1.31 (sACN), Art-Net, DDP, and other protocols. It can query controller capabilities and export configuration data.

xScanner is part of the [xLights](https://github.com/xLightsSequencer/xLights) family of tools for holiday and entertainment lighting.

## Features

- Discover lighting controllers on the network via multiple protocols
- Identify controller type, firmware version, and capabilities
- Support for Falcon, FPP, Pixlite, and other controller hardware
- MAC address lookup for device identification
- Export discovered configuration
- Network scanning with configurable IP ranges

## Building

### Linux

```bash
# Install dependencies (Ubuntu/Debian)
sudo apt-get install g++ build-essential libgtk-3-dev libgstreamer1.0-dev \
    libgstreamer-plugins-base1.0-dev freeglut3-dev libcurl4-openssl-dev \
    libexpat1-dev libwebp-dev cbp2make

# Build (downloads wxWidgets automatically if not installed)
make -j$(nproc)

# Install
sudo make install
```

### Windows

1. Clone [wxWidgets](https://github.com/xLightsSequencer/wxWidgets) (branch `xlights_2026.04`) as a sibling directory
2. Build wxWidgets with Visual Studio 2022
3. Open `xScanner/xScanner.sln` in Visual Studio 2022
4. Build Release x64

Or use the build script:
```cmd
cd build_scripts\msw
call build_xScanner_x64.cmd
```

## License

xScanner is licensed under the [GNU General Public License v3.0](LICENSE).
