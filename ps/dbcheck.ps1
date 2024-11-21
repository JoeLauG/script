add-type -AssemblyName System.Data.OracleClient
#add-type -AssemblyName Oracle.ManagedDataAccess

#add-type -Path  "C:\Users\l230445\product\11.2.0\client_1\ODP.NET\bin\2.x\Oracle.DataAccess.dll"

#[System.Reflection.Assembly]::LoadFrom("C:\odac\odp.net4\odp.net\bin\4\Oracle.DataAccess.dll")
#[System.Reflection.Assembly]::LoadFrom("C:\Users\l230445\product\11.2.0\client_1\ODP.NET\bin\2.x\Oracle.DataAccess.dll")

#add-type -Path  "C:\odac\odp.net4\odp.net\bin\4\Oracle.DataAccess.dll"

#add-type -Path  "C:\Users\l230445\Downloads\ODAC19.24Xcopy_x64\odp.net4\odp.net\bin\4\Oracle.DataAccess.dll"
#add-type -path "C:\Users\l230445\Documents\B02\script\dll\Oracle.DataAccess.dll"
#add-type -path "C:\Users\l230445\product\11.2.0\client_1\ODP.NET\bin\2.x\Oracle.DataAccess.dll"
#add-type -path "C:\Users\l230445\Documents\B02\script\dll\Policy.4.122.Oracle.ManagedDataAccess.dll"

$username = ""
$password = ""
$data_source = "(DESCRIPTION =(ADDRESS_LIST =(ADDRESS = (PROTOCOL = TCP)(HOST = 127.0.0.1)(PORT = 15252)))(CONNECT_DATA =(SERVICE_NAME = tmp)))"
$connection_string = "User Id=$username;Password=$password;Data Source=$data_source"
$statement = "select count(*) from users"

try{
    $con = New-Object System.Data.OracleClient.OracleConnection($connection_string)

    $con.Open()

    $cmd = $con.CreateCommand()
    $cmd.CommandText = $statement
    $result = $cmd.ExecuteReader()
    # Do something with the results...
} catch {
    Write-Error (“Database Exception: {0}`n{1}” -f `        $con.ConnectionString, $_.Exception.ToString())
} finally{
    if ($con.State -eq ‘Open’) { $con.close() }
}