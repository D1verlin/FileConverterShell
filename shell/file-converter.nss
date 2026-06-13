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
        item(title='HEVC / H.265  (smaller file)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-mp4-265"')
    }
    item(title='to WebM  (VP9)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-webm"')
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
    item(title='Extract Audio to MP3'
         image=\uE289
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "vid-extract-audio"')
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
    item(title='to FLAC  (Lossless)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-flac"')
    item(title='to WAV  (PCM 16-bit)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-wav"')
    item(title='to OGG Vorbis'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-ogg"')
    item(title='to Opus  (streaming, 128 kbps)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-opus"')
    item(title='to WMA  (Windows Media)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "aud-wma"')
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
        item(title='Web  (80%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-jpg-web"')
        item(title='Small  (60%)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-jpg-small"')
        separator
        item(title='Resize to HD  (max 1920 px)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-hd"')
        item(title='Resize to 4K  (max 3840 px)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-4k"')
        item(title='Thumbnail  (320 x 240)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-thumb"')
        item(title='Square Crop  (512 x 512)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-resize-square"')
    }
    item(title='to PNG  (Lossless)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-png"')
    menu(title='to WebP' image=\uE156)
    {
        item(title='WebP Lossy  (quality 85)'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-webp"')
        item(title='WebP Lossless'
             cmd='powershell.exe'
             args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-webp-lossless"')
    }
    item(title='to AVIF  (modern, efficient)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-avif"')
    item(title='to BMP'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-bmp"')
    item(title='to TIFF  (LZW compressed)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-tiff"')
    item(title='to ICO  (Windows icon, 256 x 256)'
         cmd='powershell.exe'
         args='-NoProfile -ExecutionPolicy Bypass -File "C:/Users/Lenovo/Desktop/Projects/FileConverter/convert.ps1" -InputPath "@(sel(false, "*"))" -Preset "img-ico"')
}

