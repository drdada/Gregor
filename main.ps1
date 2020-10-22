## Gregor
# Personnal daily trainer by Drdada

if (!(Test-Path "C:\Program Files\VideoLAN\VLC\vlc.exe")){
    Write-Warning "VLC not found - Please install VLC"
    Read-Host -Prompt "* Can't do anything! Press Enter to exit"
    Exit 1
}

if ($PSVersionTable.PSVersion.Major -lt 5)
{
	Write-Warning -Message "This script requires PowerShell 5+ to run, but you're currently running PowerShell $(if (Test-Path Variable:\PSVersionTable) {$PSVersionTable.PSVersion} else {"1.0"})!"
	Read-Host -Prompt "* Can't do anything! Press Enter to exit"
	Exit 1
}
Write-Host ""
Write-Host "My name is Gregor and i'll help you to get you in good shape"

# find day and time

if ((get-date).DayOfWeek -eq "Sunday"){
    Write-Host "You should rest today..."
    $confirmation = Read-Host "We are on Sunday are you sure to train today ? (y/N)"
    if ($confirmation -ne 'y') {
       Write-Host "Ok bye"
       Exit 1
    }
}

if ((get-date).hour -gt 12){
    Write-Host "Good Evening"
    $cat = "evening"
}
else{
    Write-Host "Good Morning"
    $cat = "morning"
}
Write-Host "Yay ! This will be a(n)"($cat).ToUpper() "training today" -ForegroundColor Green


# download data file or use the local one
if (!(Test-Path "video-$cat.csv")){
    #download file because we don't find it in local folder
    wget https://raw.githubusercontent.com/drdada/Gregor/master/video-$cat.csv -OutFile video-$cat.csv
    Write-Host "Downloading file"
}
$file = "video-$cat.csv"


$data = Import-Csv -Path $file -Delimiter ';'
$chosen = $data | Get-Random
Write-Host "Playing:" $chosen.URL
Write-Host "Remark:" $chosen.Remark -ForegroundColor Cyan

Start-Sleep 3

if ([INT]$chosen.starttime -gt 1){
    $starttime = [INT]$chosen.starttime
}
else{
    $starttime = "0"
}

if ([INT]$chosen.stoptime -gt 1){
    $stoptime = [INT]$chosen.stoptime
}
else{
    $stoptime = ""
}

For ($i=0; $i -lt 5; $i++) {
    $p=$i*20
    $s=5-$i
    Write-Progress -Activity "Starting in 5 seconds" -SecondsRemaining $s -PercentComplete $p
    Start-Sleep 1
}
Write-Progress -Completed -Activity "Starting in 5 seconds"

Write-Host "---- GO ----"
# play video

C:\"Program Files"\VideoLAN\VLC\vlc.exe $chosen.URL vlc://quit --fullscreen --start-time=$starttime --stop-time=$stoptime

Write-Host " -- Great job ! --" -BackgroundColor Black -ForegroundColor Yellow
$confirmation = Read-Host "Do you want to stretch now (Y/n)"
if ($confirmation -eq 'n') {
    Write-Host "Ok bye - See you tomorrow"
    Exit 0
}

# download data file or use the local one
if (!(Test-Path "video-stretch.csv")){
    #download file because we don't find it in local folder
    wget https://raw.githubusercontent.com/drdada/Gregor/master/video-stretch.csv -OutFile video-stretch.csv
    Write-Host "Downloading file"
}
$file = "video-stretch.csv"


$data = Import-Csv -Path $file -Delimiter ';'
$chosen = $data | Get-Random
Write-Host "Playing:" $chosen.URL
Write-Host "Remark:" $chosen.Remark -ForegroundColor Cyan
if ([INT]$chosen.starttime -gt 1){
    $starttime = [INT]$chosen.starttime
}
else{
    $starttime = "0"
}

if ([INT]$chosen.stoptime -gt 1){
    $stoptime = [INT]$chosen.stoptime
}
else{
    $stoptime = ""
}

For ($i=0; $i -lt 5; $i++) {
    $p=$i*20
    $s=5-$i
    Write-Progress -Activity "Starting in 5 seconds" -SecondsRemaining $s -PercentComplete $p
    Start-Sleep 1
}
Write-Progress -Completed -Activity "Starting in 5 seconds"

Write-Host "---- GO ----"
# play video

C:\"Program Files"\VideoLAN\VLC\vlc.exe $chosen.URL vlc://quit --fullscreen --start-time=$starttime --stop-time=$stoptime


Write-Host "Congratulation - see you tomorrow (i hope)"
Start-Sleep 5
