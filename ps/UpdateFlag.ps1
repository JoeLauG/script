$rundtstr= '20241108'

$fromstatusflag = "U"
$tostatusflag = "I"

$inputpath = "C:\Users\l230445\Documents\B02\script\input.txt"
$workingpath = "C:\Users\l230445\Documents\B02\script\"
$resultpath = "C:\Users\l230445\Documents\B02\script\result\"
$modpath = "C:\Users\l230445\Documents\B02\script\mod\"
$logpath = "C:\Users\l230445\Documents\B02\script\log\"


$logfile = "C:\Users\l230445\Documents\B02\script\log.txt"
$invalidlogfile = "C:\Users\l230445\Documents\B02\script\invalidlog.txt"

$memArray = New-Object System.Collections.Generic.List[System.Object]


$mod_files = New-Object System.Collections.Generic.List[System.Object]
$mod_row_num = New-Object System.Collections.Generic.List[System.Object]

foreach($line in Get-Content $inputpath) {
    #Write-Host $line
    $line = $line.replace("FUND_CODE='DE1' AND MEMBER_NUMBER=","")
    $line = $line.replace("FUND_CODE='ELT' AND MEMBER_NUMBER=","")
    $line = $line.replace("""","")
    $line = $line.replace("'","")
    $line = $line.replace(" ","")
    if($memArray -notcontains $line)
    {
        if($line -ne ""){
            $memArray.Add($line )
        }
    }
}

$allmem= ""
$memArray | ForEach-Object {
  
     #Write-Host $_
     if($allmem -eq "") {
        $allmem= $_ #+ "`t"
      }else{
        $allmem= $allmem + "|" +  $_ #+ "`t"
      }

}
$start_today = Get-Date
Write-Host "Check "$allmem $start_today
write-host "===================="

$chi_files = New-Object System.Collections.Generic.List[System.Object]
#$chi_files.Add($rundtstr + "-EMPDTL-DELTA-001-test.txt")
$chi_files.Add($rundtstr + "-EMPDTL-DELTA-001.txt")
$chi_files.Add($rundtstr + "-MEMDTL-DELTA-001.txt")
$chi_files.Add($rundtstr + "-MEMVEST-DELTA-001.txt")
$chi_files.Add($rundtstr + "-MEMSALHIS-DELTA-001.txt")


foreach($file in $chi_files)
{
    $destfile = $resultpath + $file
    if (Test-Path $destfile )
    {
        Remove-Item $destfile
    }
}


$mod_files_idx =0 
foreach($file in $chi_files)
{
    $has_mod = $false
    $row_num = 0
    $today = Get-Date
    [string] $filteredcontent = ""
    [string] $content =""
    $filepath = $workingpath + $file
    $fileContent = get-content  -Encoding "UTF8"  $filepath
    $totalnum = $fileContent.Length
    $count =0

    
    Write-Host "Start Processing" $file ",recrod=" $totalnum "=>" -NoNewline 
    #get-content  -Encoding "UTF8"  .\$file | select-string  -Encoding "UTF8" -pattern $str -NotMatch | out-file -Encoding "UTF8" .\result\$file  
    [string] $line = ""

    $fileContent | ForEach-Object {
        
        $line = $_
        $destfile = $resultpath + $file
        $updateline = $false
        foreach ( $word in $memArray){
            if ($line -match $word) {
                #write-host "{"$word"}"
                $updateline  = $true
                foreach($mem in $memArray){
                    $idx = $line.IndexOf($mem)
                    if($idx -gt 0)
                    {
                        $checks = $line.Substring($idx -1 ,1)
                        #write-host "check{"$checks"}"

                        if($checks -match "^[a-zA-Z0-9]")
                        {
                            $updateline =$false
                            $logmsg = "Found and Remove Skipped:" + $mem + "," + $line
                            #Add-Content -Path $destfile -Value $line -Encoding UTF8
                            Add-Content -Path $invalidlogfile -Value $logmsg -Encoding UTF8
                        }else{
                            
                            $logmsg = "Found and Replaced:" + $mem + "," + $line
                            
                            $lastindex = $line.LastIndexOf($fromstatusflag) 
                            if($lastindex -ne -1)
                            {
                                 $line = $line.Substring(0,$lastindex) + $tostatusflag + $line.Substring($lastindex +1)
                            }
                            #Add-Content -Path $destfile -Value $line -Encoding UTF8
                            #write-host $file","$logmsg
                            $has_mod =$true
                            $row_num = $row_num + 1
                            Add-Content -Path $logfile -Value $logmsg -Encoding UTF8
                        }
                    }
                }
                
                break
                
            }
        }
        $count = $count + 1
        #Add-Content -Path $destfile -Value $line -Encoding UTF8
        if($null -ne $filteredcontent)
        {
            #Write-Host "test" $line 
            #Write-Host  $count
            if($totalnum -eq $count)
            {
                $filteredcontent = $filteredcontent + $line
            }else{
                $filteredcontent = $filteredcontent + $line + "`n"
            }
        }
    }

    if($has_mod)
    {
        $mod_files.Add($file);
        $mod_row_num.Add($row_num);
        $mod_file_idx = $mod_file_idx  + 1;
    }

    $destpath = $resultpath + $file
    if($null -ne $filteredcontent){
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllLines($destpath , $filteredcontent, $Utf8NoBomEncoding)
    }else{
        write-host "NULL"
        New-Item -Path $destpath -ItemType File   -Force | Out-Null
    }


    $end_today = Get-Date
    $diff_exec = $end_today  -$today
    write-host " Done " $diff_exec  

    #write-host "===================="

}

$end_today = Get-Date
$obj = $end_today  - $start_today
write-host `r`n"Completed All " $end_today" : druation = " $obj
write-host "Update" $allmem

$i  = 0 
foreach($file in $mod_files)
{
    $src = $resultpath + $file
    $des = $modpath + $file
    copy-item -Path $src -Destination $des
    write-host $file " modified," $mod_row_num[$i] "row updated"
    $i = $i +1
}