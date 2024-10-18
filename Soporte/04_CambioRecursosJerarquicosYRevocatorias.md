## Tabla [ODS.VPTRecursosJerarquicos] 
- Se regularizaron los registros en la tabla, existian registros faltantes para la gestión 2024 y 2023 que se encontraban en el XLS (base de datos DBJ, Hoja VPT-JERARQUICOS PE)
- Se actualizó la consulta en MAIN (QLIK) para eliminar la dependencia al archivo XLSX:

Anterior:
```javascript
RecursoJerarquicoPE:
  LOAD
  [RAZON SOCIAL RJ] ,
  [NIT RJ]   ,
  [DEPARTAMENTO RJ] , 
  [PROVEÍDO RJ] , 
  [FECHA PROVEIDO RJ] , 
  [ESTADO DEL TRAMITE RJ] ,
  [PERIODO RJ],
  [AÑO RJ],
  [OBSERVACIONES RJ]
  FROM [E:\MINAJ 2015\DNJ\BASE DE DATOS DNJ.xlsx]
  (ooxml, embedded labels, header is 0 lines, table is [VPT-JERARQUICOS PE]);
```

Nuevo:
```javascript
RecursoJerarquicoPE:
  LOAD
  [RazonSocial] as [RAZON SOCIAL RJ] ,
  [NIT] asd [NIT RJ]   ,
  [Departamento] as [DEPARTAMENTO RJ] , 
  [NumeroProveido] as [PROVEÍDO RJ] , 
  [FechaProveido] as [FECHA PROVEIDO RJ] , 
  [EstadoTramite] as [ESTADO DEL TRAMITE RJ] ,
  [mes] as [PERIODO RJ],
  [anio] as [AÑO RJ],
  [observaciones] as [OBSERVACIONES RJ];
  SQL
  SELECT
    RecursoJerarquicoID,
    RazonSocial,
    NIT,
    Departamento,
    NumeroProveido,
    FechaProveido,
    PosicionRatificada,
    EstadoTramite,
    case
      when month(Periodo) = 1 then 'ene'
      when month(Periodo) = 2 then 'feb'
      when month(Periodo) = 3 then 'mar'
      when month(Periodo) = 4 then 'abr'
      when month(Periodo) = 5 then 'may'
      when month(Periodo) = 6 then 'jun'
      when month(Periodo) = 7 then 'jul'
      when month(Periodo) = 8 then 'ago'
      when month(Periodo) = 9 then 'sep'
      when month(Periodo) = 10 then 'oct'
      when month(Periodo) = 11 then 'nov'
      when month(Periodo) = 12 then 'dic'
      when month(Periodo) is null then 'NA'
    end as mes,
    year(Periodo) as anio,
    'NINGUNA' as observaciones
  FROM
    [ODS.VPTRecursosJerarquicos];
```

## Tabla [dbo].[ODS.VPTRecursosJerarquicosConfirmados]
- Se verificaron los registros en la tabla, se encontraron 3 registros del mes de Abril-2024 con el año 2004, se consultó a la DNJ y se solicitó la actualización de la fecha correcta (2024)
- Los registros modificados tienen el ID
			1266 - MEFP/VPT/URJMJ N° 018	24/4/2004 a 24/4/2024
			1267 - MEFP/VPT/URJMJ N° 019	25/4/2004 a 25/4/2024
			1268 - MEFP/VPT/URJMJ N° 020	25/4/2004 a 25/4/2024
- Correo "REMITO CORRECCIONES A VPT MES DE MAYO" 
- Se creo un backup de la tabla antes de la modificación (04 ODS.VPTRecursosJerarquicosConfirmados_BKP20241017.sql)
- Se quito la condición de la Dimensión (object CH1754), "17.Cantidad de Recursos Jerárquicos con posición ratificada a favor de la AJ":
```javascript
	=if([RESUELVE RJC]='CONFIRMA',[RESUELVE RJC])
```
	
- Se actualizó la consulta en MAIN (QLIK) para eliminar la dependencia al archivo XLSX e incluir los estados solicitados por la DNJ:

Anterior:
```javascript
RecursoJerarquicoCONFIRMADOS:
  LOAD
  [RAZON SOCIAL RJC],
  [NIT O CI RJC],
  [DEPARTAMENTO RJC],
  [N° RESOLUCION RJC],
  [FECHA RJC],
  [RESUELVE RJC],
  [PERIODO RJC],
  [AÑO RJC],
  [OBSERVACIONES RJC]
  FROM [E:\MINAJ 2015\DNJ\BASE DE DATOS DNJ.xlsx]
  (ooxml, embedded labels, header is 0 lines, table is [VPT-JERARQUICOS CONF]);
```

