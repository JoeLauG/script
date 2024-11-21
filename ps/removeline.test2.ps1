$rundtstr= '20241109'

$inputpath = "C:\Users\l230445\Documents\B02\script\input.txt"
$workingpath = "C:\Users\l230445\Documents\B02\script\"
$resultpath = "C:\Users\l230445\Documents\B02\script\result\"
$modpath = "C:\Users\l230445\Documents\B02\script\mod\"
$logpath = "C:\Users\l230445\Documents\B02\script\log\"

$inputlogfile = "C:\Users\l230445\Documents\B02\script\inputlog.txt"
$logfile = "C:\Users\l230445\Documents\B02\script\log.txt"
$invalidlogfile = "C:\Users\l230445\Documents\B02\script\invalidlog.txt"

$counter = 0
$todaydatestr = (get-date).ToString("yyyymmdd")
if(test-path $logfile)
{
    $tmp_log_file =""
    do{
        $tmp_log_file = $logpath +"log-"+ $todaydatestr +"-" +$counter + ".txt"
        $counter = $counter  +1
    }while(test-path $tmp_log_file)

    Copy-Item -path $logfile -Destination $tmp_log_file
}
$counter = 0
if(test-path $inputlogfile)
{
    $tmp_log_file =""
    do{
        $tmp_log_file = $logpath +"inputlog-"+ $todaydatestr  + "-" + $counter + ".txt"
        $counter = $counter  +1
    }while(test-path $tmp_log_file)

    Copy-Item -path $inputpath -Destination $tmp_log_file
}else{
    Copy-Item -path $inputpath -Destination $inputlogfile
}

$memArray = New-Object System.Collections.Generic.List[System.Object]

Remove-Item $modpath"*.*"
Remove-Item $resultpath"*.*"
#Remove-Item $logfile

foreach($line in Get-Content $inputpath) {
    #Write-Host $line
    $line = $line.replace("FUND_CODE='DE1' AND MEMBER_NUMBER=","")
    $line = $line.replace("FUND_CODE='ELT' AND MEMBER_NUMBER=","")
    $line = $line.replace("'","")
    $line = $line.replace(" ","")
    if($memArray -notcontains $line)
    {
        if($line -ne ""){
            $memArray.Add($line )
        }
    }
}
#Write-Host "memArray["$memArray[0].Length"]"
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

$files = New-Object System.Collections.Generic.List[System.Object]

#$files.Add($rundtstr + "-MEMUNTBAL-DELTA-001.txt") #9xxxx
#$files.Add($rundtstr + "-MEMINVMDT-DELTA-001.txt")

$file_bal2 = $workingpath + $rundtstr + "-MEMUNTBAL-DELTA-002.txt"
$file_bal3 = $workingpath + $rundtstr + "-MEMUNTBAL-DELTA-003.txt"
$file_bal4 = $workingpath + $rundtstr + "-MEMUNTBAL-DELTA-004.txt"

$mod_files = New-Object System.Collections.Generic.List[System.Object]
$mod_row_num = New-Object System.Collections.Generic.List[System.Object]

$chi_files = New-Object System.Collections.Generic.List[System.Object]
$files.Add($rundtstr + "-MEMUNTBAL-DELTA-001.txt") #9xxxx
if(Test-path $file_bal2)
{
    $tmp_file_bal2 = $rundtstr + "-MEMUNTBAL-DELTA-002.txt"
    $files.Add($tmp_file_bal2)
}
if(Test-path $file_bal3)
{
    $tmp_file_bal3 = $rundtstr + "-MEMUNTBAL-DELTA-003.txt"
    $files.Add($tmp_file_bal3)
}
if(Test-path $file_bal4)
{
    $tmp_file_bal4 = $rundtstr + "-MEMUNTBAL-DELTA-004.txt"
    $files.Add($tmp_file_bal4)
}

$files.Add($rundtstr + "-MEMINVMDT-DELTA-001.txt")
$files.Add($rundtstr + "-MEMUNTMOV-DELTA-001.txt") #9xxx
$files.Add($rundtstr + "-MEMSALHIS-DELTA-001.txt")  #2xxx
$files.Add($rundtstr + "-TRFINFU-FULL-001.txt")

