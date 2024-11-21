$csvPath = "C:\Users\l230445\Documents\B02\script\20241005-MEMUNTMOV-DELTA-001.txt"
$workingdir = "C:\Users\l230445\Documents\B02\script\"
$requiredCol = @("Col1","Col2","Col3","Col4","Col5","Col6","Col7","Col8","Col9","Col10","Col11","Col12","Col13","Col14","Col15","Col16")

$filelist = New-Object System.Collections.Generic.List[System.Object]

$filelist.Add("20241005-MEMUNTMOV-DELTA-001-test.txt")
$filelist.Add("20241005-UPT-DELTA-001.txt")
$filelist.Add("20241005-TRFINFU-FULL-001.txt")
$filelist.Add("20241005-TRFINAST-DELTA-001.txt")
$filelist.Add("20241005-ROIDTL-FULL-001.txt")
$filelist.Add("20241005-RCDTL-DELTA-001.txt")
$filelist.Add("20241005-MVTYPE-FULL-001.txt")
$filelist.Add("20241005-MEMVEST-DELTA-001.txt")
$filelist.Add("20241005-MEMUNTMOV-DELTA-001.txt")
$filelist.Add("20241005-MEMUNTBAL-DELTA-001.txt")
$filelist.Add("20241005-MEMSALHIS-DELTA-001.txt")
$filelist.Add("20241005-MEMPENDTM-FULL-001.txt")
$filelist.Add("20241005-MEMPENDPP-FULL-001.txt")
$filelist.Add("20241005-MEMINVMDT-DELTA-001.txt")
$filelist.Add("20241005-MEMDTL-DELTA-001.txt")
$filelist.Add("20241005-IVRPINER-DELTA-001.txt")
$filelist.Add("20241005-IVRPIN-DELTA-001.txt")
$filelist.Add("20241005-INVDTL-FULL-001.txt")
$filelist.Add("20241005-ERPENDSET-FULL-001.txt")
$filelist.Add("20241005-EMPDTL-DELTA-001.txt")
$filelist.Add("20241005-CONTDESC-FULL-001.txt")
$filelist.Add("20241005-CNTRL-0-B02.TXT")

#$csvContent  = import-csv -Delimiter "`t"  -path $csvPath #-Header col1,col2,col3,col4,col5,col6,col7,col8,col9,col10,col11,col12,col13,col14,col15,col16
$expectedcoltypes = @('string','string','string','string','string','string','string','string','string','string','string','string','string','string','string','string')

function check-type{
    param ($value, $type)
    swtich ($type) {
        'int' 
        { 
            return [int]::TryParse($value, [ref]0) 
        }
        'string' 
        { 
            return $true
        }
        default 
        { 
            return $false
        }
    }
}

$incorrectRow =@()

$colCounts = New-Object System.Collections.Generic.List[System.Object]


foreach($file in $filelist) {

    $filepath = $workingdir  + $file
    $colCounts.Clear();
    $idx =0 
    foreach($line in Get-Content $filepath -Encoding "UTF8") {
        $idx = $idx + 1 
        $colCount = $line.Split("`t").Count
        if($colCounts -notcontains $colCount)
        {
            $colCounts.Add($colCount)
            if($colCounts.Count -gt 1)
            {
                Write-host $idx " different " $line
             }
        }
    }
    foreach($colCount in $colCounts)
    {
        Write-host $file $colCount
    }
}



if ($incorrectRows.Count -gt 0) {
    #write-host "Row wrong" 
    #$incorrectRows | ForEach-Object { Write-Host $_ }
}else {
    #write-host "All correct"
}