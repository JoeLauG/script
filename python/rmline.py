import os
import io
import array as arr
import shutil
from datetime import datetime
import sys

todaydatestr = datetime.today().strftime("%Y%m%d")

rundtstr= ""
if len(sys.argv) > 1:
	rundtstr= sys.argv[1]
else:
	rundtstr= todaydatestr
print ("rundtstr" +rundtstr)

inputpath = "C:/Users/l230445/Documents/B02/script/input.txt"
workingpath = "C:/Users/l230445/Documents/B02/script/"
resultpath = "C:/Users/l230445/Documents/B02/script/result/"
modpath = "C:/Users/l230445/Documents/B02/script/mod/"
logpath = "C:/Users/l230445/Documents/B02/script/log/"

inputlogfile = "C:/Users/l230445/Documents/B02/script/inputlog.txt"
logfile = "C:/Users/l230445/Documents/B02/script/log.txt"
invalidlogfile = "C:/Users/l230445/Documents/B02/script/invalidlog.txt"

b02_path = "//shhkgfsv001/f-drive/temp/B02_" + todaydatestr + "/"
cli_path = "//SHHKGFSV003/InformationTechnology/PRE/ClientDelta/"+ todaydatestr+ "/"

counter = 0

if(os.path.exists(logfile)):
	tmp_log_file =""
	while(True):
		tmp_log_file = logpath +"log-"+ todaydatestr +"-" +str(counter) + ".txt"
		counter = counter  +1
		if not os.path.exists(tmp_log_file):
			break
	shutil.copy(logfile, tmp_log_file)
	
counter = 0
if(os.path.exists(inputlogfile)):
	tmp_log_file =""
	while(True):
		tmp_log_file = logpath +"inputlog-"+ todaydatestr  + "-" + str(counter) + ".txt"
		counter = counter  +1
		if not os.path.exists(tmp_log_file):
			break
	shutil.copy(inputpath,tmp_log_file)
else:
	shutil.copy(inputpath,inputlogfile)


filter_words = set()

with open(inputpath,'r', encoding='utf-8') as file:
	for line in file:
		line = line.strip()
		if line:
			line = line.replace("FUND_CODE='DE1' AND MEMBER_NUMBER=",'')
			line = line.replace("FUND_CODE='ELT' AND MEMBER_NUMBER=",'')
			line = line.replace("'",'')
			line = line.replace("",'')
			line = line.replace(")",'')
			line = line.replace("(",'')
			line = line.replace(",",'')
			line = line.replace("\"",'')
			filter_words.add(line)
			
print("Filter words",filter_words)

files = []
mod_files = []
num_rows  = []

file_bal2 = workingpath + rundtstr + "-MEMUNTBAL-DELTA-002.txt"
file_bal3 = workingpath + rundtstr + "-MEMUNTBAL-DELTA-003.txt"
file_bal4 = workingpath + rundtstr + "-MEMUNTBAL-DELTA-004.txt"

files.append(rundtstr + "-MEMUNTBAL-DELTA-001.txt") 
if(os.path.exists(file_bal2)):
    tmp_file_bal2 = rundtstr + "-MEMUNTBAL-DELTA-002.txt"
    files.append(tmp_file_bal2)
	
if(os.path.exists(file_bal3)):
    tmp_file_bal3 = rundtstr + "-MEMUNTBAL-DELTA-003.txt"
    files.append(tmp_file_bal3)
	
if(os.path.exists(file_bal4)):
    tmp_file_bal4 = rundtstr + "-MEMUNTBAL-DELTA-004.txt"
    files.append(tmp_file_bal4)

files.append(rundtstr + "-MEMINVMDT-DELTA-001.txt")
files.append(rundtstr + "-MEMUNTMOV-DELTA-001.txt") #9xxx
files.append(rundtstr + "-MEMSALHIS-DELTA-001.txt")  #2xxx
files.append(rundtstr + "-TRFINFU-FULL-001.txt")

files.append(rundtstr + "-MEMVEST-DELTA-001.txt")
files.append(rundtstr + "-UPT-DELTA-001.txt")
files.append(rundtstr + "-TRFINAST-DELTA-001.txt")
files.append(rundtstr + "-ROIDTL-FULL-001.txt")
files.append(rundtstr + "-RCDTL-DELTA-001.txt")
files.append(rundtstr + "-MVTYPE-FULL-001.txt")
files.append(rundtstr + "-MEMPENDTM-FULL-001.txt")
files.append(rundtstr + "-MEMPENDPP-FULL-001.txt")
files.append(rundtstr + "-MEMDTL-DELTA-001.txt")
files.append(rundtstr + "-IVRPINER-DELTA-001.txt")
files.append(rundtstr + "-IVRPIN-DELTA-001.txt")
files.append(rundtstr + "-INVDTL-FULL-001.txt")
files.append(rundtstr + "-ERPENDSET-FULL-001.txt")
files.append(rundtstr + "-EMPDTL-DELTA-001.txt")
files.append(rundtstr + "-CONTDESC-FULL-001.txt")
files.append(rundtstr + "-CNTRL-0-B02.TXT")

#files.append(rundtstr + "-EMPDTL-DELTA-001-test.txt")

def contains_filter_words(line, filter_words):
	for word in filter_words:
		#print(word,"=",line)
		if word in line:
			return word
	return None

for file in files:
	has_mod = False
	num_row = 0
	filepath = workingpath + file
	outpath = resultpath + file
	logmsg = ""
	with io.open(filepath,'r',encoding='utf-8') as infile,io.open(outpath, 'w', encoding='utf-8') as outfile, io.open(logfile, 'a', encoding='utf-8') as logoutfile:
		print("start processing ",file)
		for line in infile:
			#print("current",line)
			val = contains_filter_words(line, filter_words)
			if val is None:
				outfile.write(line)
			else:
				has_mod = True
				num_row = num_row + 1 
				logmsg = file +",Found " + val + " removed," + line 
				logoutfile.write(logmsg)
		
	if has_mod:
		mod_files.append(file)
		num_rows.append(num_row)

i = 0 
for file in mod_files:
	destpath = modpath +file
	b02_file_path = b02_path + file
	cli_file_path = cli_path + file
	outpath = resultpath + file
	shutil.copy(outpath,destpath)
	shutil.copy(outpath,b02_file_path)
	shutil.copy(outpath,cli_file_path)
	i = i + 1
	
print("Modified File:",filter_words)
i =0 
for file in mod_files:
	print(mod_files[i]," Removed:(",num_rows[i],") rows")
	i = i + 1
print("Done")

