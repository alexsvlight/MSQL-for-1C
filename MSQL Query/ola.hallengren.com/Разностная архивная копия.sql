/*
DatabaseBackup is the SQL Server Maintenance Solutionís stored procedure
for backing up databases. DatabaseBackup is supported on SQL Server 2005,
SQL Server 2008, SQL Server 2008 R2, SQL Server 2012, and SQL Server 2014.

(c) Ola Hallengren 
Full documentation https://ola.hallengren.com/sql-server-backup.html
*/
Use [master]

Declare @StrVer nvarchar(12), @ver int;
Set @StrVer = Convert (nvarchar, SERVERPROPERTY('productversion'));
Select @ver = Convert (int, SUBSTRING (@StrVer,0 , CHARINDEX(N'.', @StrVer)));
If @Ver < 9 
Begin
	RaisError ('#gs{TASK_OLA_INCORRECT_SQL_VERSION_WARNING}#', 16,1) WITH NOWAIT
	return
End

EXECUTE dbo.DatabaseBackup
@Databases = '?DataBaseName?',
@Directory = N'?BackupDirectory?',
@BackupType = 'DIFF',
@Verify = '?VerifyBackup?',
@CheckSum = 'Y',
@CleanupTime = ?CleanupTime?,
@LogToTable = 'N'