Nuevo:
```javascript
RecursoJerarquicoCONFIRMADOS:
  LOAD
  [RazonSocial] as [RAZON SOCIAL RJC],
	[NIT] as [NIT O CI RJC],
	[Departamento] as [DEPARTAMENTO RJC],
	[NumeroResolucion] as [N° RESOLUCION RJC],
	[FechaResolucion] as [FECHA RJC],
	[Resuelve] as [RESUELVE RJC],
	[mes] as [PERIODO RJC],
	[anio] as [AÑO RJC],
	[observacion] as [OBSERVACIONES RJC];   
SQL
SELECT
	RazonSocial, NIT, Departamento, NumeroResolucion, FechaResolucion, Resuelve ,
	case
		when month(Periodo) = 1 then 'ene'
		when month(Periodo) = 2 then 'feb'
		when month(Periodo) = 3 then 'mar'
		when month(Periodo) = 4 then 'abr'
		when month(Periodo) = 5 then 'may'
		when month(Periodo) = 6 then 'jun'
		when month(Periodo) = 7 then 'jul'
		when month(Periodo) = 8 then 'ago'
		when month(Periodo) = 9 then 'sep'
		when month(Periodo) = 10 then 'oct'
		when month(Periodo) = 11 then 'nov'
		when month(Periodo) = 12 then 'dic'
		when month(Periodo) is null then 'NA'
	end as mes,
	year(Periodo) as anio,
	'' as observacion
FROM
	[ODS.VPTRecursosJerarquicosConfirmados]
WHERE
((year(Periodo)<= 2023
		and Resuelve like '%CONFIRM%' COLLATE Latin1_General_CI_AS)
	or (year(Periodo)>= 2024
		and not (Resuelve like 'REVOC_' COLLATE Latin1_General_CI_AS
			or Resuelve like 'REVOCA_' COLLATE Latin1_General_CI_AS
			or Resuelve like 'REVOC_% TOTALMENTE' COLLATE Latin1_General_CI_AS
			)));
```

## Cambios en VPTIndicadoresGestion (Actualización del indicador 11)
- Se cambió la consulta para considerar excluir a partir de la gestión 2024 los estados: 'REVOCA', 'REVOCA TOTALMENTE', 'REVOCAR', 'REVOCAR TOTALMENTE'
```javascript
select
							count(*)
				from
							[ODS.VPTRecursosRevocatoriasConfirmados]
				where
					( (year(Periodo)<= 2023
						and FormaResolucion like '%CONFIRM%' COLLATE Latin1_General_CI_AS)
					or (year(Periodo)>= 2024
						and FormaResolucion not in('REVOCA', 'REVOCA TOTALMENTE', 'REVOCAR', 'REVOCAR TOTALMENTE')) )
					and year(Periodo)= Gestion
					and month(Periodo)<= NumeroMes
				)
```

## Cambios en [VPTrevocatorias_confirm_pe] 
- Se actualizó la condición para considerar los estados solicitados para la gestión 2024: 'REVOCA', 'REVOCA TOTALMENTE', 'REVOCAR', 'REVOCAR TOTALMENTE'
```javascript
select
	ovrc.RazonSocial razonsocial_revocatorias_confirm_pe,
	NIT nit_revocatorias_confirm_pe,
	Departamento depto_revocatorias_confirm_pe,
	NumeroResolucion nroproveido_revocatorias_confirm_pe ,
	FechaResolucion fecproveido_revocatorias_confirm_pe ,
	FormaResolucion resolucion_revocatorias_confirm_pe,
	lower(left(datename(month, Periodo), 3)) mes_revocatorias_confirm_pe,
	'NINGUNA' observ_revocatorias_confirm_pe,
	Periodo periodo_revocatorias_confirm_pe
FROM
	[ODS.VPTRecursosRevocatoriasConfirmados] ovrc
where
	(
	(year(Periodo)<= 2023
		and FormaResolucion like '%CONFIRM%' COLLATE Latin1_General_CI_AS)
	or (year(Periodo)>= 2024
		and FormaResolucion not in('REVOCA', 'REVOCA TOTALMENTE', 'REVOCAR', 'REVOCAR TOTALMENTE'))
		)
order by
	Periodo,
	FechaResolucion;
```