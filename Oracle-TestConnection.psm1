<#	
	===========================================================================
	 Created with: 	SAPIEN Technologies, Inc., PowerShell Studio 2021 v5.8.196
	 Created on:   	2022. 10. 03. 21:57
	 Created by:   	Cservenyi Szabolcs
	 Organization: 	
	 Filename:     	Oracle-TestConnection.psm1
	 ReleaseNotes:	The module helps you connect to an Oracle database and run arbitrary queries.
					To use it, you need the Oracle.ManagedDataAccess.dll file of the ODP.NET component 
					in the Oracle Data Access Components (ODAC) package, which contains the .NET objects.

					Example
  					Oracle-Connect -OraUsername "<username>" -OraPassword "<password>" -OraDataSource (DESCRIPTION= (ADDRESS=(<protocol_address_information>))(CONNECT_DATA= (SERVICE_NAME=<service_name>)))
	 Version:		1.0
	-------------------------------------------------------------------------
	 Module Name: Oracle-TestConnection
	===========================================================================
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

Export-ModuleMember Oracle-TestConnection





