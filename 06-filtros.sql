//INPUTFIELD FechaDesde;
//INPUTFIELD FechaHasta;

/*Dimensiones Filtro*/
FiltroDireccion:
LOAD
DireccionFiltro,
//DireccionFiltro as DIRECCION,
//TipoDocumentoFiltro as [Tipo Documento (Sigla)],
UsuarioFiltro;
SQL
SELECT  distinct(case
         when dd.Oficina='DIRECCION NACIONAL' 
         then 'DNAL'
         when dd.Oficina='DIRECCION REGIONAL COCHABAMBA' 
         then 'DRCB'
         when dd.Oficina='DIRECCION REGIONAL SANTA CRUZ'
         then 'DRSC'
         when dd.Oficina='DIRECCION REGIONAL LA PAZ'     
         then 'DRLP'
       end 		)										   as  'DireccionFiltro',
	  ci.SiglaTipoDocumentoProceso 'TipoDocumentoFiltro',
			 dd.Usuario 'UsuarioFiltro'
  FROM [MINAJPRODUCCION].[dbo].[Datawarehouse.DimDireccionDepartamentoUsuarios] dd,
       [MINAJPRODUCCION].[dbo].[AlmacenCorporativo.Cites] ci
  where dd.usuario<>''
     //and dd.Oficina <> 'DIRECCION NACIONAL'
	 and ci.Oficina=dd.Oficina
	 and ci.Usuario= dd.Usuario
 group by dd.Oficina,
          ci.SiglaTipoDocumentoProceso,
          dd.Usuario;


FiltroTiempo:
LOAD  [AñoFiltro] as [AñoFiltro],
           [MesFiltro]  as [MesFiltro],
           [SemestreFiltro]   as  [SemestreFiltro],
           [TrimestreFiltro]   as  [TrimestreFiltro];
SQL
select anio            'AñoFiltro',
       case   
          when mes = 1 then  'ene'
          when mes = 2 then  'feb'
          when mes = 3 then  'mar'
          when mes = 4 then  'abr'
          when mes = 5 then  'may'
          when mes = 6 then  'jun'
          when mes = 7 then  'jul'
          when mes = 8 then  'ago'
          when mes = 9 then  'sep'
          when mes = 10 then 'oct'
          when mes = 11 then 'nov'
          when mes = 12 then 'dic'
          when mes is null then 'NA'
        end         'MesFiltro',
       NombreSemestre  'SemestreFiltro',
       NombreTrimestre 'TrimestreFiltro'
  from [MINAJPRODUCCION].[dbo].[Datawarehouse.DimTiempo]
 where anio>= $(vAnioInicioBI)
   and anio<= year(getdate()) 
 group by anio,Mes, NombreSemestre, NombreTrimestre;


FechaActualizacion:
SQL
	//select max(FechaActualizacion) 'Fecha Actualización' from MINAJPRODUCCION.dbo.[Datawarehouse.THPromociones];
	select distinct getdate()  'Fecha Actualización' from MINAJPRODUCCION.dbo.[Datawarehouse.THPromociones];


FiltroFechas:
LOAD
 [Fechas]  as  [Fechas];
SQL
select 'Fecha Autorización' Fechas
   union
select 'Fecha Recepción Secretaria'
union
select 'Fecha Cite' ;



FiltroFechasSA:
LOAD
 [FechasSA]  as  [FechasSA];
SQL

select 'Fecha AAPA' FechasSA
   union
select 'Fecha AFA' 
  union
select 'Fecha RS' 
  union
select 'Fecha Autorización' 
  union
select 'Fecha Informe Detección' 
  union
select 'Fecha Recepción Trámite'
  union
select 'Fecha Cite Asociado';

FiltroFechasPFI:
LOAD
 [FechasPFI]  as  [FechasPFI];
SQL
select 'Fecha Informe Fiscalización' FechasPFI
  union
select 'Fecha Memo Asignación'
  union
select 'Fecha Notificación Orden'
union
select 'Fecha Orden Fiscalizacion' ;

