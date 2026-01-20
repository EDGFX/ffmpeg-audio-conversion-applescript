on run {input, parameters}
    -- Define the full path to the ffmpeg command
    set ffmpeg_path to "/opt/homebrew/bin/ffmpeg" -- Change this to the actual path to ffmpeg on your system
    
    -- Prompt user for the desired output format
    set format_list to {"FLAC", "AIFF", "MP3", "M4A"}
    set chosen_format to (choose from list format_list with prompt "Select the desired output format:") as string
    
    -- Check if a format was selected
    if chosen_format is false then
        return input -- Exit if no format is selected
    end if
    
    -- Define corresponding ffmpeg codecs and file extensions
    if chosen_format is "FLAC" then
        set codec to "flac"
        set extension to "flac"
        set additional_options to ""
    else if chosen_format is "AIFF" then
        set codec to "pcm_s16be" -- Standard AIFF encoder
        set extension to "aiff"
        set additional_options to ""
    else if chosen_format is "MP3" then
        set codec to "libmp3lame"
        set extension to "mp3"
        set additional_options to " -b:a 320k" -- Specify 320 kbps bitrate
    else if chosen_format is "M4A" then
        set codec to "aac"
        set extension to "m4a"
        set additional_options to ""
    end if
    
    -- Prompt user if they want to delete the source file
    set delete_source to button returned of (display dialog "Do you want to delete the source file after conversion?" buttons {"Yes", "No"} default button "No")

    -- Loop through each file received from the input
    repeat with the_file in input
        tell application "System Events"
            set the_item_path to the_file as text
            set the_item_extension to name extension of the_file
        end tell
        
        -- Check the file extension
        if the_item_extension is in {"wav", "aiff", "aif", "flac", "m4a", "aac"} then
            -- Set the output file path (change the directory if necessary)
            set the_base_name to text 1 thru -((length of the_item_extension) + 2) of the_item_path
            set the_output_path to the_base_name & "." & extension
            
            -- Construct the ffmpeg command with the full path
            set the_ffmpeg_command to quoted form of ffmpeg_path & " -i " & quoted form of POSIX path of the_item_path & " -c:a " & codec & additional_options & " " & quoted form of POSIX path of the_output_path
            
            -- Execute the ffmpeg command
            do shell script the_ffmpeg_command
            
            -- Check if the source file should be deleted
            if delete_source is "Yes" then
                do shell script "rm -f " & quoted form of POSIX path of the_item_path
            end if
        end if
    end repeat
    return input
end run
