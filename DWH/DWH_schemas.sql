SELECT *
INTO [dbo].[Datawarehouse.THPromociones1]
FROM [dbo].[Datawarehouse.THPromociones];

SELECT *
INTO [dbo].[Datawarehouse.THProcesosFiscalizaciones1]
FROM [dbo].[Datawarehouse.THProcesosFiscalizaciones];

SELECT *
INTO [dbo].[Datawarehouse.THModalidadesPremiaciones1]
FROM [dbo].[Datawarehouse.THModalidadesPremiaciones];

SELECT *
INTO [dbo].[Datawarehouse.THDocumentos1]
FROM [dbo].[Datawarehouse.THDocumentos];

SELECT *
INTO [dbo].[Datawarehouse.THSanciones1]
FROM [dbo].[Datawarehouse.THSanciones];

SELECT *
INTO [dbo].[Datawarehouse.THTramites1]
FROM [dbo].[Datawarehouse.THTramites];

/*
TRUNCATE TABLE [dbo].[Datawarehouse.THDocumentos];
TRUNCATE TABLE [dbo].[Datawarehouse.THModalidadesPremiaciones];
TRUNCATE TABLE [dbo].[Datawarehouse.THProcesosFiscalizaciones];
TRUNCATE TABLE [dbo].[Datawarehouse.THPromociones];
TRUNCATE TABLE [dbo].[Datawarehouse.THSanciones];
TRUNCATE TABLE [dbo].[Datawarehouse.THTramites];
*/
