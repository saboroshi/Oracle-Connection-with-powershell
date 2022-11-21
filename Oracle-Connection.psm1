<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2021 v5.8.196
	 Created on:   	2022. 10. 03. 21:45
	 Created by:   	Cservenyi Szabolcs
	 Organization: 	
	 Filename:     	Oracle-Connection.psm1
	 ReleaseNotes:	The module helps you connect to an Oracle database and run arbitrary queries.
					To use it, you need the Oracle.ManagedDataAccess.dll file of the ODP.NET component 
					in the Oracle Data Access Components (ODAC) package, which contains the .NET objects.

					Example
  					Oracle-Connect -OraUsername "<username>" -OraPassword "<password>" -OraDataSource (DESCRIPTION= (ADDRESS=(<protocol_address_information>))(CONNECT_DATA= (SERVICE_NAME=<service_name>)))
	 Version:		1.0
	-------------------------------------------------------------------------
	 Module Name: Oracle-Connection
	===========================================================================
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

Export-ModuleMember Oracle-Connection





