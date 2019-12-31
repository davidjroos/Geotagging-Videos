# exifstuff
Why does this exist?

1. To automate my import workflow (scripts are designed/testing to be run in zsh from MacOS Automations taking folders as input
2. Disgusting, horrible, sickening and generally hilarious workaround I'm using to allow me to use Houdahgeo to tag my videos

## Caveats!
This exist specifically for my Fuji X100F (H264 video in an MOV container, .RAF files) and tagging options that work in MacOS Photos app, so adjust as necessary!

'Keys:GPSCoordinates' is what MacOS Photos needs it seems, so we need to treat it as a GPS tag

## what does it do?
- Script1: Create a dummy image from each video

Use Houdahgeo to tag it/them along with the rest of my images

- Script2: Write those GPS tags back to the video

## Requirements
 - ffmpeg
 - exiftool
I don't check for these because I have them

## Usage

Run each script with one or many FOLDERS(not files!) as input
./script[x].sh /path/to/videos/
