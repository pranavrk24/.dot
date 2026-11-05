#!/usr/bin/env bash
set -uo pipefail

OUT_DIR="$HOME/Videos"
mkdir -p "$OUT_DIR"

timestamp=$(date +%Y%m%d-%H%M%S)
tmp_video="/tmp/rec-${timestamp}.mp4"
out_gif="${OUT_DIR}/rec-${timestamp}.gif"

# Select area
geom=$(slurp) || exit 1
sleep 0.3

# Trap Ctrl+C so we can still convert
trap 'echo "Stopping recording..."; kill $REC_PID 2>/dev/null; wait $REC_PID 2>/dev/null' INT

# Start recording in background
wf-recorder -g "$geom" -f "$tmp_video" &
REC_PID=$!

# Wait for it to finish (or be killed)
wait $REC_PID || true

# Convert if the video exists
if [[ -f "$tmp_video" ]]; then
  echo "Converting to GIF..."
  ffmpeg -y -i "$tmp_video" \
    -vf "fps=15,scale=640:-1:flags=lanczos,split[s0][s1];[s0]palettegen[p];[s1][p]paletteuse" \
    -loop 0 "$out_gif"

  rm -f "$tmp_video"
  echo "Saved: $out_gif"
  notify-send "GIF saved" "$out_gif" 2>/dev/null || true
else
  echo "No video file was created."
fi
