#!/bin/bash
# rename-subs.sh
# Created On: Dec. 23 2022
# Last Updated: Dec. 24 2022
# Purpose: For CaptCouch's Emby, to rename subtitle files to the names of the movie files. This
#          is because Emby needs the subtitle files to have the same name as the movie to be
#          scanned into the library as an option.

# In all subdirectories of the directory from which the script was run,
# find all subtitle files with the extension .srt.
# Iterate through the whole set.
for directory in $(find -type d); do {

    # Exclude the current top-level directory.
    if [ "$directory" != "." ]; then

        # (Debug) Display the current item in the set ($directory).
        #echo -e "Current Directory: $directory\n"

        # In each directory, find the movie file (.vid) and get its name, minus its extension.
        for moviefile in $(find $directory -type f -name '*.vid'); do {

                # Get the name of the movie file without the extension.
                moviename="${moviefile%.vid}"

                # (Debug) Display current $moviename in the terminal.
                #echo -e "Movie Name Minus Extension: $moviename\n"

        }; done

        # In each directory, find the subtitle file (.srt) and rename it to $moviefile.srt.
        for subfile in $(find $directory -type f -name '*.srt'); do {

            # If there is more than one .srt file in the directory, note it and skip it.
            if [ $(find "$directory" -type f -name '*.srt' | wc -l) -gt 1 ]; then

                echo -e "More than one subtitle file found in $directory. Skipping.\n"

            else

                # (Debug) Display current $subfile in the terminal.
                #echo -e "Current subtitle file: $subfile\n"

                # (Debug) Display the proposed rename of the file.
                #echo -e "Subtitle would be renamed to: $moviename.srt"

                # Rename the subtitle file to the same name as the movie.
                # Move it to the same directory as the movie file.
                mv $subfile $moviename.srt

            fi

        }; done

        # Assign the current item's value to $file.
        # This variable can be used to put the data somewhere else later.
        file="$directory"

    fi
    
}; done

# Announce the completion of the script.
echo -e "Script run complete.\n"

