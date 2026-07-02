// ============================================================================
//  FileConverter - NileSoft Shell Context Menu Integration
// ============================================================================

// ── VIDEO ────────────────────────────────────────────────────────────────────

menu(
    type  = 'file'
    mode  = 'multiple'
    find  = '.mp4|.mkv|.avi|.mov|.webm|.flv|.wmv|.m4v|.ts|.mpeg|.mpg|.3gp|.ogv|.vob|.divx'
    title = 'Convert Video'
    image = \uE116
)
{
    menu(title='to MP4' image=\uE116)
    {
        item(title='High Quality  (H.264, CRF 18)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mp4-hq"')
        item(title='Web Optimized  (H.264, CRF 23)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mp4-web"')
        item(title='Compressed  (H.264, CRF 28)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mp4-small"')
        item(title='HEVC / H.265  (GPU Accelerated)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mp4-265"')
        item(title='AV1  (Next-Gen, GPU/CPU)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mp4-av1"')
        item(title='H.264 CPU-Only  (Compatibility fallback)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mp4-cpu"')
    }
    menu(title='to WebM' image=\uE116)
    {
        item(title='WebM VP9'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-webm"')
        item(title='WebM AV1  (CPU SVT-AV1)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-webm-av1"')
    }
    item(title='to AVI  (Windows compatible)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-avi"')
    item(title='to MKV  (lossless stream copy)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mkv"')
    item(title='to MOV  (QuickTime)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mov"')
    separator
    item(title='to Animated GIF'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-gif"')
    separator
    menu(title='Compress Video' image=\uE116)
    {
        item(title='Discord (under 8 MB)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-compress-discord-8mb"')
        item(title='Discord (under 25 MB)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-compress-discord-25mb"')
    }
    menu(title='Resize Video' image=\uE116)
    {
        item(title='to 1080p (Full HD)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-resize-1080p"')
        item(title='to 720p (HD)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-resize-720p"')
        item(title='to 480p (SD)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-resize-480p"')
    }
    menu(title='Rotate / Flip Video' image=\uE116)
    {
        item(title='Rotate 90° CW'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-rotate-90-cw"')
        item(title='Rotate 90° CCW'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-rotate-90-ccw"')
        item(title='Rotate 180°'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-rotate-180"')
        separator
        item(title='Flip Horizontally'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-flip-h"')
        item(title='Flip Vertically'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-flip-v"')
    }
    menu(title='Adjust Speed' image=\uE116)
    {
        item(title='Speed Up 2x'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-speed-2x"')
        item(title='Slow Down 0.5x'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-speed-05x"')
    }
    item(title='Mute Video  (Remove Audio)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mute"')
    separator
    menu(title='Extract Audio' image=\uE289)
    {
        item(title='Extract to MP3  (320 kbps)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-extract-audio"')
        item(title='Extract to WAV  (Lossless)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-extract-wav"')
        item(title='Extract to FLAC  (Lossless)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-extract-flac"')
        item(title='Extract to AAC / M4A  (256 kbps)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-extract-m4a"')
        item(title='Extract to Opus  (128 kbps)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-extract-opus"')
    }
}


// ── AUDIO ────────────────────────────────────────────────────────────────────

menu(
    type  = 'file'
    mode  = 'multiple'
    find  = '.mp3|.aac|.flac|.wav|.ogg|.opus|.m4a|.wma|.aiff|.ape|.ac3|.dts|.mka|.ra|.amr'
    title = 'Convert Audio'
    image = \uE289
)
{
    menu(title='to MP3' image=\uE289)
    {
        item(title='High Quality  (320 kbps)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-mp3-hq"')
        item(title='Standard  (192 kbps)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-mp3-std"')
        item(title='Compressed  (128 kbps)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-mp3-small"')
    }
    item(title='to AAC / M4A  (256 kbps)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-aac"')
    item(title='to ALAC / M4A  (Apple Lossless)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-m4a-alac"')
    item(title='to FLAC  (Lossless)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-flac"')
    menu(title='to WAV' image=\uE289)
    {
        item(title='WAV PCM 16-bit'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-wav"')
        item(title='WAV PCM 24-bit  (High-Res)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-wav-24bit"')
    }
    item(title='to OGG Vorbis'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-ogg"')
    item(title='to Opus  (streaming, 128 kbps)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-opus"')
    item(title='to WMA  (Windows Media)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-wma"')
    item(title='to AMR  (Voice Quality)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-amr"')
    separator
    menu(title='Volume Effects' image=\uE289)
    {
        item(title='Volume Boost  (200%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-vol-200"')
        item(title='Volume Reduce  (50%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-vol-50"')
    }
}


// ── IMAGE ─────────────────────────────────────────────────────────────────────

menu(
    type  = 'file'
    mode  = 'multiple'
    find  = '.jpg|.jpeg|.png|.bmp|.gif|.tiff|.tif|.webp|.avif|.heic|.heif|.ico|.psd|.raw|.cr2|.nef|.arw|.dng'
    title = 'Convert Image'
    image = \uE156
)
{
    menu(title='to JPEG' image=\uE156)
    {
        item(title='High Quality  (95%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-jpg-hq"')
        item(title='Web Optimized  (80%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-jpg-web"')
        item(title='Compressed  (60%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-jpg-small"')
        item(title='Privacy  (Strip EXIF/Metadata)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-jpg-privacy"')
    }
    menu(title='to PNG' image=\uE156)
    {
        item(title='PNG Lossless'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-png"')
        item(title='Privacy  (Strip Metadata)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-png-privacy"')
    }
    menu(title='to WebP' image=\uE156)
    {
        item(title='WebP Lossy  (quality 85)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-webp"')
        item(title='WebP Lossless'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-webp-lossless"')
        item(title='WebP Optimized  (quality 75, Strip Metadata)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-webp-optimized"')
    }
    item(title='to AVIF  (modern, efficient)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-avif"')
    item(title='to BMP'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-bmp"')
    item(title='to Static GIF'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-gif-static"')
    item(title='to TGA  (Targa)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-tga"')
    menu(title='to TIFF' image=\uE156)
    {
        item(title='TIFF Lossless  (LZW compressed)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-tiff"')
        item(title='TIFF Uncompressed'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-tiff-uncompressed"')
    }
    item(title='to ICO  (Windows icon, 256 x 256)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-ico"')
    separator
    menu(title='Resize Image' image=\uE156)
    {
        item(title='Resize to 4K  (max 3840 px)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-4k"')
        item(title='Resize to HD  (max 1920 px)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-hd"')
        item(title='Resize to 720p  (max 1280 px)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-720p"')
        item(title='Resize to Medium  (max 800 px)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-medium"')
        item(title='Thumbnail  (320 x 240)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-thumb"')
        item(title='Square Crop  (512 x 512)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-square"')
        item(title='Avatar  (128 x 128)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-avatar"')
    }
    menu(title='Rotate / Flip Image' image=\uE156)
    {
        item(title='Rotate 90° CW'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-rotate-90-cw"')
        item(title='Rotate 90° CCW'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-rotate-90-ccw"')
        item(title='Rotate 180°'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-rotate-180"')
        separator
        item(title='Flip Horizontally'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-flip-h"')
        item(title='Flip Vertically'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-flip-v"')
    }
    menu(title='Effects & Filters' image=\uE156)
    {
        item(title='Convert to Grayscale'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-grayscale"')
        item(title='Invert Colors  (Negative)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-invert"')
        item(title='Gaussian Blur'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-blur"')
        item(title='Sharpen'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-sharpen"')
        item(title='Brighten  (+20%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-brighten"')
        item(title='Boost Contrast  (+30%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-contrast"')
        item(title='Sepia Filter  (Vintage)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-sepia"')
        item(title='Vintage Curves'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-vintage"')
    }
}
