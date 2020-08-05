# FileExtensionRenamer
<h3> Description </h3>
This is a simple powershell script with a GUI interface designed to rename all files in a folder and its sub folders to an extension of choice.
<h3> Usage </h3>
To use the script, simply download it onto your computer and open it with Powershell ISE
Type the following in the powershell console to enable execution of unsigned scripts. This will only allow it until you close the the PowerShell ISE Window

```
Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass
```
Then run the script and a GUI Form should pop up.
Fill in the fields as needed.

<b>Browse: </b>
Opens up a browser dialog window so you can choose a folder for the script to run on.
<br>
<b>Show Changes: </b>
Indicates how many files will be changed before actually making the changes.
<br>
<b>Commit Changes: </b>
Changes files with "Original Ext" to the provided "New Ext"
<br>

<h3>Idea Behind Script</h3>
<br>
The main reasoning behind this script was just to introduce myself to powershell and its GUI features while at the same time solving a small issue I had.
I had some trouble copying files over from my old Galaxy S8 to my computer so I decided to use a Samsung application to create a backup onto an SD card and then transfer that SD card over to my computer and do the backup that way.
I found out later that the backup application changed the extentions of all my files to have an underscore at the end of it.
So I made this script to help me easily change them back to the original file extensions.
