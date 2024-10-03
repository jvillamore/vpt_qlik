-- SIAJ
-- 11 Registros

/******** Infracciones AAPA ***********************/
select --DISTINCT  ci.CadenaCite
'PROMOCIONES EMPRESARIALES' 'TipoProceso',
       'SANCION FISCALIZACION' 'Tipo SubProceso',
       case when ci.OficinaID =1001 then 'DRLP'
	        when ci.OficinaID =1002 then 'DRSC'
			when ci.OficinaID =1003 then 'DRCB'
		end Oficina,
	   ci.CadenaCite, 
	   ci.FechaDocumento 'Fecha Cite', 
	   ci.TramiteID,
	   ts.MontoUFV, 
	   ts.Nombre, 
       ts.NormaAfectada, 
	   (select do.Descripcion  from [Transversales.Dominios] do where  do.DominioID= ts.TIpoNormaID )'Tipo Norma', 
	   'AAPA' 'TipoDocumento',
	   ts.TipoSancionID,
	   sa.FechaRegistro,
	   sa.UsuarioID,
	   case
	     when ts.EstadoID=1000 then 'ACTIVO'
		 else 'ANULADO'
	   end EstadoSancion,
	   psa.DetalleProcesoSancionID
  from [PromocionesEmpresariales.Sanciones] sa
  left join [Cites.Cites] ci on ci.TramiteID=sa.TramiteID
  join [PromocionesEmpresariales.DetallesProcesosSanciones] psa on psa.SancionID= sa.SancionID
  join [Transversales.TiposSanciones] ts on ts.TipoSancionID= psa.TipoSancionID
where 1=1
  and ci.EstadoID=1000
  and psa.EstadoID=1000
  and psa.TipoMultaID = 1748 --TUPO MULTA APAA
  and CadenaCite like '%AAPA%'
  and ci.OficinaID in (1001,1002,1003)
  and sa.EstadoID=1000
  AND MONTH(sa.FechaRegistro) =9
  AND YEAR(sa.FechaRegistro) =2024
  and ci.OficinaID = 1002
union all
  select 'PROMOCIONES EMPRESARIALES' 'TipoProceso',
         'SANCION DETECCION' 'Tipo Proceso Sancionatorio',
       case when ci.OficinaID =1001 then 'DRLP'
	        when ci.OficinaID =1002 then 'DRSC'
			when ci.OficinaID =1003 then 'DRCB'
		end Oficina,
	   ci.CadenaCite, 
	   ci.FechaDocumento, 
	   ci.TramiteID,
	   ts.MontoUFV, 
	   ts.Nombre, 
       ts.NormaAfectada, 
	   (select do.Descripcion  from [Transversales.Dominios] do where  do.DominioID= ts.TIpoNormaID )'Tipo Norma',  
	   'AAPA' 'TipoDocumento',
	   ts.TipoSancionID,
	   sa.FechaRegistro,
	   sa.UsuarioID,
	   case
	     when ts.EstadoID=1000 then 'ACTIVO'
		 else 'ANULADO'
	   end EstadoSancion,
	   psa.DetalleProcesoSancionEmpresaID
  from [Sanciones.SancionesEmpresas] sa,
       [Cites.Cites] ci,
       [Sanciones.DetallesProcesosSancionesEmpresas] psa,
	   [Transversales.TiposSanciones] ts
where psa.SancionEmpresaID= sa.SancionEmpresaID
  and ci.TramiteID=sa.TramiteID
  and ci.EstadoID=1000
  and psa.EstadoID=1000
  and sa.EstadoID=1000
  and psa.TipoMultaID = 1748 --TUPO MULTA APAA
  and CadenaCite like '%AAPA%'
  and ci.OficinaID in (1001,1002,1003)
  and ts.TipoSancionID= psa.TipoSancionID
  AND MONTH(sa.FechaRegistro) =9
  AND YEAR(sa.FechaRegistro) =2024
  and ci.OficinaID = 1002
union all
  /******** Infracciones NO REGISTRADAS ***********************/
select 'PROMOCIONES EMPRESARIALES' 'TipoProceso',
        'SANCION FISCALIZACION' 'Tipo Proceso Sancionatorio',
       case when ci.OficinaID =1001 then 'DRLP'
	        when ci.OficinaID =1002 then 'DRSC'
			when ci.OficinaID =1003 then 'DRCB'
		end Oficina,
	   ci.CadenaCite,  
	   ci.FechaDocumento, 
	   ci.TramiteID, 
	   0, 
	   'Infracción no registrada', 
       'Infracción no registrada' 'NormaAfectada', 
	   'Infracción no registrada' 'Tipo Norma', 
	   'AAPA' 'TipoDocumento',
	   null TipoSancionID,
	   sa.FechaRegistro,
	   sa.UsuarioID,
	   'ACTIVO' EstadoSancion,
	   1 DetalleProcesoSancionID
  from [PromocionesEmpresariales.Sanciones] sa,
       [Cites.Cites] ci
where ci.TramiteID=sa.TramiteID
  and ci.EstadoID=1000 
  and sa.EstadoID=1000
  and CadenaCite like '%AAPA%'
  and ci.OficinaID in (1001,1002,1003)
  and sa.SancionID not in (select psa.SancionID from  [PromocionesEmpresariales.DetallesProcesosSanciones] psa where psa.SancionID= sa.SancionID  and psa.EstadoID=1000)
      AND MONTH(sa.FechaRegistro) =9
  AND YEAR(sa.FechaRegistro) =2024
  and ci.OficinaID = 1002
  union all
select 'PROMOCIONES EMPRESARIALES' 'TipoProceso',
        'SANCION DETECCION' 'Tipo Proceso Sancionatorio',
       case when ci.OficinaID =1001 then 'DRLP'
	        when ci.OficinaID =1002 then 'DRSC'
			when ci.OficinaID =1003 then 'DRCB'
		end Oficina,
	   ci.CadenaCite,  
	   ci.FechaDocumento, 
	   ci.TramiteID, 
	   0, 
	   'Infracción no registrada', 
       'Infracción no registrada' NormaAfectada, 
	   'Infracción no registrada' 'Tipo Norma', 
	   'AAPA' 'TipoDocumento',
	   null TipoSancionID,
	   sa.FechaRegistro,
	   sa.UsuarioID,
	   'ACTIVO' EstadoSancion,
	   1 DetalleProcesoSancionID
  from [Sanciones.SancionesEmpresas] sa,
       [Cites.Cites] ci
where ci.TramiteID=sa.TramiteID
  and ci.EstadoID=1000 
  and CadenaCite like '%AAPA%'
  and ci.OficinaID in (1001,1002,1003)
  and sa.EstadoID=1000
  and sa.SancionEmpresaID not in (select psa.SancionEmpresaID from  [Sanciones.DetallesProcesosSancionesEmpresas] psa where psa.SancionEmpresaID= sa.SancionEmpresaID  and psa.EstadoID=1000)
    AND MONTH(sa.FechaRegistro) =9
  AND YEAR(sa.FechaRegistro) =2024
  and ci.OficinaID = 1002
   order by ci.TramiteID, ci.CadenaCite, ts.Nombre, ts.NormaAfectada;
   
  
  
  