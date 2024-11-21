$rundtstr= '20241009'
$datadtstr= '20241008'
$controlfile = "C:\Users\l230445\Documents\B02\script\control_file.txt"
$workingpath = "C:\Users\l230445\Documents\B02\script\result\"

$modcntfilepath ="C:\Users\l230445\Documents\B02\script\mod\" + $rundtstr + "-CNTRL-0-B02.TXT"

$filelist =New-Object System.Collections.Generic.List[System.Object]

if(test-path $controlfile)
{
    Remove-Item -Path $controlfile
}

$filelist.Add($rundtstr + "-CONTDESC-FULL-001.txt")
$filelist.Add($rundtstr + "-EMPDTL-DELTA-001.txt")
$filelist.Add($rundtstr + "-ERPENDSET-FULL-001.txt")
$filelist.Add($rundtstr + "-INVDTL-FULL-001.txt")
$filelist.Add($rundtstr + "-IVRPIN-DELTA-001.txt")
$filelist.Add($rundtstr + "-IVRPINER-DELTA-001.txt")


$filelist.Add($rundtstr + "-MEMDTL-DELTA-001.txt")
$filelist.Add($rundtstr + "-MEMINVMDT-DELTA-001.txt")
$filelist.Add($rundtstr + "-MEMPENDPP-FULL-001.txt")
$filelist.Add($rundtstr + "-MEMPENDTM-FULL-001.txt")
$filelist.Add($rundtstr + "-MEMSALHIS-DELTA-001.txt")

$filelist.Add($rundtstr + "-MEMUNTBAL-DELTA-001.txt")

$file_bal2 = $workingpath + $rundtstr + "-MEMUNTBAL-DELTA-002.txt"
$file_bal3 = $workingpath + $rundtstr + "-MEMUNTBAL-DELTA-003.txt"

if(Test-path $file_bal2)
{
    $tmp_file_bal2 = $rundtstr + "-MEMUNTBAL-DELTA-002.txt"
    $filelist.Add($tmp_file_bal2)
}
if(Test-path $file_bal3)
{
    $tmp_file_bal3 = $rundtstr + "-MEMUNTBAL-DELTA-003.txt"
    $filelist.Add($tmp_file_bal3)
}

$filelist.Add($rundtstr + "-MEMUNTMOV-DELTA-001.txt")
$filelist.Add($rundtstr + "-MEMVEST-DELTA-001.txt")
$filelist.Add($rundtstr + "-MVTYPE-FULL-001.txt")
$filelist.Add($rundtstr + "-RCDTL-DELTA-001.txt")
$filelist.Add($rundtstr + "-ROIDTL-FULL-001.txt")
$filelist.Add($rundtstr + "-TRFINAST-DELTA-001.txt")
$filelist.Add($rundtstr + "-TRFINFU-FULL-001.txt")
$filelist.Add($rundtstr + "-UPT-DELTA-001.txt")

foreach($file in $filelist)
{
    $fullfilepath = $workingpath + $file
    $hash = (Get-FileHash -Algorithm MD5 $fullfilepath).Hash.tolower()

    $row_num = 0 
    $fileContent = get-content  -Encoding "UTF8"  $fullfilepath
    $filteredcontent = $fileContent | Where-Object {
        $row_num = $row_num + 1      
    }
    $tbl = ($file -split "-")[1]

    $tab = "`t"
    $line = $rundtstr + $tab + $tbl +$tab +$file+ $tab + $row_num +$tab + $hash + $tab + $datadtstr

    Add-Content -Path $controlfile -Value $line -Encoding UTF8 -Force
    Add-Content -Path $modcntfilepath -Value $line -Encoding UTF8 -Force

    Write-Host $line 

}