$chi_files.Add($rundtstr + "-MEMVEST-DELTA-001.txt")
$chi_files.Add($rundtstr + "-UPT-DELTA-001.txt")
$chi_files.Add($rundtstr + "-TRFINAST-DELTA-001.txt")
$chi_files.Add($rundtstr + "-ROIDTL-FULL-001.txt")
$chi_files.Add($rundtstr + "-RCDTL-DELTA-001.txt")
$chi_files.Add($rundtstr + "-MVTYPE-FULL-001.txt")
$chi_files.Add($rundtstr + "-MEMPENDTM-FULL-001.txt")
$chi_files.Add($rundtstr + "-MEMPENDPP-FULL-001.txt")
$chi_files.Add($rundtstr + "-MEMDTL-DELTA-001.txt")
$chi_files.Add($rundtstr + "-IVRPINER-DELTA-001.txt")
$chi_files.Add($rundtstr + "-IVRPIN-DELTA-001.txt")
$chi_files.Add($rundtstr + "-INVDTL-FULL-001.txt")
$chi_files.Add($rundtstr + "-ERPENDSET-FULL-001.txt")
$chi_files.Add($rundtstr + "-EMPDTL-DELTA-001.txt")
$chi_files.Add($rundtstr + "-CONTDESC-FULL-001.txt")
$chi_files.Add($rundtstr + "-CNTRL-0-B02.TXT")

#$chi_files.Add($rundtstr + "-TRFINFU-FULL-001-test.txt")

foreach($file in $files)
{
    break
    $today = Get-Date
    Write-Host "Start Processing " $file "=>" -NoNewline 
    $filepath = $workingpath + $file
    
    $destpath = $resultpath + $file
    $filteredcontent = ""
    $filteredcontent = get-content -Encoding "UTF8"  $filepath | select-string  -Encoding "UTF8" -pattern $allmem -NotMatch 
    $filteredcontent = $filteredcontent.TrimStart("`r`n")
    $filteredcontent = $filteredcontent.TrimEnd("`r`n")
    $filteredcontent = $filteredcontent.TrimEnd("`r`n")
    $filteredcontent = $filteredcontent.Replace(" ","`r`n")
    #$filteredcontent | out-file -Encoding "UTF8" $destpath

    $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
    [System.IO.File]::WriteAllLines($destpath , $filteredcontent, $Utf8NoBomEncoding)

    $end_today = Get-Date
    $diff_exec = $end_today  -$today
    write-host " Done " $diff_exec  
}

