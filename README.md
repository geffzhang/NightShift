# Night Shift

Let your AI agents work through the night while you sleep in a dark room.

A tiny Windows system tray app that turns off your monitors and keeps your machine awake — built for people running [Claude Code](https://docs.anthropic.com/en/docs/claude-code), [Claude Code Work](https://docs.anthropic.com/en/docs/claude-code), [OpenClaw](https://github.com/anthropics/openclaw), and other AI coding agents that need hours of uninterrupted runtime.

![Windows](https://img.shields.io/badge/platform-Windows-blue)
![.NET Framework](https://img.shields.io/badge/.NET%20Framework-4.x-purple)
![License](https://img.shields.io/badge/license-MIT-green)

## The Problem

You kick off a long-running AI agent session — a multi-file refactor, an overnight code generation task, a batch of Claude Code Work jobs — and you want to go to sleep. But if Windows puts your machine to sleep, your agents die mid-task. And if you leave the monitors on, your bedroom is lit up like a data center.

**Night Shift** solves both problems: monitors off, machine awake, agents keep running.

## Download

Grab `NightShift.exe` from the [latest release](../../releases/latest). No installation needed — just run it.

## Usage

1. Start your AI agents (Claude Code, OpenClaw, etc.)
2. Run `NightShift.exe`
3. A crescent moon icon appears in your system tray
4. Right-click and hit **Monitors Off + Stay Awake**
5. Go to sleep — your agents keep working, your room stays dark
6. Move your mouse in the morning to wake the monitors
7. Right-click the tray icon and hit **Exit** when you're done

### Tray Menu

- **Turn Off Monitors** — just the monitors
- **Keep System Awake** — toggleable, prevents Windows from sleeping
- **Monitors Off + Stay Awake** — the bedtime combo
- **Exit** — restores normal power settings and quits

**Tip:** Left-click the tray icon anytime to quickly turn monitors off again.

## Features

- Single `.exe`, ~10KB, zero dependencies
- No polling, no background threads, minimal resource usage
- Monitors wake instantly when you move the mouse or press a key
- Clean exit restores normal Windows power settings

## How It Works

- Monitor control via Win32 `SendMessage` with `SC_MONITORPOWER`
- Sleep prevention via `SetThreadExecutionState` with `ES_CONTINUOUS | ES_SYSTEM_REQUIRED`

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
