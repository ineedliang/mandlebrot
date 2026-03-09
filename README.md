Requires latest version of ffmpeg and ffprobe. Old or lite versions do not have this feature built in. was tested using the full version found here. https://www.gyan.dev/ffmpeg/builds/

# 🎵 MP3 → Visualizer Video Generator (FFmpeg Batch Script)

![Windows](https://img.shields.io/badge/platform-Windows-blue)
![Batch](https://img.shields.io/badge/language-Batch-green)
![FFmpeg](https://img.shields.io/badge/powered%20by-FFmpeg-orange)
![License](https://img.shields.io/badge/license-Free-lightgrey)

Create a **video from an MP3 file automatically** using **FFmpeg**.

This script converts an **MP3 audio file into an MP4 video** using a **generated Mandelbrot fractal animation** as the visual background.

Perfect for uploading music to platforms that require video such as **YouTube, streaming sites, or media players**.

---

# 🚀 Features

✔ Drag-and-drop MP3 support
✔ Interactive file selection if no file is dropped
✔ Automatically generates a **fractal video background**
✔ Converts audio to **AAC for maximum compatibility**
✔ Optional **MKV fallback with original MP3 audio**
✔ Automatic **audio verification check**
✔ Detailed logging to `ffmpeg_log.txt`
✔ Fully **offline & portable**

---

# 📦 Requirements

You must have **FFmpeg installed and accessible in your system PATH**.

Required tools:

* `ffmpeg`
* `ffprobe`

Verify installation:

```id="3xtu3n"
ffmpeg -version
ffprobe -version
```

Download FFmpeg here:

https://ffmpeg.org/download.html

Recommended Windows builds:

https://www.gyan.dev/ffmpeg/builds/

---

# 📁 Example Folder

```id="7p9s6m"
MP3VideoGenerator/
│
├── mp3_to_video.bat
├── song.mp3
```

FFmpeg does **not** need to be in the folder if it's in your system PATH.

---

# 🖱 Usage

## Method 1 — Drag & Drop

Simply drag an MP3 file onto the batch script.

Example:

```id="mbt1h0"
song.mp3
```

⬇

```id="i2r0d3"
song.mp4
```

---

## Method 2 — Interactive Mode

If no file is dropped, the script will:

1. Scan the folder for `.mp3` files
2. Display a numbered list
3. Prompt you to choose a file

Example:

```id="p4y2sp"
1. track1.mp3
2. podcast.mp3
3. music.mp3
```

Then enter the number.

---

# 🎨 Generated Visual

The script generates a **procedural Mandelbrot fractal animation** as the video layer:

```id="v07a5s"
mandelbrot=s=1280x720:rate=30
```

Video properties:

| Property     | Value    |
| ------------ | -------- |
| Resolution   | 1280x720 |
| Framerate    | 30 FPS   |
| Codec        | H.264    |
| Pixel Format | yuv420p  |

This ensures compatibility with **most players and video platforms**.

---

# 🎧 Audio Settings

The MP3 audio is converted to **AAC** for better compatibility in MP4 containers.

| Property    | Value    |
| ----------- | -------- |
| Codec       | AAC      |
| Bitrate     | 192 kbps |
| Sample Rate | 48 kHz   |
| Channels    | Stereo   |

---

# 📼 Output Files

Primary output:

```id="c6g11k"
song.mp4
```

Verification audio extraction:

```id="p14bhg"
test_audio.mp3
```

Optional fallback format:

```id="1p5r3m"
song.mkv
```

---

# 🔎 Audio Verification

After generating the video the script:

1. Uses **ffprobe** to confirm an audio stream exists
2. Extracts the audio for verification
3. Reports any compatibility issues

---

# 🪵 Logs

Detailed FFmpeg logs are saved to:

```id="efl9m4"
ffmpeg_log.txt
```

Use this file if troubleshooting conversion problems.

---

# ⚠️ Fallback Mode

If the MP4 container fails to include audio properly, the script automatically generates:

```id="b8r1rt"
song.mkv
```

This version preserves the **original MP3 audio stream**.

---

# 🎬 Supported Input

Currently optimized for:

```
.mp3
```

Other formats may work but are not guaranteed.

---

# 💡 Use Cases

This tool is useful for:

* Uploading **music to YouTube**
* Creating **podcast video versions**
* Making **visual music players**
* Generating **background video for audio tracks**
* Packaging audio for **video-only platforms**

---

# 📜 License

Free to use, modify, and distribute.

---

# ⭐ Improvements Welcome

Potential future upgrades:

* Custom background images
* Album art embedding
* Audio spectrum visualizer
* GPU accelerated encoding
* Batch folder processing
* Multiple resolution presets

Pull requests are welcome.

---

# 👤 Author

A lightweight automation script designed to turn **audio files into ready-to-upload videos** with minimal effort.
