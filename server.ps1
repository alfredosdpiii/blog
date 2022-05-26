function Invoke-Server
{
  $program_root_path = "$($Env:Programfiles)/"
  function Connect-Postgres
  {
    WRITE-HOST "Type:"
    WRITE-HOST "Postgres Server"
    WRITE-HOST "`tY/y to start"
    WRITE-HOST "`tN/n to stop"
    WRITE-HOST "`tR/r to restart"

    $server_choice = READ-HOST
    WRITE-HOST " "

    if ($server_choice -eq "Y" -and $server_choice -eq "y")
    {
      pg_ctl start -D "$($program_root_path)PostgreSQL\13\data"
    } elseif ($server_choice -eq "N" -and $server_choice -eq "n")
    {
      pg_ctl stop -D "$($program_root_path)PostgreSQL\13\data"
    }

    elseif ($server_choice -eq "R" -and $server_choice -eq "r")
    {
      pg_ctl restart -D "$($program_root_path)PostgreSQL\13\data"
    }
  }

  function Get-Queries
  {

    $WhatNext = ""

    function Invoke-Queries
    {
      $User = "admin"
      $Password = "admin1234"
      # $DBname = "RubyBackend"
      $DBname = "blog_dev"
      $Query = Get-Content -Path .\postgres_query.sql -RAW

      psql -c "$($Query)" "user=$($User) dbname=$($DBname) password=$($Password)"
    }

    while ($WhatNext -ne "0")
    {
      WRITE-HOST "Querying in Postgres"
      WRITE-HOST "Type"
      WRITE-HOST "`t0 to stop querying"
      WRITE-HOST "`tany key to read query update"
      WRITE-HOST ""
      Invoke-Queries
      $WhatNext = READ-HOST

      CLEAR-HOST
    }
  }

  function Close-Server
  {
    $Time = 2
    WRITE-HOST "Closing Server in $($Time), Please wait..."
    Timeout /T $Time
    pg_ctl stop -D "$($program_root_path)PostgreSQL\13\data"
  }


  Connect-Postgres

  CLEAR-HOST

  WRITE-HOST " "
  WRITE-HOST " "

  Get-Queries

  Close-Server
}

Invoke-Server
