# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

xScanner is a network scanner for lighting controllers. It discovers and identifies lighting hardware on the network using multiple protocols (E1.31, Art-Net, DDP, etc.) and can query controller capabilities.

Built on wxWidgets 3.3 (custom fork). Part of the xLights family of tools.

**Supported platforms:** Linux (Debian 12 / Ubuntu 24.04), Windows 10+.

## Build Commands

### Linux
```bash
make                          # Full build (wxWidgets + xScanner)
make debug                    # Debug build
make clean                    # Clean all
# Output binary goes to bin/
```

Build uses Code::Blocks .cbp project files converted to makefiles via cbp2make. Object files go to `.objs_debug/` or `.objs_release/`.

### Windows
Open `xScanner/xScanner.sln` in Visual Studio 2022 and build Release x64. wxWidgets must be cloned as a sibling directory (`../../wxWidgets/`).

Or use the build script:
```cmd
cd build_scripts\msw
call build_xScanner_x64.cmd
```

### wxSmith Generated Code
Some dialogs use wxSmith (wxWidgets RAD tool). Generated code is delimited by `//(* ... //*)` guards in `.cpp`/`.h` files. **Any changes within these guards MUST also be reflected in the corresponding `.wxs` file**. Otherwise the changes will be overwritten the next time the `.wxs` file is opened in wxSmith.

wxSmith files in this repo:
- `xScanner/wxsmith/xScannerframe.wxs`

### Adding New Source Files
When adding new `.cpp`/`.h` files, the following project files must be updated manually:
- **`xScanner/xScanner.cbp`** — add `<Unit filename="...">` entries (used by Linux build via cbp2make)
- **`xScanner/xscanner.vcxproj`** — add `<ClCompile>` for `.cpp` and `<ClInclude>` for `.h`
- **`xScanner/Xscanner.vcxproj.filters`** — add corresponding filter entries

### Compiler Defines
xScanner requires these defines to compile shared code correctly:
- `EXCLUDENETWORKUI` — disables network UI features not needed for scanning
- `DISCOVERYONLY` — limits shared output code to discovery functionality only
- `XSCANNER` — conditional compilation flag for xScanner-specific behavior
- `NOMINMAX` — prevents Windows min/max macro conflicts

## Repository Structure

- **`xScanner/`** — application source files (scanner, MAC lookup, network scan workers)
- **`xLights/outputs/`** — all output protocol implementations (ArtNet, E131, DDP, DMX, LOR, etc.)
- **`xLights/controllers/`** — controller hardware handlers (Falcon, FPP, Pixlite)
- **`xLights/automation/`** — automation/scripting support
- **`xLights/utils/`** — shared utility code (networking, strings, curl, job pool)
- **`xLights/ui/`** — shared UI utilities, discovery, export settings
- **`common/`** — base application framework (crash handling)
- **`xSchedule/wxJSON/`** — JSON parsing library (includes jsonwriter)
- **`include/`** — shared headers (globals.h, log.h), icon assets, nlohmann/json
- **`dependencies/`** — pugixml (submodule), spdlog (submodule), stb image headers

### Runtime Assets
- `xScanner/MacLookup.txt` — MAC address vendor database (must be installed alongside the binary)

## Code Style

- C++20/C++23 with GNU extensions (`-std=gnu++20` on Linux, `stdcpp23` on Windows)
- 4-space indentation, no tabs
- No column limit (ColumnLimit: 0)
- Opening braces on same line (K&R style)
- Match the style of nearby code
- Avoid purely cosmetic changes in PRs

## Prefer std::* Over wx* Types

- **Strings**: Use `std::string` instead of `wxString`. Convert at wx API boundaries with `.ToStdString()` / `wxString(str)`.
- **Collections**: Use `std::vector`, `std::map`, etc. instead of `wxArrayString`, `wxList`, etc.
- **Exceptions**: Do NOT use `std::stoi`, `std::stol`, `std::stod` — they throw on invalid input. Use `std::strtol`, `std::strtod` instead.
- **File existence checks**: Use `FileExists()` from `ExternalHooks.h` instead of `std::filesystem::exists()`.

## Key Dependencies

wxWidgets 3.3 (custom fork `xLightsSequencer/wxWidgets`), spdlog, libcurl, pugixml, nlohmann/json.
