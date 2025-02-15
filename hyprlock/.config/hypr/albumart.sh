#!/bin/sh

# Define the directory and file names
DIR="$HOME/.config/hypr/artwork"
CURRENT_ART="$DIR/current_album_art.jpg"
NEW_ART="$DIR/new_album_art.jpg"
CURRENT_URL_FILE="$DIR/current_album_art_url.txt"
EMPTY="$DIR/empty.png"

# Get the album art URL from Spotify using playerctl
ALBUM_ART_URL=$(playerctl -p spotify metadata mpris:artUrl 2> /dev/null)

if [ -z "$ALBUM_ART_URL" ]; then
    rm -f "$CURRENT_ART"
    rm -f "$CURRENT_URL_FILE"
    echo "$EMPTY"
    exit 0
fi

# Check if the current URL file exists
if [ -f "$CURRENT_URL_FILE" ]; then
    # Read the current URL from the file
    CURRENT_URL=$(cat "$CURRENT_URL_FILE")
else
    # If the file does not exist, set CURRENT_URL to an empty string
    CURRENT_URL=""
fi

# Compare the current URL with the new URL
if [ "$CURRENT_URL" != "$ALBUM_ART_URL" ]; then
    # Download the new album art
    curl -s -o "$NEW_ART" "$ALBUM_ART_URL"
    
    # Check if the new album art is different from the current one
    if ! cmp -s "$CURRENT_ART" "$NEW_ART"; then
        # Remove the old album art
        rm -f "$CURRENT_ART"
        # Move the new album art to the current album art
        mv "$NEW_ART" "$CURRENT_ART"
    else
        # Remove the new album art if it is the same as the current one
        rm -f "$NEW_ART"
    fi
    
    # Update the current URL file
    echo "$ALBUM_ART_URL" > "$CURRENT_URL_FILE"
fi

echo "$CURRENT_ART"