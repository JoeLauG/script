$folderpath = "C:\Users\l230445\Documents\B02\script\"
Get-ChildItem -path $folderpath | ForEach-Object { $_.Name }