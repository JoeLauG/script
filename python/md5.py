import hashlib
import os
import io
import array as arr
import shutil
from datetime import datetime

def md5(fname):
    hash_md5 = hashlib.md5()
    with io.open(fname, "rb") as f:
        for chunk in iter(lambda: f.read(4096), b""):
            hash_md5.update(chunk)
    return hash_md5.hexdigest()
	
rundtstr= '20241113'
datadtstr= '20241112'
controlfile = "C:/Users/l230445/Documents/B02/script/control_file.txt"
workingpath = "C:/Users/l230445/Documents/B02/script/result/"
scriptpath = "C:/Users/l230445/Documents/B02/script/"

modcntfilepath ="C:/Users/l230445/Documents/B02/script/mod/" + rundtstr + "-CNTRL-0-B02.TXT"

filelist = set()

if os.path.exists(controlfile):
    os.remove(controlfile)

filelist.add(rundtstr + "-CONTDESC-FULL-001.txt")
filelist.add(rundtstr + "-EMPDTL-DELTA-001.txt")
filelist.add(rundtstr + "-ERPENDSET-FULL-001.txt")
filelist.add(rundtstr + "-INVDTL-FULL-001.txt")
filelist.add(rundtstr + "-IVRPIN-DELTA-001.txt")
filelist.add(rundtstr + "-IVRPINER-DELTA-001.txt")


filelist.add(rundtstr + "-MEMDTL-DELTA-001.txt")
filelist.add(rundtstr + "-MEMINVMDT-DELTA-001.txt")
filelist.add(rundtstr + "-MEMPENDPP-FULL-001.txt")
filelist.add(rundtstr + "-MEMPENDTM-FULL-001.txt")
filelist.add(rundtstr + "-MEMSALHIS-DELTA-001.txt")

filelist.add(rundtstr + "-MEMUNTBAL-DELTA-001.txt")

file_bal2 = workingpath + rundtstr + "-MEMUNTBAL-DELTA-002.txt"
file_bal3 = workingpath + rundtstr + "-MEMUNTBAL-DELTA-003.txt"

if os.path.exists(file_bal2):
    tmp_file_bal2 = rundtstr + "-MEMUNTBAL-DELTA-002.txt"
    filelist.add(tmp_file_bal2)
	
if os.path.exists(file_bal3):
    tmp_file_bal3 = rundtstr + "-MEMUNTBAL-DELTA-003.txt"
    filelist.add(tmp_file_bal3)

filelist.add(rundtstr + "-MEMUNTMOV-DELTA-001.txt")
filelist.add(rundtstr + "-MEMVEST-DELTA-001.txt")
filelist.add(rundtstr + "-MVTYPE-FULL-001.txt")
filelist.add(rundtstr + "-RCDTL-DELTA-001.txt")
filelist.add(rundtstr + "-ROIDTL-FULL-001.txt")
filelist.add(rundtstr + "-TRFINAST-DELTA-001.txt")
filelist.add(rundtstr + "-TRFINFU-FULL-001.txt")
filelist.add(rundtstr + "-UPT-DELTA-001.txt")

with io.open(controlfile,'w',encoding='utf-8') as outfile,io.open(modcntfilepath,'w',encoding='utf-8') as outfile2:
	for file in filelist:
		fullfilepath = workingpath + file
		scriptfilepath =  scriptpath  + file
		if not os.path.exists(fullfilepath):
			shutil.copy(scriptfilepath,fullfilepath)
		hash = md5(fullfilepath)
		row_num = 0 
		tab = "\t"
		with io.open(fullfilepath,'r',encoding='utf-8') as ff:
			row_num = sum(1 for line in ff)
			tbl = ff.name.split("-")[1]
		
		line = rundtstr + tab + tbl +tab +file+ tab + str(row_num) +tab + hash + tab + datadtstr + "\n"
		print(line)
		outfile.write(line)
		outfile2.write(line)
	#with io.open(controlfile,'w',encoding='utf-8') as outfile:
	#	outfile.write(line)
	#with io.open(modcntfilepath,'w',encoding='utf-8') as outfile2:
	#	outfile2.write(line)
	
