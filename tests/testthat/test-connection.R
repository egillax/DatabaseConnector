library(testthat)

test_that("Open and close connection", {
  # Postgresql --------------------------------------------------
  details <- createConnectionDetails(
    dbms = "postgresql",
    user = Sys.getenv("CDM5_POSTGRESQL_USER"),
    password = URLdecode(Sys.getenv("CDM5_POSTGRESQL_PASSWORD")),
    server = Sys.getenv("CDM5_POSTGRESQL_SERVER")
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_equal(dbms(connection), "postgresql")
  expect_true(disconnect(connection))

  # SQL Server --------------------------------------------------
  details <- createConnectionDetails(
    dbms = "sql server",
    user = Sys.getenv("CDM5_SQL_SERVER_USER"),    
    password = URLdecode(Sys.getenv("CDM5_SQL_SERVER_PASSWORD")),
    server = Sys.getenv("CDM5_SQL_SERVER_SERVER")
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_equal(dbms(connection), "sql server")
  expect_true(disconnect(connection))

  # Oracle --------------------------------------------------
  details <- createConnectionDetails(
    dbms = "oracle",
    user = Sys.getenv("CDM5_ORACLE_USER"),
    password = URLdecode(Sys.getenv("CDM5_ORACLE_PASSWORD")),
    server = Sys.getenv("CDM5_ORACLE_SERVER")
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_equal(dbms(connection), "oracle")
  expect_true(disconnect(connection))

  # RedShift  --------------------------------------------------
  details <- createConnectionDetails(
    dbms = "redshift",
    user = Sys.getenv("CDM5_REDSHIFT_USER"),
    password = URLdecode(Sys.getenv("CDM5_REDSHIFT_PASSWORD")),
    server = Sys.getenv("CDM5_REDSHIFT_SERVER")
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_equal(dbms(connection), "redshift")
  expect_true(disconnect(connection))
})

test_that("Open and close connection using connection strings with embedded user and pw", {
  # Postgresql --------------------------------------------------
  parts <- unlist(strsplit(Sys.getenv("CDM5_POSTGRESQL_SERVER"), "/"))
  host <- parts[1]
  database <- parts[2]
  port <- "5432"
  connectionString <- paste0(
    "jdbc:postgresql://",
    host,
    ":",
    port,
    "/",
    database,
    "?user=",
    Sys.getenv("CDM5_POSTGRESQL_USER"),
    "&password=",
    URLdecode(Sys.getenv("CDM5_POSTGRESQL_PASSWORD"))
  )
  details <- createConnectionDetails(dbms = "postgresql", connectionString = connectionString)
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_true(disconnect(connection))

  # SQL Server --------------------------------------------------
  connectionString <- paste0(
    "jdbc:sqlserver://",
    Sys.getenv("CDM5_SQL_SERVER_SERVER"),
    ";user=",
    Sys.getenv("CDM5_SQL_SERVER_USER"),
    ";password=",
    URLdecode(Sys.getenv("CDM5_SQL_SERVER_PASSWORD"))
  )

  details <- createConnectionDetails(dbms = "sql server", connectionString = connectionString)
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_true(disconnect(connection))

  # Oracle --------------------------------------------------
  port <- "1521"
  parts <- unlist(strsplit(Sys.getenv("CDM5_ORACLE_SERVER"), "/"))
  host <- parts[1]
  sid <- parts[2]

  connectionString <- paste0(
    "jdbc:oracle:thin:",
    Sys.getenv("CDM5_ORACLE_USER"),
    "/",
    URLdecode(Sys.getenv("CDM5_ORACLE_PASSWORD")),
    "@",
    host,
    ":",
    port,
    ":",
    sid
  )

  details <- createConnectionDetails(dbms = "oracle", connectionString = connectionString)
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_true(disconnect(connection))

  # RedShift --------------------------------------------------
  parts <- unlist(strsplit(Sys.getenv("CDM5_REDSHIFT_SERVER"), "/"))
  host <- parts[1]
  database <- parts[2]
  port <- "5439"
  connectionString <- paste0(
    "jdbc:redshift://",
    host,
    ":",
    port,
    "/",
    database,
    "?user=",
    Sys.getenv("CDM5_REDSHIFT_USER"),
    "&password=",
    URLdecode(Sys.getenv("CDM5_REDSHIFT_PASSWORD"))
  )
  details <- createConnectionDetails(
    dbms = "redshift",
    connectionString = connectionString
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_true(disconnect(connection))

  # Spark --------------------------------------------------
  # Disabling Spark unit tests until new testing server is up
  # connectionString <- sprintf(
  #   "%s;UID=%s;PWD=%s",
  #   Sys.getenv("CDM5_SPARK_CONNECTION_STRING"),
  #   Sys.getenv("CDM5_SPARK_USER"),
  #   URLdecode(Sys.getenv("CDM5_SPARK_PASSWORD"))
  # )
  # 
  # details <- createConnectionDetails(
  #   dbms = "spark",
  #   connectionString = connectionString
  # )
  # connection <- connect(details)
  # expect_true(inherits(connection, "DatabaseConnectorConnection"))
  # expect_true(disconnect(connection))

  # Snowflake --------------------------------------------------
  # Disable Snowflake unit tests until we have a testing server
  # connectionString <- sprintf(
  #   "%s;UID=%s;PWD=%s",
  #   Sys.getenv("CDM5_SNOWFLAKE_CONNECTION_STRING"),
  #   Sys.getenv("CDM5_SNOWFLAKE_USER"),
  #   URLdecode(Sys.getenv("CDM5_SNOWFLAKE_PASSWORD"))
  # )
  # 
  # details <- createConnectionDetails(
  #   dbms = "snowflake",
  #   connectionString = connectionString
  # )
  # connection <- connect(details)
  # expect_true(inherits(connection, "DatabaseConnectorConnection"))
  # expect_true(disconnect(connection))
})

test_that("Open and close connection using connection strings with separate user and pw", {
  # Postgresql --------------------------------------------------
  parts <- unlist(strsplit(Sys.getenv("CDM5_POSTGRESQL_SERVER"), "/"))
  host <- parts[1]
  database <- parts[2]
  port <- "5432"
  connectionString <- paste0("jdbc:postgresql://", host, ":", port, "/", database)
  details <- createConnectionDetails(
    dbms = "postgresql",
    connectionString = connectionString,
    user = Sys.getenv("CDM5_POSTGRESQL_USER"),
    password = URLdecode(Sys.getenv("CDM5_POSTGRESQL_PASSWORD"))
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_true(disconnect(connection))

  # SQL Server --------------------------------------------------
  connectionString <- paste0("jdbc:sqlserver://", Sys.getenv("CDM5_SQL_SERVER_SERVER"))
  details <- createConnectionDetails(
    dbms = "sql server",
    connectionString = connectionString,
    user = Sys.getenv("CDM5_SQL_SERVER_USER"),
    password = URLdecode(Sys.getenv("CDM5_SQL_SERVER_PASSWORD"))
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_true(disconnect(connection))

  # Oracle --------------------------------------------------
  port <- "1521"
  parts <- unlist(strsplit(Sys.getenv("CDM5_ORACLE_SERVER"), "/"))
  host <- parts[1]
  sid <- parts[2]
  connectionString <- paste0("jdbc:oracle:thin:@", host, ":", port, ":", sid)
  details <- createConnectionDetails(
    dbms = "oracle",
    connectionString = connectionString,
    user = Sys.getenv("CDM5_ORACLE_USER"),
    password = URLdecode(Sys.getenv("CDM5_ORACLE_PASSWORD"))
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_true(disconnect(connection))

  # RedShift --------------------------------------------------
  parts <- unlist(strsplit(Sys.getenv("CDM5_REDSHIFT_SERVER"), "/"))
  host <- parts[1]
  database <- parts[2]
  port <- "5439"
  connectionString <- paste0(
    "jdbc:redshift://",
    host,
    ":",
    port,
    "/",
    database
  )
  details <- createConnectionDetails(
    dbms = "redshift",
    connectionString = connectionString,
    user = Sys.getenv("CDM5_REDSHIFT_USER"),
    password = URLdecode(Sys.getenv("CDM5_REDSHIFT_PASSWORD"))
  )
  connection <- connect(details)
  expect_true(inherits(connection, "DatabaseConnectorConnection"))
  expect_true(disconnect(connection))

  # Spark --------------------------------------------------
  # Disabling Spark unit tests until new testing server is up
  # details <- createConnectionDetails(
  #   dbms = "spark",
  #   connectionString = Sys.getenv("CDM5_SPARK_CONNECTION_STRING"),
  #   user = Sys.getenv("CDM5_SPARK_USER"),
  #   password = URLdecode(Sys.getenv("CDM5_SPARK_PASSWORD"))
  # )
  # connection <- connect(details)
  # expect_true(inherits(connection, "DatabaseConnectorConnection"))
  # expect_equal(dbms(connection), "spark")
  # expect_true(disconnect(connection))

  # Snowflake --------------------------------------------------
  # Disable Snowflake unit tests until we have a testing server
  # details <- createConnectionDetails(
  #   dbms = "snowflake",
  #   connectionString = Sys.getenv("CDM5_SNOWFLAKE_CONNECTION_STRING"),
  #   user = Sys.getenv("CDM5_SNOWFLAKE_USER"),
  #   password = URLdecode(Sys.getenv("CDM5_SNOWFLAKE_PASSWORD"))
  # )
  # connection <- connect(details)
  # expect_true(inherits(connection, "DatabaseConnectorConnection"))
  # expect_true(disconnect(connection))
})

test_that("Error is thrown when using incorrect dbms argument", {
  expect_error(createConnectionDetails(dbms = "foobar"), "DBMS 'foobar' not supported")
  expect_error(connect(dbms = "foobar"), "DBMS 'foobar' not supported")
})

test_that("getAvailableJavaHeapSpace returns a positive number", {
  expect_gt(getAvailableJavaHeapSpace(), 0)
})

test_that("Error is thrown when forgetting password", {
  details <- createConnectionDetails(
    dbms = "postgresql",
    user = Sys.getenv("CDM5_POSTGRESQL_USER"),
    server = Sys.getenv("CDM5_POSTGRESQL_SERVER")
  )
  expect_error(connection <- connect(details), "Connection propery 'password' is NULL")
})


test_that("dbms function maps DBI connections to correct SQL dialect", {
  
  mappings <- c(
    'Microsoft SQL Server' = 'sql server',
    'PqConnection' = 'postgresql',
    'RedshiftConnection' = 'redshift',
    'BigQueryConnection' = 'bigquery',
    'SQLiteConnection' = 'sqlite',
    'duckdb_connection'  = 'duckdb')
  
  
  for(i in seq_along(mappings)) {
    driver <- names(mappings)[i]
    dialect <- unname(mappings)[i]
    mockConstructor <- setClass(driver, contains = "DBIConnection")
    mockConnection <- mockConstructor()
    expect_equal(dbms(mockConnection), dialect)
    
    # duckdb is not yet supported in the current release of SqlRender
    if(dialect != "duckdb") expect_error(checkIfDbmsIsSupported(dbms(mockConnection)), NA)
  }
})
