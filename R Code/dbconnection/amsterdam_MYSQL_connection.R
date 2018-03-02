library(DBI)
library(RMySQL)

# ----------------
# Database functions
# ----------------
connectDb <- function() {
  conn <- dbConnect(
    drv = RMySQL::MySQL(),
    dbname = "open_data",
    host = "127.0.0.1",
    username = "OpenData",
    password = "Wachtwoord2018!")
  return(conn)
}

disconnectDb <- function(conn) {
  dbDisconnect(conn)
}

getGebieden <- function(conn, q = "SELECT * FROM gebieden"){
  runQuery <- dbGetQuery(conn, q)
  return(runQuery)
}

getJSONGebieden <- function(conn, q = "SELECT * FROM gebiedenjson"){
  runQuery <- dbGetQuery(conn, q)
  return(runQuery)
}

getLeefbaarheidJSONGebieden <- function(conn, q = "SELECT * FROM gebiedenleefbaarheid"){
  runQuery <- dbGetQuery(conn, q)
  return(runQuery)
}

getMetadata <- function(conn, q = "SELECT * FROM metadata"){
  runQuery <- dbGetQuery(conn, q)
  return(runQuery)
}

getKerncijfers <- function(conn, q = "SELECT * FROM kerncijfer"){
  runQuery <- dbGetQuery(conn, q)
  return(runQuery)
}

vectorToMYSQLArray <- function(x){
  returnChar <- "("
  k <- length(x)
  i <- 1
  for (variable in x) {
    if (class(variable) == "character") {
      returnChar <- paste0(returnChar, "\"",variable,"\"")
    } else {
      returnChar <- paste0(returnChar, variable)
    }
    if (i < k) {
      returnChar <- paste0(returnChar, ", ")
    }
    i <- i+1
  }
  returnChar <- paste0(returnChar, ")")
  return(returnChar)
}

