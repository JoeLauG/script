import shutil
import os
import io
import paramiko
from datetime import datetime
from ftplib import FTP

todaydatestr = datetime.today().strftime("%Y%m%d")

print("create backup " + todaydatestr)

tmp_b02path = "//shhkgfsv001/f-drive/temp/B02_" + todaydatestr
cli_path = "//SHHKGFSV003/InformationTechnology/PRE/ClientDelta/"+ todaydatestr
clibk_path = "//SHHKGFSV003/InformationTechnology/PRE/ClientDelta/"+ todaydatestr + "/backup"

if not (os.path.exists(tmp_b02path)):
	os.makedirs(tmp_b02path)
	print(tmp_b02path + " created")
else:
	print(tmp_b02path + " already created")
	
if not (os.path.exists(cli_path)):
	os.makedirs(cli_path)
	print(cli_path + " created")
else:
	print(cli_path + " already created")
	
if not (os.path.exists(clibk_path)):
	os.makedirs(clibk_path)
	print(clibk_path + " created")
else:
	print(clibk_path + " already created")

	
sftp_host="172.17.84.156"
sftp_user="mpfftpuser"
sftp_password="mpfftpuser"
sftp_port = 22
remote_dir ="/u01/SFTP_ROOT/MPF/outbox/B02/"
#testing
#remote_dir ="/u01/SFTP_ROOT/MPF/outbox/archive/DAILY/B02/20241120/"

local_dir="C:/Users/l230445/Documents/B02/script/"

transport = paramiko.Transport((sftp_host, sftp_port))
transport.connect(username = sftp_user, password=sftp_password)
sftp = paramiko.SFTPClient.from_transport(transport)

sftp.chdir(remote_dir)

file_list =sftp.listdir()

print(file_list)

for file_name in file_list:
	local_file_path = os.path.join(local_dir,file_name)
	remote_file_path = os.path.join(remote_dir,file_name)
	#print("downloading from " + remote_file_path +" to " +  local_file_path, end=" ")
	sftp.get(remote_file_path,local_file_path)
	print("download " +  file_name + " Done")
	
sftp.close()
transport.close()

print("All file downloaded")
print()
print("start copy to B02, ClientDelta and backup")
for file_name in file_list:
	local_file_path = local_dir + file_name
	b02_file_path =  tmp_b02path + "/" + file_name
	cli_file_path = cli_path + "/" + file_name
	clibk_file_path = clibk_path + "/" + file_name
	if not (os.path.exists(b02_file_path)):
		shutil.copy(local_file_path, b02_file_path)
		#print("copy " +  b02_file_path + " Done")
	else:
		print("already exist " +  b02_file_path + ", skip copy")
	if not (os.path.exists(cli_file_path)):
		shutil.copy(local_file_path, cli_file_path)
		#print("copy " +  cli_file_path + " Done")
	else:
		print("already exist " +  cli_file_path + ", skip copy")
	if not (os.path.exists(clibk_file_path)):
		shutil.copy(local_file_path, clibk_file_path)
		#print("copy " +  clibk_file_path + " Done")
	else:
		print("already exist " +  clibk_file_path + ", skip copy")
	print("Copy " + file_name + " done")
	
print("All file done")
#ftp = FTP (ftp_host)
#ftp.login(user=ftp_user, passwd=ftp_password)

#ftp.cwd(remote_dir)

#file_list= ftp.nlst()

#for file_name in file_list:
	#local_file_path = os.path.join(local_dir,file_name)
	#with open(local_file_path ,'wb') as local_file:
		#ftp.retrbinary(f'RETR {file_name}',lcoal_file.write)
		#print("download " +  file_name + " Done")
		
#ftp.quit

