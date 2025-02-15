#!/bin/sh
helpFunction()
{
   echo ""
   echo "Options:"
   echo -e "\t-h Show this help menu"
   echo -e "\t--artist Get the currently playing artist."
   echo -e "\t--track Get the currently playing track."
   echo -e "\t--album Get the currently playing album."
   exit 1 # Exit script after printing help
}

all=true

optspec=":h-:"
while getopts "$optspec" optchar; do
    case "${optchar}" in
        -)
            case "${OPTARG}" in
                artist) artist=true
                all=false;;
                track) track=true
                all=false;;
                album) album=true
                all=false;;
                *) echo "Invalid option ${OPTARG}"
                    helpFunction ;;
            esac;;
        h) helpFunction;;
        *)
            if [ "$OPTERR" != 1 ] || [ "${optspec:0:1}" = ":" ]; then
                echo "Non-option argument: '-${OPTARG}'" >&2
                helpFunction
            fi
            ;;
    esac
done

metadata="$(playerctl -p spotify metadata)"
artist_name=$(echo "$metadata" | grep -oP 'xesam:artist\s+\K.*')
track_name=$(echo "$metadata" | grep -oP 'xesam:title\s+\K.*')
album_name=$(echo "$metadata" | grep -oP 'xesam:album\s+\K.*')

if [[ "$all" = true ]]; then
    echo "Artist: $artist_name"
    echo "Track: $track_name"
    echo "Album: $album_name"
    exit 0
fi

if [[ "$artist" = true ]]; then
    echo "$artist_name"
fi

if [[ "$track" = true ]]; then
    echo "$track_name"
fi

if [[ "$album" = true ]]; then
    echo "$album_name"
fi
