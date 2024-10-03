-- MINAJ 
-- Registro 13 registros

  select --* --count (*)
  distinct dd.TramiteID   'Número Trámite',
         tra.FechaRecepcionSecretaria    'Fecha Recepcion Secretaria',
          case
            when dd.Oficina='DIRECCION NACIONAL'                       then 'DNAL'
            when dd.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	        when dd.Oficina='DIRECCION REGIONAL SANTA CRUZ'    then 'DRSC'
    		when dd.Oficina='DIRECCION REGIONAL LA PAZ'             then 'DRLP'
	      end 												                           'Dirección Trámite',  
	      dd.HojaRuta                    'Hoja Ruta',
		  dd.tipoproceso                 'Tipo Proceso Sanción',
		  dd.NombreEmpresa               'Nombre/Empresa',
		  dd.NombrePromocion             'Promoción Empresarial',
	      dd.DocumentoIdentidad          'Documento Identidad',
		  case when dd.citeRAA is null then '' else dd.citeRAA end       'CiteRAA Sanción',
		  dd.FechaRAA                     'FechaRAA Sanción',
		  dd.FechaInformeDeteccion       'Fecha Informe Detección',
		  dd.CiteInformeDeteccion        'Cite Informe Detección',
		  dd.FiscalizadorDeteccion       'Fiscalizador Detección',
		  dd.TramiteSancionadoID         'Número Trámite Sancionado',
		  dd.FechaAAPA                   'Fecha AAPA',
		  dd.CiteAAPA                    'Cite AAPA',
		  dd.CodigoCiteAAPA              'Código Cite AAPA',
		  dd.MontoUFVAAPA                'MontoUFV AAPA',		  
          [EstadoCiteAAPA]               'Estado Cite AAPA',
          [EstadoRS]                     'Estado RS',
          [ConRRRJ]                      'Con Recurso',
		  dd.FechaRS                     'Fecha Cite RS',
		  dd.CodigoCiteRS                'Código Cite RS',
		  dd.CiteRS                      'Cite RS',
		  dd.MontoUFVRS                  'MontoUFV RS',
		  [EstadoCiteRS]                 'Estado Cite RS',
          FechaAFA                       'Fecha Cite AFA',
		  CiteAFA                        'Cite AFA',
		  CodigoCiteAFA                  'Código Cite AFA',
		  FechaRegistroSancion           'Fecha Registro Sanción',
		  [EstadoSancion]               'Estado Sancion',
		  estadoprocesonegocio,
		  isnull(
		  case  
		   when TipoProceso='SANCION DETECCION' and dd.PersonaID in (select pe1.PersonaTemporalID  from [AlmacenCorporativo.Personas] pe1 where pe1.PersonaTemporalID=dd.PersonaID and pe1.PersonaID is null and pe1.NombreEmpresaRazonSocial=dd.NombreEmpresa)
		   then (select pe.DepartamentoRadicatoria 
					from MINAJPRODUCCION.dbo.[AlmacenCorporativo.Personas] pe 
				   where PersonaID is null
					 and pe.PersonaTemporalID= dd.PersonaID)
			else  (select pe.DepartamentoRadicatoria 
					 from MINAJPRODUCCION.dbo.[AlmacenCorporativo.Personas] pe 
					where pe.PersonaID= dd.PersonaID)
		  end,'') Departamento,
		  (select Usuario from MINAJPRODUCCION.dbo.[AlmacenCorporativo.Cites] cites where cites.CadenaCite = dd.CiteAAPA and cites.EstadoCite='ACTIVO') 'Usuario AAPA',
		  (select Usuario from MINAJPRODUCCION.dbo.[AlmacenCorporativo.Cites] cites where cites.CadenaCite = dd.CiteRS and cites.EstadoCite='ACTIVO') 'Usuario RS'
  from MINAJPRODUCCION.dbo.[AlmacenCorporativo.Sanciones] dd,
	      MINAJPRODUCCION.dbo.[AlmacenCorporativo.Tramites] tra
    where dd.EstadoSancion  = 'ACTIVO'
     --and (dd.EstadoRS not in('ERROR') --SE ADICIONA POR CASO DE SOPORTE PALMENIA COSSIO CASO: DUPLICIDAD DE TRAMITE DEL 2012 Y NUEVO GENERADO POR PLANTILLA EN EL 2024 FECHA 09092024
     and dd.DimSancionID not in(29701) --SE ADICIONA POR CASO DE SOPORTE PALMENIA COSSIO CASO: DUPLICIDAD DE TRAMITE DEL 2012 Y NUEVO GENERADO POR PLANTILLA EN EL 2024 FECHA 09092024
  and tra.TramiteID    = dd.TramiteID
 and dd.Oficina='DIRECCION REGIONAL SANTA CRUZ'
  and month( dd.FechaAAPA )= 09
  and year( dd.FechaAAPA )= 2024
  ;