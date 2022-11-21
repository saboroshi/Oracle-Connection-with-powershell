<#
 .Synopsis
  Connecting to an Oracle database.

 .Description
  The module helps in testing the connection to the Oracle database.
  To use it, you need the ODP.NET component in the Oracle Data Access Components (ODAC) package,
  Oracle.ManagedDataAccess.dll file that contains the .NET objects.

  https://www.oracle.com/database/technologies/odac-nuget-downloads.html
  https://download.oracle.com/otn/other/ole-oo4o/Oracle.ManagedDataAccess.12.2.1100.nupkg

 .Parameter Username
  A username is required to connect to the database.

 .Parameter Password
  The password required to connect to the database.

 .Parameter DataSource
  The tnsname address required to access the database server.

 .Parameter DLLPath
  The path to the Oracle.ManagedDataAccess.dll file.

 .Example
  Oracle-Connect -Username "<username>" 
                 -Password "<password>" 
		 -DataSource (DESCRIPTION= (ADDRESS=(<protocol_address information>))(CONNECT_DATA= (SERVICE_NAME=<service_name>)))
		 -DLLPath "C:\Oracle\Oracle.ManagedDataAccess.dll"
#>

function Oracle-TestConnection
{
	param
	(
		$Username = "",
		$Password = "",
		$DataSource = "",
		$Query = "",
		$DLLPath = ""
	)
	
	$ErrorActionPreference = 'Stop'
	try
	{
		Add-Type -Path "$DLLPath"
		$ConnectionString = 'User Id=' + $Username + ';Password=' + $Password + ';Data Source=' + $DataSource
		$Connection = New-Object Oracle.ManagedDataAccess.Client.OracleConnection($ConnectionString)
		$Connection.Open()
		$true
	}
	catch
	{
		$false
	}
	finally
	{
		$Connection.Close()
	}
}

#Export-ModuleMember Oracle-TestConnection





