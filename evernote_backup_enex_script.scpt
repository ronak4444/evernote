-- Applescript
set backupfolder to "/Users/username/Desktop/backups/Evernote_backup/"

tell application "Evernote"
	set excludelist to the {"NoteThatNeedToBeExcluded"}
	set allNotebooks to every notebook
	repeat with currentNotebook in allNotebooks
		set notebookName to (the name of currentNotebook)
		if excludelist contains notebookName then
		else
			set fileBackupenex to backupfolder & "Notebook-" & notebookName & ".enex"
			set fileBackupenex to POSIX path of fileBackupenex
			set theNotes to every note in notebook notebookName
			if theNotes is not {} then
				try
					with timeout of (60 * 60) seconds
						export theNotes to fileBackupenex format ENEX with tags
						do shell script "/usr/bin/gzip -f " & quoted form of fileBackupenex
					end timeout
				on error errorMessage
					display dialog currentNotebook
					return errorMessage
				end try
			end if
		end if
	end repeat
end tell
