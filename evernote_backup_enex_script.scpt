tell application "Evernote"

   set allNotebooks to every notebook
    repeat with currentNotebook in allNotebooks
        set notebookName to (the name of currentNotebook)
        set fileBackupenex to "/Users/david/Desktop/@Evernote/Evernote_Backup/Notebook-" & notebookName & ".enex"
        set fileBackupenex to POSIX path of fileBackupenex

        set theNotes to every note in notebook notebookName
        if theNotes is not {} then
            try 
               with timeout of (60 * 60) seconds
                   export theNotes to fileBackupenex format ENEX with tags
                   do shell script "/usr/bin/gzip -f " & quoted form of fileBackupenex
               end timeout
               on error errorMessage
                  return errorMessage
            end try
        end if

    end repeat
end tell