$table = @()
$mod_files_idx =0 
foreach($file in $chi_files)
{
    $has_mod = $false
    $row_num = 0
    $count = 0
    $today = Get-Date
    [string] $filteredcontent = ""
    [string] $content =""
    $filepath = $workingpath + $file
    $fileContent = get-content  -Encoding "UTF8"  $filepath
    
    $reader = [System.IO.StreamReader]::new($filepath, [System.Text.Encoding]::UTF8)

    $totalnum = $fileContent.Length
    $count =0

    
    Write-Host "Start Processing" $file ",recrod=" $totalnum "=>" -NoNewline 
    #get-content  -Encoding "UTF8"  .\$file | select-string  -Encoding "UTF8" -pattern $str -NotMatch | out-file -Encoding "UTF8" .\result\$file  
    [string] $line = ""

    #$fileContent | ForEach-Object  {
    while(($line = $reader.ReadLine()) -ne $null) {
        
        #write-host $line 
        $removeline = $false
        foreach ( $word in $memArray){
            if ($line -match $word) {
                $removeline  = $true
                #foreach($mem in $memArray){
                    $idx = $line.IndexOf($word)
                    if($idx -gt 0)
                    {
                        $checks = $line.Substring($idx -1 ,1)
                        if($checks -match "^[a-zA-Z0-9]")
                        {
                            $removeline =$false
                            $logmsg = "Found and Remove Skipped:" + $mem + "," + $line
                            Add-Content -Path $invalidlogfile -Value $logmsg -Encoding UTF8
                        }else{
                            #Write-Host "Found and Removed:" + $mem + "," + $line
                            $logmsg = "Found and Removed:" + $mem + "," + $line
                            $has_mod =$true
                            $row_num = $row_num + 1
                            Add-Content -Path $logfile -Value $logmsg -Encoding UTF8
                        }
                    }
                #}
                
                break
                
            }
        }
        $count = $count + 1
        #if($removeline -eq $false){
        #    Add-Content -Path "C:\Users\l230445\Documents\B02\script\result\tmp\$file" -Value $line -Encoding UTF8
        #}
        if(-not $removeline)
        {
            #Write-Host "test" $line 
            #Write-Host $totalnum","$count
            if($totalnum -eq $count)
            {
                $filteredcontent = $filteredcontent + $line
            }else{
                $filteredcontent = $filteredcontent + $line + "`n"
            }
        }

        if($count %10000 -eq 0){
            #write-host $count
        }
    }

    #Write-Host $filteredcontent.ToString().Length

    #$filteredcontent | Out-File -FilePath "C:\Users\l230445\Documents\B02\script\result\$file" -Encoding UTF8
    if($has_mod)
    {
        $mod_files.Add($file);
        $mod_row_num.Add($row_num);
        $mod_file_idx = $mod_file_idx  + 1;
    }

    $destpath = $resultpath + $file
    write-host "filteredcontent=["$filteredcontent"]"
    if($null -ne $filteredcontent -and "" -ne $filteredcontent.Trim()){
        $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
        [System.IO.File]::WriteAllLines($destpath , $filteredcontent, $Utf8NoBomEncoding)
    }else{
        write-host "NULL"
        New-Item -Path $destpath -ItemType File   -Force | Out-Null
    }


    $end_today = Get-Date
    $diff_exec = $end_today  -$today
    write-host " Done " $diff_exec  

    $objMessage = New-Object System.Object
    $objMessage | Add-Member -type NoteProperty -name FileName -value $file
    $objMessage | Add-Member -type NoteProperty -Name Num_of_Record -Value $totalnum
    $objMessage | Add-Member -type NoteProperty -Name Exec_Duration -Value $diff_exec
    $table += $objMessage

    #write-host "===================="

}
$end_today = Get-Date
$obj = $end_today  - $start_today
write-host `r`n"Completed All " $end_today" : druation = " $obj
write-host "Remove" $allmem

#$table | Format-Table FileName,Num_of_Record,Exec_Duration ¡VAutoSize

$i  = 0 
foreach($file in $mod_files)
{
    $src = $resultpath + $file
    $des = $modpath + $file
    copy-item -Path $src -Destination $des
    write-host $file " modified," $mod_row_num[$i] "row removed"
    $i = $i +1
}




#get-content .\20241009-MEMUNTMOV-DELTA-001.txt | select-string -pattern $str -NotMatch | out-file .\result\20241009-MEMUNTMOV-DELTA-001.txt  






#   foreach($line in $fileContent) {
#       
#       if($count % 5000 -eq 0)
#       {
#           #$today = Get-Date
#           #write-host $count "/" $totalnum " " $today
#       }
#       if($line -match ($allmem))
#       {
#           #write-host "Remove"
#       }
#       else
#       {
#           if($line -ne "")
#           {
#               if($count   -eq $totalnum - 1) 
#               {
#                   $content = $content + $line
#               }
#               else
#               {
#                   $content = $content + $line + "`r`n"
#               }
#           }
#       }
#       #write-host $line
#       #foreach($memnum in $memArray)
#       #{
#            #write-host $memnum
#           #if($line -contains $memnum)
#           #{
#               #write-host "FoundXXXXXXXXXXXXXXXXXXXXXXXXXXX"
#           #}   
#       #}
#
#       #write-host "------"
#       $count =  $count  +1
#   }
#   if($count -eq 0)
#   { 
#       write-host "zero"
#       New-Item -Path ".\result\$file" -ItemType File   -Force
#   }else{
#       $Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
#       [System.IO.File]::WriteAllLines(".\result\$file", $content, $Utf8NoBomEncoding)
#   }