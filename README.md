# GUI Audio File Conversion Script with Automator and AppleScript

A macOS Automator Quick Action that allows you to convert audio files to different formats directly from Finder's right-click menu.

## Features

- Convert audio files with a simple right-click
- Support for multiple formats: FLAC, AIFF, WAV, and M4A
- No need to open separate applications
- Batch conversion support
- Clean, user-friendly format selection dialog

## Prerequisites

- macOS (any recent version with Automator)
- **FFmpeg** installed on your system

### Installing FFmpeg

If you don't have FFmpeg installed, you can install it using Homebrew:

```bash
brew install ffmpeg
```

### Checking Your FFmpeg Path

**Important:** Before using the script, you need to verify where FFmpeg is installed on your system and update the script if necessary.

To find your FFmpeg path, open Terminal and run:

```bash
which ffmpeg
```

Common paths include:
- `/opt/homebrew/bin/ffmpeg` (Apple Silicon Macs)
- `/usr/local/bin/ffmpeg` (Intel Macs)

If your path is different from `/opt/homebrew/bin/ffmpeg`, you'll need to update the `ffmpegPath` variable at the top of the AppleScript (see Installation step 4).

## Installation

1. **Open Automator** (This is a native Apple application that should already be installed)

2. **Click File, then "New"**
   - In the dialog that appears, select **Quick Action** and click **Choose**

3. **Configure the workflow settings** (at the top of the right panel)
   - Set **"Workflow receives current"** to: `audio files`
   - Set **"in"** to: `Finder.app`

4. **Add the AppleScript action**
   - In the search bar on the left, type: `AppleScript`
   - Click and drag **"Run AppleScript"** to the right panel

5. **Copy and paste the script**
   - Delete the default code in the text area
   - Paste the code from `audio-converter.applescript` in this repository
   - **Important:** Check the `ffmpegPath` variable at the top of the script and update it to match your FFmpeg installation path (see "Checking Your FFmpeg Path" above)

6. **Save the Quick Action**
   - Press `Cmd + S` (or File → Save)
   - Name it whatever you want, such as: `Convert Audio Format`
   - The file will automatically save to the correct location

## Usage

1. **Navigate to any audio file in Finder**

2. **Right-click the file(s)** you want to convert
   - You can select multiple files for batch conversion

3. **Select the Quick Action**
   - Hover over **Quick Actions** (or **Services** on older macOS)
   - Click **Convert Audio Format** (or whatever you named it)

4. **Choose your output format**
   - A dialog will appear with format options: FLAC, AIFF, WAV, M4A
   - Select your desired format and click **OK**

5. **Wait for conversion**
   - The converted files will appear in the same folder as the original files
   - A popup notification will confirm when the conversion is complete

## Output

- Converted files are saved in the **same directory** as the source files
- The original filename is preserved with a new extension
- Original files are **not deleted** or modified

## Troubleshooting

### "Command not found" error
- FFmpeg is not installed or not in your PATH
- Verify installation: `which ffmpeg`
- Update the `ffmpegPath` variable in the script to match your FFmpeg location

### Quick Action doesn't appear
- Make sure you saved the workflow as a **Quick Action** (not Workflow or Application)
- Restart Finder: Option + Right-click Finder icon in Dock → Relaunch
- Check that the workflow is saved in `~/Library/Services/`

### Conversion fails
- Ensure the source file is a valid audio file
- Check that you have write permissions in the source directory
- Some DRM-protected files cannot be converted

## Supported Input Formats

FFmpeg supports a wide range of input formats including:
- MP3, AAC, M4A, FLAC, WAV, AIFF, OGG, WMA, and many more

## Customization

You can modify the script to:
- Add or remove output formats (edit the `outputFormats` list)
- Change the output directory
- Adjust audio quality/bitrate settings
- Add custom FFmpeg parameters

## License

MIT License - feel free to modify and distribute as needed.

## Contributing

Contributions, issues, and feature requests are welcome!

---

**Note:** This is a macOS-specific tool and will not work on Windows or Linux.
