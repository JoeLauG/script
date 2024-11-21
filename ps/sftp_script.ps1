$rundtstr= "20241005"
$destdtstr = "20241005"
$src_file_path = "/u01/SFTP_ROOT/MPF/archive/DAILY/B02/"+ $destdtstr +"/"


$destpath = "C:\Users\l230445\Documents\B02\script\sftp.txt"

$newline = "`r`n"

$content  = "#!/bin/ksh" + $newline 
$content  += "lftp sftp://echngusr:dbMfCE@202.66.28.11:22 <<EOF >/u01/mpfuser/MPFBS_DataRep/MPFFileTransfer/tmp/joe_sftp.log 2>/u01/mpfuser/MPFBS_DataRep/MPFFileTransfer/tmp/joe_sftp_err_B02.log" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-CONTDESC-FULL-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-CONTDESC-FULL-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-EMPDTL-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-EMPDTL-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-ERPENDSET-FULL-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-ERPENDSET-FULL-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-INVDTL-FULL-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-INVDTL-FULL-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-IVRPIN-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-IVRPIN-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-IVRPINER-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-IVRPINER-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MEMDTL-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMDTL-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MEMINVMDT-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMINVMDT-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MEMPENDPP-FULL-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMPENDPP-FULL-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MEMPENDTM-FULL-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMPENDTM-FULL-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MEMSALHIS-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMSALHIS-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MEMUNTBAL-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMUNTBAL-DELTA-001.txt.zip" + $newline 
#$content  += "  put " + $src_file_path + $rundtstr + "-MEMUNTBAL-DELTA-002.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMUNTBAL-DELTA-002.txt.zip" + $newline 
#$content  += "  put " + $src_file_path + $rundtstr + "-MEMUNTBAL-DELTA-003.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMUNTBAL-DELTA-003.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MEMUNTMOV-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMUNTMOV-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MEMVEST-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MEMVEST-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-MVTYPE-FULL-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-MVTYPE-FULL-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-RCDTL-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-RCDTL-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-ROIDTL-FULL-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-ROIDTL-FULL-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-TRFINAST-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-TRFINAST-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-UPT-DELTA-001.txt.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-UPT-DELTA-001.txt.zip" + $newline 
$content  += "  put " + $src_file_path + $rundtstr + "-CNTRL-0-B02.TXT.zip -o /u01/SFTP_ROOT/MPF/outbox/zip/B02/"+ $destdtstr +"-CNTRL-0-B02.TXT.zip" + $newline 
$content  += "  exit" + $newline 
$content  += "EOF" + $newline 

$Utf8NoBomEncoding = New-Object System.Text.UTF8Encoding $False
[System.IO.File]::WriteAllLines($destpath , $content, $Utf8NoBomEncoding)