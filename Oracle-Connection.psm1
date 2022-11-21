<#
 .Synopsis
  Connecting to an Oracle database.

 .Description
  The module helps you connect to the Oracle database and run arbitrary queries.
  To use it, you need the ODP.NET component in the Oracle Data Access Components (ODAC) package,
  Oracle.ManagedDataAccess.dll file that contains the .NET objects.

  https://www.oracle.com/database/technologies/odac-nuget-downloads.html
  https://download.oracle.com/otn/other/ole-oo4o/Oracle.ManagedDataAccess.12.2.1100.nupkg

 .Parameter OraUsername
  A username is required to connect to the database.

 .Parameter OraPassword
  The password required to connect to the database.

 .Parameter OraDataSource
  The tnsname address required to access the database server.

 .Parameter Query
  The script/query to run on the database.
  
  .Parameter DLLPath
  The path to the Oracle.ManagedDataAccess.dll file.

 .Example
  Oracle-Connection -Username "<username>" 
  		    -Password "<password>" 
                    -DataSource (DESCRIPTION= (ADDRESS=(<protocol_address information>))(CONNECT_DATA= (SERVICE_NAME=<service_name>)))
		    -Query "SELECT * FROM <DATABASE.TABLE> WHERE ....."
		    -DLLPath "C:\Oracle\Oracle.ManagedDataAccess.dll"
#>

function Oracle-Connection
{
	param
	(
		$Username = "",
		$Password = "",
		$DataSource = "",
		$Query = "",
		$DLLPath = ""
	)
	Add-Type -Path "$DLLPath"
	$ConnectionString = 'User Id=' + $Username + ';Password=' + $Password + ';Data Source=' + $DataSource
	$Connection = New-Object Oracle.ManagedDataAccess.Client.OracleConnection($ConnectionString)
	$Connection.Open()
	$Command = New-Object Oracle.ManagedDataAccess.Client.OracleCommand
	$Command.Connection = $Connection
	$Command.CommandText = $Query
	$DataSet = New-Object system.Data.DataSet
	$DataAdapter = New-Object Oracle.ManagedDataAccess.Client.OracleDataAdapter($Command)
	[void]$DataAdapter.Fill($DataSet)
	return $DataSet.Tables[0]
	$Connection.Close()
}

#Export-ModuleMember Oracle-Connection





