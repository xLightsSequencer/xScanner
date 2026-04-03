; -- xScanner_64bit.iss --
; Installer for xScanner standalone

#include "xScanner_common.iss"

[Setup]
ChangesEnvironment=yes
DisableDirPage=no
ArchitecturesAllowed=x64compatible
ArchitecturesInstallIn64BitMode=x64compatible

AppName={#MyTitleName}
AppVersion={#Year}.{#Version}{#Other}
DefaultDirName={commonpf64}\{#MyTitleName}{#Other}
DefaultGroupName={#MyTitleName}{#Other}
SetupIconFile=..\..\include\xScanner64.ico
UninstallDisplayIcon={app}\{#MyTitleName}.exe
Compression=lzma2
SolidCompression=yes
OutputDir=output
OutputBaseFilename={#MyTitleName}_{#Year}_{#Version}{#Other}

[Tasks]
Name: "desktopicon"; Description: "{cm:CreateDesktopIcon}"; GroupDescription: "Do you want to create desktop icon?"; Flags: checkablealone

[Files]
; xScanner
Source: "../../xScanner/x64/Release/xScanner.exe"; DestDir: "{app}"
Source: "../../include/xScanner64.ico"; DestDir: "{app}"; Flags: "ignoreversion"
Source: "../../xScanner/MacLookup.txt"; DestDir: "{app}"; Flags: "ignoreversion"

; libcurl
Source: "../../bin/libcurl-x64.dll"; DestDir: "{app}"; Flags: "ignoreversion"

; readmes and licenses
Source: "../../LICENSE"; DestDir: "{app}";

; VC++ Redistributable
Source: "vcredist/vc_redist.x64.exe"; DestDir: {tmp}; Flags: deleteafterinstall

[Icons]
Name: "{group}\xScanner"; Filename: "{app}\xScanner.EXE"; WorkingDir: "{app}"
Name: "{commondesktop}\xScanner"; Filename: "{app}\xScanner.EXE"; WorkingDir: "{app}"; Tasks: desktopicon; IconFilename: "{app}\xScanner64.ico";

[Run]
Filename: {tmp}\vc_redist.x64.exe; \
    Parameters: "/q /passive /norestart /Q:a /c:""msiexec /q /i vcredist.msi"""; \
    StatusMsg: "Installing VC++ Redistributables..."

Filename: "{app}\xScanner.exe"; Description: "Launch application"; Flags: postinstall nowait skipifsilent

[Registry]
Root: HKCU; Subkey: "Software\xScanner"; Flags: uninsdeletekey
