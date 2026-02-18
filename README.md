# Night Shift

A tiny Windows system tray app that turns off your monitors and keeps your machine awake.

Built for those nights when you need your PC running (long downloads, overnight builds, agents working) but want to sleep in a dark room.

![Windows](https://img.shields.io/badge/platform-Windows-blue)
![.NET Framework](https://img.shields.io/badge/.NET%20Framework-4.x-purple)
![License](https://img.shields.io/badge/license-MIT-green)

## Features

- **System tray app** with a crescent moon icon
- **Left-click** the tray icon to instantly turn off monitors
- **Keep System Awake** toggle prevents Windows from sleeping
- **Monitors Off + Stay Awake** combo mode for bedtime
- Monitors wake up when you move the mouse or press a key
- Zero dependencies, single `.exe`, ~10KB

## Download

Grab `NightShift.exe` from the [latest release](../../releases/latest).

## Usage

1. Run `NightShift.exe`
2. A crescent moon icon appears in your system tray
3. Right-click for options:
   - **Turn Off Monitors** - just the monitors
   - **Keep System Awake** - toggleable, prevents sleep
   - **Monitors Off + Stay Awake** - the bedtime combo
   - **Exit** - restores normal power settings and quits
4. Left-click the icon anytime to quickly turn monitors off

## How It Works

- Monitor control via Win32 `SendMessage` with `SC_MONITORPOWER`
- Sleep prevention via `SetThreadExecutionState` with `ES_CONTINUOUS | ES_SYSTEM_REQUIRED`
- No polling, no background threads, minimal resource usage

## Building from Source

Requires .NET Framework 4.x (included with Windows).

```
csc.exe /target:winexe /r:System.Windows.Forms.dll /r:System.Drawing.dll /out:NightShift.exe NightShift.cs
```

Or using the full path to the compiler:

```
C:\Windows\Microsoft.NET\Framework64\v4.0.30319\csc.exe /target:winexe /r:System.Windows.Forms.dll /r:System.Drawing.dll /out:NightShift.exe NightShift.cs
```

## License

MIT
