USE MASTER 
GO 

CREATE DATABASE ContosoUniversity ON  
  PRIMARY  
  (  
   NAME       = tngmgr_Data , 
   FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\DATA\ContosoUniversity_Data.MDF' , 
   SIZE       = 10MB      , 
   MAXSIZE    = UNLIMITED , 
   FILEGROWTH = 10MB 
  ) 
  LOG ON  
  ( 
   NAME       = tngmgr_Log , 
   FILENAME   = 'C:\Program Files\Microsoft SQL Server\MSSQL12.SQLEXPRESS\MSSQL\LOG\ContosoUniversity_Log.LDF'  ,
   SIZE       = 10MB      , 
   MAXSIZE    = UNLIMITED , 
   FILEGROWTH = 10MB   
  ) 
GO

