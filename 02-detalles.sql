DetallePromociones:
  LOAD [Número Trámite]            	 as [Número Trámite],
           [Grupo Trámite]              	 as [Grupo Trámite Promoción],
           [Tipo Trámite]                	 as [Tipo Trámite Promoción],
     	     [Estado Trámite]             	 as [Estado Trámite Promoción],
     	     [Dirección Trámite]                as [Dirección Trámite],
     	     [Fecha Recepción Secretaria]  as [Fecha Recepción Secretaria],
     	     [Fecha Inicio Trámite]            as  [Fecha Inicio Trámite],
     	     [Fecha Fin Trámite]               as  [Fecha Fin Trámite],
     	     [Hoja Ruta]                           as  [Hoja Ruta],
     	     [Nombre/Empresa]                as  [Nombre/Empresa],
	     [Documento Identidad]          as   [Documento Identidad],
	     [Promoción Empresarial]       as   [Promoción Empresarial],
	     [Estado Autorización Mensual]  as [Estado Autorización Mensual],
	    [Fecha Inicio Proceso]   as [Fecha Inicio Proceso],	  
	     [Fecha Inicio Promoción]       as   [Fecha Inicio Promoción],
	     [Fecha Fin Promoción]          as   [Fecha Fin Promoción],
	     [Fecha Inicio Ampliación]  as [Fecha Inicio Ampliación],
	     [Fecha Fin Ampliación]      as   [Fecha Fin Ampliación],
	     [Fecha Registro Evaluación]  as   [Fecha Registro Evaluación],
	     [Cite Autorización Rechazo]   as [Cite Autorización Rechazo],
	     [Codigo Cite AutorizacionRechazo]    as [Código Cite Autorización Rechazo],
	     [Fecha Autorizacion Rechazo]           as [Fecha Autorizacion Rechazo],
	     [TramiteAsociadoID]	                     as [TramiteAsociadoID]	,	
	     [Valor Comercial]     as  [Valor Comercial],
	     [Estado Promoción]   as  [Estado Promoción],
	     [Estado Autorización]    as   [Estado Autorización],
	     [Estado Trámite Proceso]   as [Estado Trámite Proceso],
	     [Usuario Autorizacion Rechazo]  as  [Usuario Autorizacion Rechazo],
	     [Tipo Proceso]   as   [Tipo Proceso],
	     [ValorAjuste]   as [Valor Ajuste],
	     [TipoActividadEconomica]  as [Tipo Actividad económica],
	     [DepartamentoFiscal]   as   [Departamento Fiscal],
	     [Tipo Inicio Promoción] as [Tipo Inicio Promoción];
	     SQL


select distinct tra.TramiteID                          'Número Trámite',
       tra.GrupoTramite 								 'Grupo Trámite',
       tra.TipoTramite 									 'Tipo Trámite',  
	   tra.estadotramite                                 'Estado Trámite',
	   pro.tipoproceso                                   'Tipo Proceso',
 	   case
         when pro.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when pro.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when pro.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when pro.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	   end 												'Dirección Trámite',         
	   tra.FechaRecepcionSecretaria                     'Fecha Recepción Secretaria',
	   tra.FechaIncioTramite                            'Fecha Inicio Trámite',
	   tra.FechaFinTramite                              'Fecha Fin Trámite',
	   tra.hojaruta                                     'Hoja Ruta',
       pro.UsuarioAutorizacionRechazo                   'Usuario Autorizacion Rechazo',
	   pro.CiteAutorizacionRechazo                      'Cite Autorización Rechazo',       
	   pro.CodigoCiteAutorizacionRechazo                'Codigo Cite AutorizacionRechazo',
	   pro.FechaAutorizacionRechazo                     'Fecha Autorizacion Rechazo',
	   pro.nombreempresa                                'Nombre/Empresa',
	   pro.DocumentoIdentidad                           'Documento Identidad',
	   pro.nombrepromocion                              'Promoción Empresarial',
	   pro.EstadoAutorizacion							'Estado Autorización',
	    pro.EstadoAutorizacionMensual					'Estado Autorización Mensual',
	   pro.fechainicioproceso                            'Fecha Inicio Proceso',
	  pro.fechainiciopromocion                         'Fecha Inicio Promoción',
	   pro.fechafinpromocion                            'Fecha Fin Promoción',
	   pro.FechaInicioAmpliacion                        'Fecha Inicio Ampliación',
	   pro.FechaFinAmpliacion                           'Fecha Fin Ampliación',
	   pro.FechaRegistroEvaluacion                      'Fecha Registro Evaluación',
	    pro.valorcomercial                               'Valor Comercial',
	   pro.estadopromocion                              'Estado Promoción',
	  tra.EstadoTramiteProceso						    'Estado Trámite Proceso',
	   tra.TramiteAsociadoID                            'TramiteAsociadoID'	,
	   pro.valorajuste                                  'ValorAjuste',
	   pro.tipoiniciopromocion                           'Tipo Inicio Promoción',
	   case
	     when personaid is not null 
		 then (select distinct TipoActividadEconomica	from [AlmacenCorporativo.Personas] pe where pe.PersonaID= pro.PersonaID and pe.EstadoPersona='ACTIVO')	    
		 when PersonaID is null 
		 then (select TipoActividadEconomica	from [AlmacenCorporativo.Personas] pe where pe.NombreEmpresaRazonSocial= pro.NombreEmpresa  and pe.Oficina=pro.Oficina and pe.EstadoPersona='ACTIVO'  AND PersonaID IS NULL AND PersonaTemporalID IS NULL) 
	    end TipoActividadEconomica,
	  case
	     when personaid is not null 
		 then (select distinct DepartamentoRadicatoria	from [AlmacenCorporativo.Personas] pe where pe.PersonaID= pro.PersonaID and  pe.EstadoPersona='ACTIVO') 	    
		 when PersonaID is null 
		 then  (select DepartamentoRadicatoria	from [AlmacenCorporativo.Personas] pe where pe.NombreEmpresaRazonSocial= pro.NombreEmpresa and pe.Oficina=pro.Oficina and pe.EstadoPersona='ACTIVO' AND PersonaID IS NULL AND PersonaTemporalID IS NULL) 
	    end DepartamentoFiscal
  from [MINAJPRODUCCION].dbo.[AlmacenCorporativo.Tramites] 	tra,
	    [MINAJPRODUCCION].dbo.[AlmacenCorporativo.PromocionesEmpresariales] pro
where pro.EstadoPromocion  = 'ACTIVO'
  and pro.TramiteID            = tra.TramiteID;

DetallePromociones2016:
LOAD
[TramiteID]   as   [Número Trámite],
[CadenaCiteResolucion]   as   [CiteRAA_2016],
[MesContabilizacion]   as   [MesContabilizacion],
[GestionContabilizacion]   as   [GestionContabilizacion],
[ValorComercialPresentado]   as   [ValorComercialPresentado],
[VALORINDETERMINADO]   as   [VALORINDETERMINADO],
[NombreOficina]   as  [OficinaPE],
[FechaRecepcion]   as   [FechaRecepcion_2016],
[CantidadPremioEntregado]   as   [CantidadPremioEntregado],
[DescripcionPremio]   as   [DescripcionPremioEntregado];

SQL
	
select	
	pr.TramiteID, 
	pr.PromocionEmpresarialID, 
	pr.CadenaCiteResolucion, 
	case
		when pr.OficinaID= 1000 then 'DNAL'
		when pr.OficinaID=1003 then 'DRCB'
		when pr.OficinaID=1002 then 'DRSC'
		when pr.OficinaID=1001 then 'DRLP'
	end 	NombreOficina,
	ddp.MesContabilizacion,
	ddp.GestionContabilizacion,
	sum(convert(decimal(15,2), ddp.ValorComercial)) ValorComercialPresentado,
	case
		when pr.ValorIndeterminado=0 then 'DETERMINADO'
		when PR.ValorIndeterminado = 1 THEN 'INDETERMINADO' ELSE 'DETERMINADO'
	end  VALORINDETERMINADO, 
	convert(date,re.FechaRecepcion) FechaRecepcion,
	ddp.CantidadPremioEntregado, 
	ddp.DescripcionPremio
from
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] pr,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.RemisionDocsEmpresasPromEmp] rem,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.DetallesDocumentosPosteriores] ddp,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.DetallesRemisionesEmpresas] dre,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Correspondencia.Recepciones] re,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.TramitesFlujosRecepciones] tfr,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.Tramites] tr
where 
	dre.RealizarValidacion=1
	and ddp.EstadoID=1000
	and rem.EstadoID = 1000
	and ddp.EstadoID = 1000
	and dre.EstadoID = 1000
	and rem.RemisionDocEmpresaPromEmpID = dre.RemisionDocEmpresaPromEmpID
	and dre.DetalleRemisionEmpresaID = ddp.DetalleRemisionEmpresaID
	and pr.PromocionEmpresarialID = rem.PromocionEmpresarialID
	and re.RecepcionID = tfr.RecepcionID
	and tfr.TramiteID = rem.TramiteID
	and tfr.EstadoID = 1000
	and tfr.TramiteID = tr.TramiteID 
	and tr.EstadoID = 1000
group by 
	pr.TramiteID,pr.oficinaid, pr.PromocionEmpresarialID, pr.CadenaCiteResolucion,
	ddp.MesContabilizacion, ddp.GestionContabilizacion, pr.ValorIndeterminado, 
	re.FechaRecepcion, ddp.CantidadPremioEntregado, ddp.DescripcionPremio;
		
DetalleProcesoSancionador:
LOAD
		[Número Trámite]            	 as [Número Trámite],
		[Fecha Recepcion Secretaria]  as [Fecha Recepcion Secretaria Sanción],
		[Dirección Trámite]               as [Dirección Sanción],
		[Tipo Proceso Sanción]         as [Tipo Proceso Sanción],
		[Hoja Ruta]                      as  [Hoja Ruta Sanción],
		[Nombre/Empresa]               as [Nombre/Empresa Sanción],
		[Documento Identidad]      as [Documento Identidad Sanción],
		[Promoción Empresarial]       as [Promoción Empresarial Sanción],
		[CiteRAA Sanción]          as [Cite Autorización Sanción],
		[FechaRAA Sanción]    as  [Fecha Autorización Sanción],
		[Fecha Informe Detección]       as   [Fecha Informe Detección],
		[Cite Informe Detección]       as    [Cite Informe Detección],
		[Fiscalizador Detección]       as     [Fiscalizador Detección],
		[Fecha AAPA]       as   [Fecha AAPA],
		[Cite AAPA]       as   [Cite AAPA],
		[Código Cite AAPA]       as   [Código Cite AAPA],
		[MontoUFV AAPA]       as    [MontoUFV AAPA],
		[Con Recurso]    as   [Con Recurso],
		[Fecha Cite RS]       as  [Fecha Cite RS],
		[Código Cite RS]       as  [Código Cite RS],
		[Cite RS]       as  [Cite RS] ,
		[MontoUFV RS]       as     [MontoUFV RS],
		[Fecha Cite AFA]       as  [Fecha Cite AFA],
		[Cite AFA]       as  [Cite AFA],
		[Código Cite AFA]       as  [Código Cite AFA],
		[Fecha Registro Sanción]        as [Fecha Registro Sanción],
		[Estado Sancion]    as   [Estado Sancion],
		[Estado RS]   as  [Estado RS],
		[Estado Cite RS]   as  [Estado Cite RS],
		[Estado Cite AAPA]   as  [Estado Cite AAPA],
		[Número Trámite Sancionado]   as  [Número Trámite Sancionado],
		[estadoprocesonegocio]   as   [Estado Proceso Negocio Sanción],
		[Departamento]  as [Departamento Sanción],
		[Usuario AAPA] as [Usuario AAPA],
		[Usuario RS] as [Usuario RS];
SQL
         select distinct dd.TramiteID   'Número Trámite',
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
    --and EstadoRS not in('ERROR') --SE ADICIONA POR CASO DE SOPORTE PALMENIA COSSIO CASO: DUPLICIDAD DE TRAMITE DEL 2012 Y NUEVO GENERADO POR PLANTILLA EN EL 2024 FECHA 09092024
    and DimSancionID not in(29701) --SE ADICIONA POR CASO DE SOPORTE PALMENIA COSSIO CASO: DUPLICIDAD DE TRAMITE DEL 2012 Y NUEVO GENERADO POR PLANTILLA EN EL 2024 FECHA 09092024
  and tra.TramiteID    = dd.TramiteID;
 

DetalleSancionesRARRyRJ:
LOAD
		[Número Trámite]            	 as [Número Trámite],
		[Fecha Recepcion Secretaria]  as [Fecha Recepcion Secretaria RARR],
		[Dirección Trámite]               as [Dirección RARR],
		[Tipo Proceso Sanción]         as [Tipo Proceso RARR],
		[Nombre/Empresa]               as [Nombre/Empresa RARR],
		[Documento Identidad]      as [Documento Identidad RARR],
		[Promoción Empresarial]       as [Promoción Empresarial RARR],
		[CiteRAA RARR]          as [CiteRAA RARR],
		[FechaPresentacionRR]     as  [Fecha PresentacionRARR]  ,
		[TipoDocumentoRR]     as   [Tipo Documento RARR],
		[NumeroDocumentoRR]     as   [NumeroDocumento RARR],
		[CiteRemisionDNJ]     as  [Cite RemisionRARR DNJ] ,
		[FechaRemisionDNJ]     as  [Fecha RemisionRARR DNJ] ,
		[CiteProveidoObservacion]     as   [Cite Proveido Observacion],
		[FechaProveidoObservacion]     as    [Fecha Proveido Observacion],
		[CiteInformeLegal]     as  [Cite Informe Legal] ,
		[FechaInformeLegal]     as   [Fecha Informe Legal],
		[CiteRARR]     as   [CiteRARR],
		[CodigoCiteRARR]     as   [CodigoCiteRARR],
		[FechaRARR]     as   [FechaRARR],
		[FalloRARR]     as   [FalloRARR],
		[FechaPresentacionRJ]     as   [FechaPresentacionRJ], 
		[CiteProveidoRJ]     as   [Cite Proveido RJ],
		[CodigoProveidoRJ]     as  [Codigo Proveido RJ] ,
		[FechaProveidoRJ]     as  [Fecha Proveido RJ] ,
		[CiteRemisionMEFP]     as   [Cite Remision MEFP],
		[FechaRemisionMEFP]     as   [Fecha Remision MEFP],
		[NumeroRMJ]     as  [Numero RMJ] ,
		[FechaRMJ]     as   [Fecha RMJ],
		[FalloRMJ]     as   [Fallo RMJ],
		[MontoRevocadoRARR]     as   [Monto Revocado RARR],
		[MontoRevocadoRJ]     as   [Monto Revocado RJ], 
		[CiteRemisionDR]     as   [Cite Remision DR];
SQL
     select distinct dd.TramiteID   'Número Trámite',
         tra.FechaRecepcionSecretaria    'Fecha Recepcion Secretaria',
          case
            when dd.Oficina='DIRECCION NACIONAL'                       then 'DNAL'
            when dd.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	        when dd.Oficina='DIRECCION REGIONAL SANTA CRUZ'    then 'DRSC'
    		when dd.Oficina='DIRECCION REGIONAL LA PAZ'             then 'DRLP'
	      end 												                           'Dirección Trámite',  
	      dd.tipoproceso                 'Tipo Proceso Sanción',
		  dd.NombreEmpresa               'Nombre/Empresa',
		  dd.NombrePromocion             'Promoción Empresarial',
	      dd.DocumentoIdentidad          'Documento Identidad',
		  dd.CiteAutorizacionRechazo     'CiteRAA RARR',
		  dd.CiteAAPA                    'Cite AAPA',
		  dd.MontoUFVAAPA                'MontoUFV AAPA',		  
           dd.CiteRS                      'Cite RS',
		  dd.MontoUFVRS                  'MontoUFV RS',
		  dd.FechaPresentacionRR,
		  dd.TipoDocumentoRR,
		  dd.NumeroDocumentoRR,
		  dd.CiteRemisionDNJ,
		  dd.FechaRemisionDNJ,
		  dd.CiteProveidoObservacion,
		  dd.FechaProveidoObservacion,
		  dd.CiteInformeLegal,
		  dd.FechaInformeLegal,
		  dd.CiteRARR,
		  dd.CodigoCiteRARR,
		  dd.FechaRARR,
		  dd.FalloRARR,
		  dd.FechaPresentacionRJ, 
		  dd.CiteProveidoRJ,
		  dd.CodigoProveidoRJ,
		  dd.FechaProveidoRJ,
		  dd.CiteRemisionMEFP,
		  dd.FechaRemisionMEFP,
		  dd.NumeroRMJ,
		  dd.FechaRMJ,
		  dd.FalloRMJ,
		  dd.MontoRevocadoRARR,
		  dd.MontoRevocadoRJ, 
		  dd.CiteRemisionDR
     from MINAJPRODUCCION.dbo.[ODS.SancionesDNAL] dd,
	      MINAJPRODUCCION.dbo.[AlmacenCorporativo.Tramites] tra
    where tra.TramiteID    = dd.TramiteID;
 

DetallePagoSanciones:
LOAD [Dirección Pago]   as [Dirección Pago],
   [Número Trámite]     as    [Número Trámite],
   [Cite]                          as [Cite Pagado],
   [Tipo Documento Sancion]   as [Tipo Documento Sancion],
   [Nro. Boleta Pago]       as [Nro. Boleta Pago],
   [Fecha Pago]               as [Fecha Pago],
   [Monto Pagado UFV]    as [Monto Pagado UFV],
   [Monto Pagado Bs.]     as [Monto Pagado Bs.],
   [Persona Realizó Pago] as [Persona Realizó Pago],
   [Tipo Pago] as [Tipo Pago],
   [Observaciones Pago] as  [Observaciones Pago], 
   [Cotizacion UFV] as [Cotizacion UFV],
   [Cite Certificacion DNAF] as [Cite Certificacion DNAF],
    [Fecha Certificacion DNAF]   as [Fecha Certificacion DNAF],
   [Estado Certificacion] as [Estado Certificacion],
   [EstadoVerificado Pago] as [EstadoVerificado Pago],
    [MontoUFVRS-Ref]    as   [MontoUFVRS-Ref],
    [CiteRS-Ref]   as [CiteRS-Ref],
    [FechaRS-Ref]  as   [FechaRS-Ref],
    [Fecha Registro Pago]  as  [Fecha Registro Pago],
    [Fecha Presentacion Boleta]  as  [Fecha Presentacion Boleta],
    [PagoSancionID]  as [PagoSancionID],
    [Empresa]  as [Empresa Pago];
 SQL
 SELECT case
            when pa.Oficina='DIRECCION NACIONAL'                       then 'DNAL'
            when pa.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	        when pa.Oficina='DIRECCION REGIONAL SANTA CRUZ'    then 'DRSC'
    		when pa.Oficina='DIRECCION REGIONAL LA PAZ'             then 'DRLP'
	      end 												                           'Dirección Pago',  
	   pa.TramiteID 'Número Trámite', 
	   pa.TipoDocumento 'Tipo Documento Sancion',
       pa.Cite ,
	   pa.NumeroBoletaPago 'Nro. Boleta Pago',
	   convert(date,pa.FechaPago)  'Fecha Pago',
	   pa.MontoPagadoUFV 'Monto Pagado UFV', 
	   convert(decimal(18,2),pa.MontoPagadoBS) 'Monto Pagado Bs.',
	   pa.PersonaRealizoPago 'Persona Realizó Pago',
	   pa.TipoPago 'Tipo Pago',
	   pa.Observaciones 'Observaciones Pago', 
	   pa.ValorCotizacionUFV 'Cotizacion UFV',
	   pa.CiteVerificacionPago 'Cite Certificacion DNAF',
	   pa.FechaNotaDNF 'Fecha Certificacion DNAF',
	   pa.EstadoCertificadoPagoDNAF 'Estado Certificacion',
	   EstadoVerificacionPago 'EstadoVerificado Pago',
	   pa.MontoUFVRS 'MontoUFVRS-Ref',
	   pa.CiteRS 'CiteRS-Ref',
	   pa.FechaRS 'FechaRS-Ref',
	   pa.FechaRegistroPago 'Fecha Registro Pago',
	   pa.FechaPresentacionBoleta 'Fecha Presentacion Boleta',
	   pa.PagoSancionID,
	   pa.Empresa
   FROM [MINAJPRODUCCION].dbo.[AlmacenCorporativo.PagosSanciones] pa;

DetallePagoSancionesDevoluciones:
LOAD [Dirección Pago]   as [Dirección Pago Devolucion],
   [Número Trámite]     as    [Número Trámite Devolucion],
   [Monto Pagado UFV]    as [Monto Pagado UFV Devolucion],
   [Monto Pagado Bs.]     as [Monto Pagado Bs. Devolucion],
   [Cotizacion UFV] as [Cotizacion UFV Devolucion];
 SQL
 SELECT case
            when pa.Oficina='DIRECCION NACIONAL'                       then 'DNAL'
            when pa.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	        when pa.Oficina='DIRECCION REGIONAL SANTA CRUZ'    then 'DRSC'
    		when pa.Oficina='DIRECCION REGIONAL LA PAZ'             then 'DRLP'
	      end 'Dirección Pago',  
	   pa.TramiteDevolucionID 'Número Trámite', 
	   pa.MontoDevolucionUFV 'Monto Pagado UFV', 
	   convert(decimal(18,2),pa.MontoDevolucionBS) 'Monto Pagado Bs.',
	   pa.ValorCotizacionUFV 'Cotizacion UFV'
   FROM [MINAJPRODUCCION].dbo.[AlmacenCorporativo.PagosSancionesDevoluciones] pa;
   
ProcesoFiscalizacion:
LOAD
 [TramiteID]  as  [Número Trámite], 
         [CiteRAA]  as  [Cite RAA Fisca], 
		 [FechaCiteRAA]  as  [Fecha RAA],
		 [Oficina]     as    [Dirección Fiscalizacion],
		 [DocumentoIdentidad]   as  [Documento Identidad Fisca],
		 [NombreEmpresa]   as   [Nombre Empresa Fisca],
		 [NombrePromocion]  as  [Nombre Promocion Fisca],
		[OrdenFiscalizacion]  as  [Orden Fiscalizacion], 
	   [FechaOrdenFiscalizacion]  as  [Fecha Orden Fiscalizacion],
	   [CiteNotaOrdenFisca]  as [CiteNotaOrdenFisca],
	   [UsuarioAsignador]  as  [Usuario Asignador], 
	   [FiscalizadorAsignado]   as [Fiscalizador Asignado] , 
	   [CiteMemoAsignacion]  as  [Cite Memo Asignacion], 
	   [FechaMemoAsignacion]  as  [Fecha Memo Asignacion],
	   [FechaNotificacionOrdenFiscalizacion]   as [Fecha Notificacion Orden Fiscalizacion],
       [NotificadorOrdenFiscalizacion]   as  [Notificador Orden Fiscalizacion],
       [TipoNotificacionOrdenFiscalizacion]  as [Tipo Notificacion Orden Fiscalizacion],
       [DireccionNotificacion]   as  [DireccionNotificacion],
	   [FechaInformeFiscalizacion]  as  [Fecha Informe Fiscalizacion],  
	   [CiteInformeFiscalizacion]  as [Cite Informe Fiscalizacion] , 
	   [DepartamentoFiscalizacion]  as  [Departamento Fiscalizacion], 
	   [CiteAutoConclusion]  as  [Auto Conclusion], 
	   [CiteRemisionJuridica]  as  [Cite Remision Juridica], 
	   [ArchivoJuridica]  as  [Archivo/Juridica],
	   [EstadoFiscalizacion]  as [Estado Fiscalizacion],
	   [EstadoProcesoFiscalizacion]  as [Estado Proceso Fiscalizacion],
	   [TipoProceso]    as   [Tipo Proceso Fiscalizacion],
	   [FechaInicioPromocion]    as  [Fecha Inicio Promocion Fiscalizacion] ,
	   [FechaFinPromocion]    as   [Fecha Fin Promocion Fiscalizacion],
	   [FechaInicioAmpliacion]    as   [Fecha Inicio Ampliacion Fiscalizacion],
	   [FechaFinAmpliacion]    as   [Fecha Fin Ampliacion Fiscalizacion],
	   [ValorComercial]    as   [Valor Comercial Fiscalizacion] ,
	   [FechaRecepcionNotaGeneracion]    as   [Fecha Recepcion NotaGeneracion Fiscalizacion];
SQL
 select pf.TramiteID, 
       CiteRAA, 
	    case
		 when pf.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when pf.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when pf.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when pf.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Oficina',
       pf.[DocumentoIdentidad],
       pf.[NombreEmpresa],
       pf.[NombrePromocion],
       [CiteRAA],
	   FechaCiteRAA,
	   OrdenFiscalizacion,
	   [FechaOrdenFiscalizacion],
	   [CiteNotaOrdenFisca],
	   UsuarioAsignador, 
	   FiscalizadorAsignado , 
	   CiteMemoAsignacion, 
	   [FechaMemoAsignacion],
	   [FechaNotificacionOrdenFiscalizacion],
       [NotificadorOrdenFiscalizacion],
       [TipoNotificacionOrdenFiscalizacion],
       [DireccionNotificacion],
	   CiteInformeFiscalizacion, 
	   [FechaInformeFiscalizacion],
	   DepartamentoFiscalizacion, 
	   ArchivoJuridica,
       CiteAutoConclusion,
       CiteRemisionJuridica,
       EstadoFiscalizacion,
       EstadoProcesoFiscalizacion,
	   TipoProceso,
	   FechaInicioPromocion,
	   FechaFinPromocion,
	   FechaInicioAmpliacion,
	   FechaFinAmpliacion,
	   ValorComercial,
	   FechaRecepcionNotaGeneracion,
	   (select sum(sa.MontoUFVAAPA) from (select CiteAAPA, TramiteSancionadoID , MontoUFVAAPA
	                                   from [AlmacenCorporativo.Sanciones] sa1 
									  where sa1.EstadoCiteAAPA='ACTIVO' and sa1.EstadoSancion='ACTIVO' 
									  group by CiteAAPA, TramiteSancionadoID , MontoUFVAAPA) sa
							   where pf.TramiteID=sa.TramiteSancionadoID) MontoUFVAAPA,
	    (select sum(sa.MontoUFVRS) from (select CiteRS, TramiteSancionadoID , MontoUFVRS
	                                   from [AlmacenCorporativo.Sanciones] sa1 
									  where sa1.EstadoCiteRS='ACTIVO' and sa1.EstadoSancion='ACTIVO' 
									  group by CiteRS, TramiteSancionadoID , MontoUFVRS) sa
							   where pf.TramiteID=sa.TramiteSancionadoID) MontoUFVRS
  from [ODS.ProcesosFiscalizaciones] pf
where pf.OrdenFiscalizacion is not null;

ProcesoFiscalizacionSancionador:
LOAD
[TramiteID]  as  [Número Trámite], 
         [CiteRAA]  as  [Cite RAA FiscaSan], 
		 [FechaCiteRAA]  as  [Fecha RAA FiscaSan],
		 [Oficina]     as    [Dirección FiscaSan],
		 [DocumentoIdentidad]   as  [Documento Identidad FiscaSan],
		 [NombreEmpresa]   as   [Nombre Empresa FiscaSan],
		 [NombrePromocion]  as  [Nombre Promocion FiscaSan],
		[OrdenFiscalizacion]  as  [Orden FiscaSan], 
	   [FechaOrdenFiscalizacion]  as  [Fecha Orden FiscaSan],
	   [CiteNotaOrdenFisca]  as [CiteNotaOrden FiscaSan],
	   [UsuarioAsignador]  as  [Usuario Asignador FiscaSan], 
	   [FiscalizadorAsignado]   as [Fiscalizador Asignado FiscaSan] , 
	   [CiteMemoAsignacion]  as  [Cite Memo Asignacion FiscaSan], 
	   [FechaMemoAsignacion]  as  [Fecha Memo Asignacion FiscaSan] ,
	   [FechaNotificacionOrdenFiscalizacion]   as [Fecha Notificacion Orden FiscaSan],
       [NotificadorOrdenFiscalizacion]   as  [Notificador Orden FiscaSan],
       [TipoNotificacionOrdenFiscalizacion]  as [Tipo Notificacion Orden FiscaSan],
       [DireccionNotificacion]   as  [DireccionNotificacion FiscaSan],
	   [FechaInformeFiscalizacion]  as  [Fecha Informe FiscaSan],  
	   [CiteInformeFiscalizacion]  as [Cite Informe FiscaSan] , 
	   [DepartamentoFiscalizacion]  as  [Departamento FiscaSan], 
	   [CiteAutoConclusion]  as  [Auto Conclusion FiscaSan], 
	   [CiteRemisionJuridica]  as  [Cite Remision Juridica FiscaSan], 
	   [ArchivoJuridica]  as  [Archivo/Juridica FiscaSan],
	   [EstadoFiscalizacion]  as [Estado FiscaSan],
	   [TipoProceso]    as   [Tipo Proceso FiscaSan],
	   [FechaInicioPromocion]    as  [Fecha Inicio Promocion FiscaSan] ,
	   [FechaFinPromocion]    as   [Fecha Fin Promocion FiscaSan],
	   [FechaInicioAmpliacion]    as   [Fecha Inicio Ampliacion FiscaSan],
	   [FechaFinAmpliacion]    as   [Fecha Fin Ampliacion FiscaSan],
	   [ValorComercial]    as   [Valor Comercial FiscaSan] ,
	   [FechaRecepcionNotaGeneracion]    as   [Fecha Recepcion NotaGeneracion FiscaSan],
	   [MontoUFVAAPA]      as   [MontoUFV FiscaSan],
	   [estadoprocesonegocio]   as  [Estado Proceso Negocio FiscaSan],
	   [CiteAAPA]   as   [Cite FiscaSan],
	   [TipoDocumentoSancionFisca]   as  [TipoDocumento FiscaSan],
	   [FechaCite]    as    [FechaCite FiscaSan];
SQL


select pf.TramiteID, 
       pf.CiteRAA, 
	    case
		 when pf.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when pf.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when pf.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when pf.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Oficina',
       pf.[DocumentoIdentidad],
       pf.[NombreEmpresa],
       pf.[NombrePromocion],
	   FechaCiteRAA,
	   OrdenFiscalizacion,
	   [FechaOrdenFiscalizacion],
	   [CiteNotaOrdenFisca],
	   UsuarioAsignador, 
	   FiscalizadorAsignado , 
	   CiteMemoAsignacion, 
	   [FechaMemoAsignacion],
	   [FechaNotificacionOrdenFiscalizacion],
       [NotificadorOrdenFiscalizacion],
       [TipoNotificacionOrdenFiscalizacion],
       [DireccionNotificacion],
	   CiteInformeFiscalizacion, 
	   [FechaInformeFiscalizacion],
	   DepartamentoFiscalizacion, 
	   case when ArchivoJuridica is null then 'NO DEFINIDO' else ArchivoJuridica end  ArchivoJuridica,
       CiteAutoConclusion,
       CiteRemisionJuridica,
       EstadoFiscalizacion,
	   pf.TipoProceso,
	   FechaInicioPromocion,
	   FechaFinPromocion,
	   FechaInicioAmpliacion,
	   FechaFinAmpliacion,
	   ValorComercial,
	   FechaRecepcionNotaGeneracion,
	   sa.MontoUFVAAPA,
	   sa.estadoprocesonegocio,
	   sa.CiteAAPA,
	   sa.FechaAAPA FechaCite,
	   'AAPAS' TipoDocumentoSancionFisca
  from [ODS.ProcesosFiscalizaciones] pf,
       (select estadoprocesonegocio, TramiteID, CiteRAA, CiteAAPA, convert(int, MontoUFVAAPA) MontoUFVAAPA,FechaAAPA, EstadoSancion from [AlmacenCorporativo.Sanciones] where CiteAAPA is not null group by estadoprocesonegocio,TramiteID,CiteRAA, CiteAAPA, convert(int, MontoUFVAAPA), EstadoSancion,FechaAAPA) sa 
where  sa.CiteRAA= pf.CiteRAA
  and sa.EstadoSancion='ACTIVO'
 -- and (convert(int,sa.FechaAAPA-pf.FechaInformeFiscalizacion ) between 0 and 11)
  and sa.CiteAAPA is not null
  and pf.EstadoFiscalizacion <>'ANULADO'
  union all   
 select  pf.TramiteID, 
       pf.CiteRAA, 
	    case
		 when pf.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when pf.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when pf.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when pf.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Oficina',
       pf.[DocumentoIdentidad],
       pf.[NombreEmpresa],
       pf.[NombrePromocion],
	   FechaCiteRAA,
	   OrdenFiscalizacion,
	   [FechaOrdenFiscalizacion],
	   [CiteNotaOrdenFisca],
	   UsuarioAsignador, 
	   FiscalizadorAsignado , 
	   CiteMemoAsignacion, 
	   [FechaMemoAsignacion],
	   [FechaNotificacionOrdenFiscalizacion],
       [NotificadorOrdenFiscalizacion],
       [TipoNotificacionOrdenFiscalizacion],
       [DireccionNotificacion],
	   CiteInformeFiscalizacion, 
	   [FechaInformeFiscalizacion],
	   DepartamentoFiscalizacion, 
	   case when ArchivoJuridica is null then 'NO DEFINIDO' else ArchivoJuridica end  ArchivoJuridica,
       CiteAutoConclusion,
       CiteRemisionJuridica,
       EstadoFiscalizacion,
	   pf.TipoProceso,
	   FechaInicioPromocion,
	   FechaFinPromocion,
	   FechaInicioAmpliacion,
	   FechaFinAmpliacion,
	   ValorComercial,
	   FechaRecepcionNotaGeneracion,
	   sa.MontoUFVRS,
	   sa.estadoprocesonegocio,
	   sa.CiteRS,
	   sa.FechaRS,
	   'RS'
  from [ODS.ProcesosFiscalizaciones] pf,
       (select estadoprocesonegocio,TramiteID, CiteRAA, CiteRS, convert(int, MontoUFVRS) MontoUFVRS,FechaRS, EstadoSancion from [AlmacenCorporativo.Sanciones] where CiteRS is not null and CiteRS <>'NOT TIENE RS'  group by estadoprocesonegocio,TramiteID,CiteRAA, CiteRS, convert(int, MontoUFVRS), EstadoSancion,FechaRS) sa 
where  sa.CiteRAA= pf.CiteRAA
  and sa.EstadoSancion='ACTIVO'
 -- and (convert(int,sa.FechaAAPA-pf.FechaInformeFiscalizacion ) between 0 and 11)
  and sa.CiteRS is not null
  and pf.EstadoFiscalizacion <>'ANULADO'
    UNION ALL
  select  pf.TramiteID, 
       pf.CiteRAA, 
	    case
		 when pf.Oficina ='DIRECCION NACIONAL'  then 'DNAL'
		 when pf.Oficina='DIRECCION REGIONAL COCHABAMBA' then 'DRCB'
		 when pf.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
		 when pf.Oficina='DIRECCION REGIONAL LA PAZ'          then 'DRLP'
  	    end 												 'Oficina',
       pf.[DocumentoIdentidad],
       pf.[NombreEmpresa],
       pf.[NombrePromocion],
	   FechaCiteRAA,
	   OrdenFiscalizacion,
	   [FechaOrdenFiscalizacion],
	   [CiteNotaOrdenFisca],
	   UsuarioAsignador, 
	   FiscalizadorAsignado , 
	   CiteMemoAsignacion, 
	   [FechaMemoAsignacion],
	   [FechaNotificacionOrdenFiscalizacion],
       [NotificadorOrdenFiscalizacion],
       [TipoNotificacionOrdenFiscalizacion],
       [DireccionNotificacion],
	   CiteInformeFiscalizacion, 
	   [FechaInformeFiscalizacion],
	   DepartamentoFiscalizacion, 
	   case when ArchivoJuridica is null then 'NO DEFINIDO' else ArchivoJuridica end  ArchivoJuridica,
       CiteAutoConclusion,
       CiteRemisionJuridica,
       EstadoFiscalizacion,
	   pf.TipoProceso,
	   FechaInicioPromocion,
	   FechaFinPromocion,
	   FechaInicioAmpliacion,
	   FechaFinAmpliacion,
	   ValorComercial,
	   FechaRecepcionNotaGeneracion,
	   0 MontoUFVRS,
	   'FISCALIZACION (Pendiente Generación AAPA)' estadoprocesonegocio,
	   NULL CiteRS,
	   NULL FechaRS,
	   ''
  from [ODS.ProcesosFiscalizaciones] pf       
where  pf.EstadoProcesoFiscalizacion <>'ANULADO'
  and  pf.citeraa not in  (select SA.CiteRAA from [AlmacenCorporativo.Sanciones] SA WHERE SA.CiteRAA=PF.CiteRAA  group by SA.CiteRAA)
  and  pf.ArchivoJuridica='INICIO PROCESO SANCIONADOR'
  AND  PF.FechaInformeFiscalizacion IS NOT NULL  
  order by pf.FechaOrdenFiscalizacion;

Infracciones:
LOAD 
   [TipoSancionID]  as [TipoSancionID],
   [DetalleProcesoSancionID_DimInfraccionID]  as [DetalleProcesoSancionID_DimInfraccionID],
	[TramiteID] as  [Número Trámite],
    [Oficina]  as  [Oficina Infracción],
    [TipoProceso]  as [Proceso Infracción],
    [TipoSubProceso]  as  [Tipo Proceso Infracción],
    [TipoNorma]  as [Tipo Norma],
    [TipoDocumento]  as [Tipo Documento Infracción],
    [Cite]  as   [Cite Infracción], 
    [FechaCite]  as [Fecha Cite Infracción],
    [Infraccion]  as      [Infraccion], 
    [NormaAfectada]  as   [Norma Afectada],
    [MontoUFV]  as [MontoUFV Infracción],
    [FechaRegistro]  as [Fecha Registro Infracción],
    [Estado]  as [Estado Infracción];
SQL
select [TipoSancionID] 
     ,[DetalleProcesoSancionID_DimInfraccionID]
     ,[TramiteID]
      ,[Oficina]
      ,[TipoProceso]
      ,[TipoSubProceso]
      ,[TipoNorma]
      ,[TipoDocumento]
      ,[Cite]
      ,[FechaCite]
      ,[Infraccion]
      ,[NormaAfectada]
      ,[MontoUFV]
      ,[FechaRegistro]
      ,[UsuarioID]
      ,[Estado]
  from [AlmacenCorporativo.InfraccionesAAPARS] nf
  where nf.Estado='ACTIVO';

TramitesAsociados:
LOAD
          [TramiteAsociadoID]     as    [Número Trámite],
          [Oficina]     as    [Dirección Asociado],
          [HojaRuta]   as  [Hoja Ruta Asociado],
          [FechaRecepcionSecretaria]   as  [Fecha Recepción Tramite Asociado],
          [FechaEfectivizacionTramite]  as  [Fecha Efectivización],
	    [TramiteID]      as [Número Trámite Asociado],
	    [GrupoTramite]      as [Grupo Tramite Asociado],
	    [TipoTramite]      as [Tipo Tramite Asociado],
	    [EstadoTramite]      as [Estado Tramite Asociado],
	    [TipoDocumentoProceso]      as [Tipo Documento Proceso Asociado],
	    [SiglaTipoDocumentoProceso]      as [Sigla Documento Asociado],
	    [FechaDocumento]      as [Fecha Documento Asociado],
	    [CodigoCite]      as [Codigo Cite Asociado],
	    [CadenaCite]          as  [Cadena Cite Asociado],
	    [EstadoEfectivizacion]  as  [Estado Efectivización],
		[NombreEmpresa]         as [Nombre Empresa Asociado],
		[DocumentoIdentidad]    as  [Documento Identidad Asociado],
	    [NombrePromocion]   as [Nombre Promocion Asociado],
	    [FechaInicioPromocion]   as   [Fecha Inicio Promocion Asociado],
	    [FechaFinPromocion]  as  [Fecha Fin Promocion Asociado],
	    [EstadoTramiteProceso]   as  [Estado Tramite Proceso Asociado],
	    [SubTipoTramite]   as  [SubTipo Tramite Asociado];
SQL

 select tra.TramiteID,
	     pro.PromocionEmpresarialID,
           tra.TramiteAsociadoID ,
	     pro.PersonaID,
	     case
         when tra.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when tra.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when tra.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when tra.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	     end 												'Oficina',   
	     tra.HojaRuta,
	     tra.FechaRecepcionSecretaria,
		 tra.FechaEfectivizacionTramite,
		 pro.DocumentoIdentidad,
	     pro.NombreEmpresa,
	     pro.NombrePromocion,
	     pro.EstadoPromocion,
	     pro.EstadoAutorizacion,
	     tra.GrupoTramite,
	     tra.TipoTramite ,
	     tra.EstadoTramite ,
	     ci.TipoDocumentoProceso,
	     ci.SiglaTipoDocumentoProceso,
	     ci.FechaDocumento,
	     ci.CodigoCite,
	     ci.CadenaCite,
		 case when month(FechaEfectivizacionTramite)= month(tra.FechaRecepcionSecretaria) then 'CONFIRMADO'
		      else 'NO CONFIRMADO'
		  end EstadoEfectivizacion,
             convert(date,pro.FechaInicioPromocion) FechaInicioPromocion,
		 convert(date,pro.FechaFinPromocion) FechaFinPromocion,
		 convert(date,pro.FechaInicioAmpliacion) FechaInicioAmpliacion, 
         convert(date,pro.FechaFinAmpliacion)FechaFinAmpliacion,
		  tra.EstadoTramiteProceso,
		  tra.SubTipoTramite
    from [AlmacenCorporativo.Tramites] tra,
         [AlmacenCorporativo.PromocionesEmpresariales] pro,
		 [AlmacenCorporativo.Cites] ci
   where pro.EstadoPromocion='ACTIVO'
     and pro.TramiteID     = tra.TramiteAsociadoID
     and ci.TramiteID      = tra.TramiteID
     and ci.EstadoCite='ACTIVO'
    union    	
 select tra.TramiteID,
	     pro.PromocionEmpresarialID,
           tra.TramiteAsociadoID ,
	     pro.PersonaID,
	     case
         when tra.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when tra.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when tra.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when tra.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	     end 												'Oficina',   
	     tra.HojaRuta,
	     tra.FechaRecepcionSecretaria,
		 tra.FechaEfectivizacionTramite,
		 pro.DocumentoIdentidad,
	     pro.NombreEmpresa,
	     pro.NombrePromocion,
	     pro.EstadoPromocion,
	     pro.EstadoAutorizacion,
	     tra.GrupoTramite,
	     tra.TipoTramite ,
	     tra.EstadoTramite ,
	     null,
	     null,
	     null,
	     null,
	     null,
		 case when month(FechaEfectivizacionTramite)= month(tra.FechaRecepcionSecretaria) then 'CONFIRMADO'
		      else 'NO CONFIRMADO'
		  end EstadoEfectivizacion,
	       convert(date,pro.FechaInicioPromocion) FechaInicioPromocion,
		 convert(date,pro.FechaFinPromocion) FechaFinPromocion,
		 convert(date,pro.FechaInicioAmpliacion) FechaInicioAmpliacion, 
         convert(date,pro.FechaFinAmpliacion)FechaFinAmpliacion,
		  tra.EstadoTramiteProceso,
		  tra.SubTipoTramite
    from [AlmacenCorporativo.Tramites] tra,
         [AlmacenCorporativo.PromocionesEmpresariales] pro
   where pro.EstadoPromocion='ACTIVO'
     and pro.TramiteID     = tra.TramiteAsociadoID
	 and tra.TramiteID not in (select ci.TramiteID from [AlmacenCorporativo.Cites] ci where  ci.TramiteID      = tra.TramiteID and ci.EstadoCite='ACTIVO')
union all
select tra.TramiteID,
	     '' PromocionEmpresarialID,
           tra.TramiteAsociadoID ,
	     '' PersonaID,
	     case
         when tra.Oficina='DIRECCION NACIONAL'             then 'DNAL'
         when tra.Oficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when tra.Oficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when tra.Oficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	     end 												'Oficina',   
	     tra.HojaRuta,
	     tra.FechaRecepcionSecretaria,
		 tra.FechaEfectivizacionTramite,
		 '' DocumentoIdentidad,
	     '' NombreEmpresa,
	     '' NombrePromocion,
	     '' EstadoPromocion,
	     '' EstadoAutorizacion,
	     tra.GrupoTramite,
	     tra.TipoTramite ,
	     tra.EstadoTramite ,
	     ci.TipoDocumentoProceso,
	     ci.SiglaTipoDocumentoProceso,
	     ci.FechaDocumento,
	     ci.CodigoCite,
	     ci.CadenaCite,
		 case when month(FechaEfectivizacionTramite)= month(tra.FechaRecepcionSecretaria) then 'CONFIRMADO'
		      else 'NO CONFIRMADO'
		  end EstadoEfectivizacion,
              '',
		 '',
		 '',
		 '',
		   tra.EstadoTramiteProceso,
		  tra.SubTipoTramite
    from [AlmacenCorporativo.Tramites] tra,
		 [AlmacenCorporativo.Cites] ci
   where ci.TramiteID      = tra.TramiteID
	 and tra.TramiteAsociadoID  not in (select pr.TramiteID from [AlmacenCorporativo.PromocionesEmpresariales] pr where pr.TramiteID= tra.TramiteAsociadoID and pr.EstadoPromocion='ACTIVO')
     and ci.EstadoCite='ACTIVO';

CitesAsociados:
LOAD
  [Número Trámite]    as  [Número Trámite],
  [Nombre/Empresa Cite]   as  [Nombre/Empresa Cite],
  [Promoción Empresarial Cite]   as  [Promoción Empresarial Cite],
  [Cadena Cite]   as  [Cadena Cite],
  [Codigo Cite]   as [Codigo Cite],
  [Fecha Documento]   as [Fecha Documento],
  [Estado Cite]  as [Estado Cite],
  [Tipo Plantilla]  as  [Tipo Plantilla],
  [Usuario]  as  [Usuario],
  [Sigla Departamento]   as  [Sigla Departamento],
  [Sigla Dirección]  as  [Sigla Dirección],
  [Sigla Oficina]   as  [Sigla Oficina],
  [Sigla Tipo Documento]   as  [Sigla Tipo Documento],
  [Tipo Proceso] as  [Tipo Proceso Cite] ,
  [Cite Autorización Rechazo]   as [Cite RAA o AAPA],
  [Codigo Cite AutorizacionRechazo]    as [Código Cite RAA o AAPA],
  [Fecha Autorizacion Rechazo]           as [Fecha RAA o AAPA] ;
SQL
select distinct tra.TramiteID                           'Número Trámite',
       pro.nombreempresa                                'Nombre/Empresa Cite',
	   pro.nombrepromocion                              'Promoción Empresarial Cite',
	   PRO.CiteAutorizacionRechazo                      'Cite Autorización Rechazo',
	   pro.CodigoCiteAutorizacionRechazo                                   'Codigo Cite AutorizacionRechazo',
	   pro.FechaAutorizacionRechazo  'Fecha Autorizacion Rechazo',
	   ci.CadenaCite                                    'Cadena Cite',
	   ci.CodigoCite                                    'Codigo Cite',
	   ci.FechaDocumento                                'Fecha Documento',
	   ci.estadocite                                    'Estado Cite',
	   ci.tipoplantilla                                 'Tipo Plantilla',
	   ci.usuario                                       'Usuario',
	   ci.sigladepartamento                             'Sigla Departamento',
	   ci.sigladireccion                                'Sigla Dirección',
	   ci.siglaoficina                                  'Sigla Oficina',
	   ci.siglatipodocumentoproceso                     'Sigla Tipo Documento',
	   pro.tipoproceso                                   'Tipo Proceso' 	   
  from [MINAJPRODUCCION].dbo.[AlmacenCorporativo.Tramites] 	tra,
	   [MINAJPRODUCCION].dbo.[AlmacenCorporativo.PromocionesEmpresariales] pro,
	   [AlmacenCorporativo.Cites] ci
where pro.TramiteID            = tra.TramiteID
   //and tra.EstadoTramite      = $(vEstadoActivo)
   and pro.EstadoPromocion  = $(vEstadoActivo)
   and ci.TramiteID=pro.TramiteID
     union
select distinct tra.TramiteID                           'Número Trámite',
       dd.NombreEmpresa                                'Nombre/Empresa Cite',
	   dd.nombrepromocion                              'Promoción Empresarial Cite',
	   dd.CiteAAPA                      'Cite Autorización Rechazo',
	   dd.CodigoCiteAAPA                     'Codigo Cite AutorizacionRechazo',
	   dd.FechaAAPA                'Fecha Autorizacion Rechazo',
	   ci.CadenaCite                                    'Cadena Cite',
	   ci.CodigoCite                                    'Codigo Cite',
	   ci.FechaDocumento                                'Fecha Documento',
	   ci.estadocite                                    'Estado Cite',
	   ci.tipoplantilla                                 'Tipo Plantilla',
	   ci.usuario                                       'Usuario',
	   ci.sigladepartamento                             'Sigla Departamento',
	   ci.sigladireccion                                'Sigla Dirección',
	   ci.siglaoficina                                  'Sigla Oficina',
	   ci.siglatipodocumentoproceso                     'Sigla Tipo Documento',
	   dd.tipoproceso                                   'Tipo Proceso' 
	 from MINAJPRODUCCION.dbo.[AlmacenCorporativo.Sanciones] dd,
	      MINAJPRODUCCION.dbo.[AlmacenCorporativo.Tramites] tra,
		  [AlmacenCorporativo.Cites] ci
    where tra.TramiteID    = dd.TramiteID
	  and ci.TramiteID=dd.TramiteID;   

Mecanicas:
LOAD
      [TramiteID] as  [Número Trámite], 
      [Oficina]   as  [Dirección Mecánica], 
	  [NombreEmpresa]  as [Nombre Empresa Mecánica], 
	  [NombrePromocion] as [Nombre Promoción Mecánica], 
	  [CiteAutrizacionRechazo] as [Cite RAA Mecanica],
	  [TipoModalidadPremiacion] as [Modalidad Premiacion Mecanica], 
	  [TipoClasificacion]   as  [Clasificacion Mecanica],   
	  [TipoModalidadSorteo] as  [Modalidad Sorteo Mecanica], 
	  [Mecanica]  as  [Mecanica], 
	  [EstadoMecanica]   as [Estado Mecanica], 
	  [EstadoPromocion]  as [Estado Promocion Mecanica], 
	  [FechaAutorizacionRechazo]  as [Fecha RAA Mecanica],
	  [EstadoAutorizacion]   as [Estado Autorización Mecanica];
SQL
select me.TramiteID, 
       me.Oficina, 
	   me.NombreEmpresa, 
	   me.NombrePromocion, 
	   CiteAutrizacionRechazo,
	   TipoModalidadPremiacion, 
	   TipoClasificacion, 
	   TipoModalidadSorteo, 
	   Mecanica, 
	   EstadoMecanica, 
	   EstadoPromocion, 
	   pr.FechaAutorizacionRechazo,
	   pr.EstadoAutorizacion
  from [dbo].[AlmacenCorporativo.MecanicasPremiaciones] me,
       [AlmacenCorporativo.PromocionesEmpresariales] pr
 where me.tramiteid=pr.TramiteID;


ModalidadesPremiaciones:
LOAD
      [TramiteID] as  [Número Trámite], 
      [Oficina]   as  [Dirección Modalidad Premio], 
	  [NombreEmpresa]  as [Nombre Empresa  Modalidad Premio], 
	  [NombrePromocion] as [Nombre Promoción  Modalidad Premio], 
	  [CiteAutrizacionRechazo] as [Cite RAA  Modalidad Premio],
	  [FechaResolucion]  as [Fecha RAA  Modalidad Premio],
	  [TipoModalidadPremiacion] as [Modalidad Premiacion], 
	  [ModalidadAccesoPremio]  as [Modalidad Acceso Premio],
	   EstadoModalidadAccesoPremio  as [Estado Modalidad Acceso Premio]	  ,
	  [EstadoAutorizacion]   as [Estado Autorización Modalidad Acceso Premio];
SQL

select me.TramiteID,
       me.Oficina,
       me.NombreEmpresa,
	   me.NombrePromocion,
	   me.CiteAutrizacionRechazo,
	   me.FechaResolucion,
	   me.TipoModalidadPremiacion,
	   me.ModalidadAccesoPremio,
	   me.EstadoModalidadAccesoPremio,
	   pr.EstadoAutorizacion
  from [dbo].[AlmacenCorporativo.ModalidadPremios] me,
       [AlmacenCorporativo.PromocionesEmpresariales] pr
 where me.tramiteid=pr.TramiteID;

notificaciones:
load
 [TramiteID]   as  [Número Trámite],
 [FechaNotificacion] as [Fecha Notificacion],
 [TipoNotificacion]   as  [Tipo Notificacion] ;
sql

select  nt.FechaNotificacion, tab.TramiteID, nt.TipoNotificacion
 from (select min( NotificacionID) NotificacionID , TramiteID
		from [AlmacenCorporativo.Notificaciones] 
		WHERE TipoDocumentoProceso='RESOLUCION ADMINISTRATIVA DE AUTORIZACION' 
		 group by  TramiteID)tab,
		[AlmacenCorporativo.Notificaciones] nt
 where tab.NotificacionID= nt.NotificacionID
   and  nt.TramiteID=tab.TramiteID;

/******************  CONSULTAS****************/

Consultas:
LOAD
[Oficina Consulta]   as  [Oficina Consulta],
[NumeroCaso]  as [NumeroCaso] ,
       [NombreCompleto]  as [Nombre Persona Consulta] ,
	   [Telefono]  as [Telefono] ,
	   [Mail]  as  [Mail],
	   [Descripcion]  as  [Descripcion],
	   [Conclusion]  as  [Conclusion],
	   [FechaRegistro]  as [FechaRegistro] ,
	   [FechaConclusion]  as [FechaConclusion] ,
	   [FechaRespuesta]  as  [FechaRespuesta],
	   [FechaRegistroNotas]  as [FechaRegistroNotas],
	   [EstadoCaso]  as  [Estado Caso],
	   [Estado]  as  [Estado Consulta],
	   [Tipo Proceso Consulta]  as  [Tipo Proceso Consulta],
	   [Departamento Consulta]   as    [Departamento Consulta];
SQL
select 	   case
         when NombreOficina='DIRECCION NACIONAL'             then 'DNAL'
         when NombreOficina='DIRECCION REGIONAL COCHABAMBA'  then 'DRCB'
	     when NombreOficina='DIRECCION REGIONAL SANTA CRUZ'  then 'DRSC'
    	 when NombreOficina='DIRECCION REGIONAL LA PAZ'      then 'DRLP'
	   end 'Oficina Consulta', 
       NumeroCaso,
       NombreCompleto,
	   Telefono,
	   Mail,
	   ca.Descripcion,
	   Conclusion,
	   FechaRegistro,
	   FechaConclusion,
	   FechaRespuesta,
	   FechaRegistroNotas,
	   do.Descripcion 'EstadoCaso',
	   do1.Descripcion 'Estado',
	   do2.descripcion 'Tipo Proceso Consulta',
	   do3.descripcion 'Departamento Consulta'
from ( SELECT ca1.EstadoCasoID, ca1.CasoID, se.fecharegistro FechaRegistroNotas,NumeroCaso,
       NombreCompleto,
	   Telefono,
	   Mail,
	   Descripcion,
	   Conclusion,
	   ca1.FechaRegistro,
	   FechaConclusion,
	   FechaRespuesta,
	   ca1.EstadoID,
	   ca1.oficinaid,
	   ca1.TipoProcesoID,
	   ca1.DepartamentoID
                FROM [192.168.3.44].[SIAJPRODUCCION].dbo.[Portal.Casos] ca1,
                     [192.168.3.44].[SIAJPRODUCCION].dbo.[Portal.Asignaciones] asi,
					 [192.168.3.44].[SIAJPRODUCCION].dbo.[Portal.NotasSeguimiento]  se
			    where ca1.CasoID = asi.CasoID 
                and asi.AsignacionID =se.AsignacionID)ca,
     [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] do,
	 [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] do1,
	  [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] do2,
	 [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] do3,
	 [192.168.3.44].[SIAJPRODUCCION].dbo.[Organizacion.Oficinas] ofi
where ca.EstadoCasoID= do.DominioID
and ca.EstadoID=do1.DominioID
and ofi.oficinaid=ca.oficinaid
and TipoProcesoID = do2.dominioid
and DepartamentoID= do3.dominioid;

Consultas2016:
LOAD
[EstadoCaso] as [EstadoCaso2016] ,
[TipoCaso]   as [TipoCaso2016],
[SubEstadoCaso]   as [SubEstadoCaso2016],
[Cantidad]   as [Cantidad2016],
[FechaRegistroCaso] as [MesConsulta2016],
[Oficina Consulta 2016]  as [Oficina Consulta 2016],
[Departamento]   as [Departamento Consulta 2016],
[NumeroCaso]   as  [NumeroCaso Consluta 2016],
[NombreCompleto]  as [NombreCompleto Consulta 2016],
[Telefono]   as  [Telefono Consulta 2016],
[Mail]    as  [Mail Consulta 2016] ,
[DescripcionConsulta]   as [DescripcionConsulta 2016],
[Conclusion]   as   [Conclusion 2016],
[FechaConclusion]   as  [FechaConclusion 2016],
[FechaRespuesta]    as  [FechaRespuesta 2016];

SQL

	SELECT case 
        when pc.EstadoCasoID in  (1657,1676) then 'ATENDIDO'
		when pc.EstadoCasoID in  (1653) then 'PENDIENTES DE ATENCION'
		When pc.EstadoCasoID in  (1654,1656) then 'EN PROCESO'
       END EstadoCaso,
	    case
         when pc.OficinaID =1000  then 'DNAL'
         when pc.OficinaID =1003  then 'DRCB'
	     when pc.OficinaID =1002  then 'DRSC'
    	 when pc.OficinaID =1001  then 'DRLP'
	   end 'Oficina Consulta 2016', 
       tiporeg.Descripcion TipoCaso, 
	   do.Descripcion SubEstadoCaso, 
	   COUNT(pc.casoid) Cantidad,
	   pc.FechaRegistro FechaRegistroCaso,
	   dpto.Descripcion Departamento,
	   NumeroCaso, NombreCompleto,
	   Telefono,
	   Mail,
	   pc.Descripcion DescripcionConsulta,
	   Conclusion,
	   FechaConclusion,
	   FechaRespuesta
  FROM [192.168.3.44].[SIAJPRODUCCION].dbo.[Portal.Casos] pc,
       [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] do,
	   [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] dpto,
       [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] tiporeg
WHERE pc.OficinaID in (1001,1002,1003,1000)
   and pc.EstadoID = 1000
   and pc.EstadoCasoID = do.DominioID
   and pc.TipoRegistroID = tiporeg.DominioID
   and pc.DepartamentoID= dpto.DominioID
group by tiporeg.Descripcion, do.Descripcion,pc.EstadoCasoID,FechaRegistro,pc.OficinaID,
	   dpto.Descripcion ,
	   NumeroCaso,
	   NombreCompleto, 
	   Telefono,
	   Mail,
	   pc.Descripcion ,
	   Conclusion,
	   FechaConclusion,
	   FechaRespuesta
UNION ALL
// total de solicitudes ingresadas en el periodo
SELECT 'SOLICITUDES INGRESADAS', 
	    case
         when pc.OficinaID =1000  then 'DNAL'
         when pc.OficinaID =1003  then 'DRCB'
	     when pc.OficinaID =1002  then 'DRSC'
    	 when pc.OficinaID =1001  then 'DRLP'
	   end 'Oficina Consulta 2016',
       tiporeg.Descripcion, do.Descripcion, COUNT(pc.casoid),
	   pc.FechaRegistro,
	   dpto.Descripcion Departamento,
	   NumeroCaso, NombreCompleto,
	   Telefono,
	   Mail,
	   pc.Descripcion DescripcionConsulta,
	   Conclusion,
	   FechaConclusion,
	   FechaRespuesta
  FROM [192.168.3.44].[SIAJPRODUCCION].dbo.[Portal.Casos] pc,
       [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] do,
	   [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] dpto,
       [192.168.3.44].[SIAJPRODUCCION].dbo.[Transversales.Dominios] tiporeg
 WHERE pc.OficinaID in (1001,1002,1003,1000)
   and pc.EstadoID = 1000
   and pc.EstadoCasoID = do.DominioID
   and pc.TipoRegistroID = tiporeg.DominioID
   and pc.DepartamentoID= dpto.DominioID
 group by tiporeg.Descripcion, do.Descripcion,FechaRegistro,pc.OficinaID,
	   dpto.Descripcion ,
	   NumeroCaso,
	   NombreCompleto, 
	   Telefono,
	   Mail,
	   pc.Descripcion ,
	   Conclusion,
	   FechaConclusion,
	   FechaRespuesta;
/******************************************************************************/
IntervencionesSalasDeJuego:
LOAD
[LicenciaOperacionID]    as [LicenciaOperacionID],
      [DireccionRegional]    as [Oficina LO], 
       [NroActaJLAS]    as [NroActaJLAS], 
	   [FechaActaJLAS]    as [FechaActaJLAS], 
	   [CiteInformeIntervencion]    as [CiteInformeIntervencion], 
	   [FechaInformeIntervencion]    as [FechaInformeIntervencion], 
	   [NombreSalon]    as [Nombre Salon], 
	   [DireccionSalon]    as [Direccion Salon], 
	   [RazonSocial]    as [Empresa LO], 
	   [NITCI]    as [NITCI LO], 
	   [NombreEncargado]    as [Nombre Encargado LO], 
	   [CIEncargado]    as [CIEncargado LO], 
	   [Ciudad]    as [Departamento LO], 
	   [TipoActividad]    as [TipoActividad], 
	   [TipoActaIntervencion]    as [TipoActaIntervencion], 
	  [HoraIntervencion]    as [HoraIntervencion],
		[Telefono]    as [Telefono LO], 
		[DireccionEmpresa]    as [Direccion Empresa LO],
		[TipoMedioJuego]    as [Tipo Medio Juego], 
		[Precintos]    as [Precintos], 
		[CantidadMaquinasMediosJuego]    as [Cantidad Maquinas Medios Juego], 
		[MontoSancionadoUFV]    as [Monto Sancionado UFV],
		[MontoTotalSancionUFV]    as [Monto Total Sancion UFV];
SQL
select lo.LicenciaOperacionID,
       DireccionRegional, 
       NroActaJLAS, 
	   FechaActaJLAS, 
	   CiteInformeIntervencion, 
	   FechaInformeIntervencion, 
	   NombreSalon, 
	   DireccionSalon, 
	   RazonSocial, 
	   NITCI, 
	   NombreEncargado, 
	   CIEncargado, 
	   Ciudad, 
	   TipoActividad, 
	   TipoActaIntervencion, 
	   HoraIntervencion,
		Telefono, 
		DireccionEmpresa,
		TipoMedioJuego, 
		Precintos, 
		CantidadMaquinasMediosJuego, 
		MontoSancionadoUFV,
		MontoTotalSancionUFV
  FROM [MINAJPRODUCCION].[dbo].[ODS.LicenciaOperaciones] lo,
             [MINAJPRODUCCION].[dbo]. [ODS.MediosJuego] mj
where lo.LicenciaOperacionID=mj.LicenciaOperacionID;


DetalleProcesosDNC:
LOAD
[ProcesoIDCC] as [ProcesoIDCC],
[OficinaCC] as [OficinaCC], 
[UsuarioRegistroCC] as [UsuarioRegistroCC], 
[UsuarioAsignadoCC] as [UsuarioAsignadoCC], 
[NombreEmpresaCC] as [NombreEmpresaCC], 
[NITCC] as [NITCC],
[CodigoRSCC] as [CodigoRSCC], 
[FechaRSCC] as [FechaRSCC], 
[MontoUFVCC] as [MontoUFVCC], 
[LugarOperativoCC] as [LugarOperativoCC],
[CiteNotaSolicitudRetencionCC] as [CiteNotaSolicitudRetencionCC],
[FechaPresentacionASFICC] as [FechaPresentacionASFICC],
[TipoProcesoCC] as [TipoProcesoCC],
[JuzgadoTribunalCC] as [JuzgadoTribunalCC],
[LugarJuzgadoCC] as [LugarJuzgadoCC],
[FechaDemandaCC] as [FechaDemandaCC],
[EstadoProcesoCC] as [EstadoProcesoCC],
[OrigenActuadoAJCC] as [OrigenActuadoAJCC],
[FechaRegistroActuadoAJCC] as [FechaRegistroActuadoAJCC],
[OrigenActuadoJuzgadoCC] as [OrigenActuadoJuzgadoCC],
[FechaRegistroActuadoJuzgadoCC] as [FechaRegistroActuadoJuzgadoCC];

SQL
select 
distinct
pcc.ProcesoCobroCoactivoID as ProcesoIDCC,
(select NombreOficina from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Organizacion.Oficinas] as ofi where ofi.OficinaID=pcc.OficinaID) as OficinaCC,
(select Login from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] as usu where usu.UsuarioID=pcc.UsuarioD) as UsuarioRegistroCC,
(select Login from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] as usu where usu.UsuarioID=pcc.UsuarioAbogadoAsignadoID) as UsuarioAsignadoCC,
ISNULL((select top 1 NombreRazonSocial from [192.168.3.44].[SIAJPRODUCCION].[dbo].[RTIIS.Coactivados] as coa where coa.EstadoID=1000 and coa.ProcesoCobroCoactivoID=pcc.ProcesoCobroCoactivoID),'') as NombreEmpresaCC,
ISNULL((select top 1 NIToCI from [192.168.3.44].[SIAJPRODUCCION].[dbo].[RTIIS.Coactivados] as coa where coa.EstadoID=1000 and coa.ProcesoCobroCoactivoID=pcc.ProcesoCobroCoactivoID),'') as NITCC,
ISNULL(pcc.CodigoRS,'') as CodigoRSCC,
ISNULL(pcc.FechaRS,'') as FechaRSCC,
ISNULL(pcc.MontoSancionUFV,'') as MontoUFVCC,
(select Descripcion from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] as dom where dom.DominioID=pcc.LugarOperativoID) as LugarOperativoCC,
ISNULL(pcc.CiteNotaSolicitudRetencion,'') as CiteNotaSolicitudRetencionCC,
CONVERT(DATE, pcc.FechaPresentacionASFI) as FechaPresentacionASFICC,
ISNULL((select Descripcion from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] doPC where pcc.TipoProcesoCoactivoID = doPC.DominioID),'') as TipoProcesoCC,
pcc.JuzgadoTribunal as JuzgadoTribunalCC,
(select Descripcion from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] doLugar where pcc.LugarJuzgadoTribunalID = doLugar.DominioID) as LugarJuzgadoCC,
ISNULL(pcc.FechaPresentacionDemanda,'') as FechaDemandaCC,
(select Descripcion from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] dom where dom.DominioID = pcc.EstadoProcesoCoactivoID) as EstadoProcesoCC,
ISNULL((SELECT top 1 amc.OrigenActuadoID FROM [192.168.3.44].[SIAJPRODUCCION].[dbo].[RTIIS.ActuadosMensualesCoactivos] amc where amc.EstadoID = 1000 and AMC.OrigenActuadoID = 2347 and amc.ProcesoCobroCoactivoID=pcc.ProcesoCobroCoactivoID),'') as OrigenActuadoAJCC,
ISNULL((SELECT top 1 amc.FechaRegistro FROM [192.168.3.44].[SIAJPRODUCCION].[dbo].[RTIIS.ActuadosMensualesCoactivos] amc where amc.EstadoID = 1000 and AMC.OrigenActuadoID = 2347 and amc.ProcesoCobroCoactivoID=pcc.ProcesoCobroCoactivoID),'') as FechaRegistroActuadoAJCC,
ISNULL((SELECT top 1 amc.OrigenActuadoID FROM [192.168.3.44].[SIAJPRODUCCION].[dbo].[RTIIS.ActuadosMensualesCoactivos] amc where amc.EstadoID = 1000 and AMC.OrigenActuadoID = 2348 and amc.ProcesoCobroCoactivoID=pcc.ProcesoCobroCoactivoID),'') as OrigenActuadoJuzgadoCC,
ISNULL((SELECT top 1 amc.FechaRegistro FROM [192.168.3.44].[SIAJPRODUCCION].[dbo].[RTIIS.ActuadosMensualesCoactivos] amc where amc.EstadoID = 1000 and AMC.OrigenActuadoID = 2348 and amc.ProcesoCobroCoactivoID=pcc.ProcesoCobroCoactivoID),'') as FechaRegistroActuadoJuzgadoCC
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[RTIIS.ProcesosCobrosCoactivos] as pcc
where pcc.EstadoID=1000;

DetalleConsultasEscritasDNC:
LOAD
[ConsultaEscritaID] as [ConsultaEscrita],
[UbicacionFisica] as [UbicacionFisicaCE],
[NumeroHR] as [NumeroHRCE],
[LugarPresentacion] as [LugarPresentacionCE],
[FechaRecepcionAJ] as [FechaRecepcionAJCE],
[FechaRecepcionDNC] as [FechaRecepcionDNCCE],
[Consultante] as [ConsultanteCE],
[AbogadoAsignado] as [AbogadoAsignadoCE],
[FechaDerivacionAbogado] as [FechaDerivacionAbogadoCE],
[ArgumentosConsulta] as [ArgumentosConsultaCE],
[TipoRespuesta] as [TipoRespuestaCE],
[CiteRespuesta] as [CiteRespuestaCE],
[FechaCiteRespuesta] as [FechaCiteRespuestaCE],
[FechaNotificacion] as [FechaNotificacionCE],
[CiteNotaComplementacion] as [CiteNotaComplementacionCE],
[FechaCiteNotaComplementacion] as [FechaCiteNotaComplementacionCE],
[FechaEntregaNotaComplementacion] as [FechaEntregaNotaComplementacionCE],
[RespuestaDesestimacion] as [RespuestaDesestimacionCE],
[CiteNotaDesestimacionRespuesta] as [CiteNotaDesestimacionRespuestaCE],
[FechaCiteNotaDesestimacionRespuesta] as [FechaCiteNotaDesestimacionRespuestaCE],
[FechaEntregaNotaDesestimacionRespuesta] as [FechaEntregaNotaDesestimacionRespuestaCE],
[ArgumentosRespuesta] as [ArgumentosRespuestaCE],
[PeriodoFinalizacion] as [PeriodoFinalizacionCE];

SQL
SELECT 
[ConsultaEscritaID],
[UbicacionFisica],
[NumeroHR],
[LugarPresentacion],
[FechaRecepcionAJ],
[FechaRecepcionDNC],
[Consultante],
[AbogadoAsignado],
[FechaDerivacionAbogado],
[ArgumentosConsulta],
[TipoRespuesta],
[CiteRespuesta],
[FechaCiteRespuesta],
[FechaNotificacion],
[CiteNotaComplementacion],
[FechaCiteNotaComplementacion],
[FechaEntregaNotaComplementacion],
[RespuestaDesestimacion],
[CiteNotaDesestimacionRespuesta],
[FechaCiteNotaDesestimacionRespuesta],
[FechaEntregaNotaDesestimacionRespuesta],
[ArgumentosRespuesta],
[PeriodoFinalizacion]
FROM
	[MINAJPRODUCCION].[dbo].[ODS.DNCConsultasEscritas];

PAJELSolicitudCredenciales:
LOAD
[Regional] as [PAJELSolCredRegional],
[DepartamentoFiscal] as [PAJELSolCredDepartamentoFiscal],
[NombreEmpresa] as [PAJELSolCredNombreEmpresa],
[FechaSolicitud] as [PAJELSolCredFechaSolicitud];

SQL
select 
	case
		when sc.OficinaID=1001
		then 'DRLP'
		when sc.OficinaID=1002
		then 'DRSC'
		when sc.OficinaID=1003
		then 'DRCB'
	end Regional,
	dom.Descripcion DepartamentoFiscal,
	sc.NombreEmpresa NombreEmpresa,
	sc.FechaSolicitud FechaSolicitud
from
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[GobElectronico.SolicitudesCredenciales] as sc,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] as dom
where 
	dom.DominioID = sc.DepartamentoFiscalID and
	sc.EstadoID=1000 and sc.FechaSolicitud> '2017-08-05';

PAJELSolicitudPromocionesEmpresariales:
LOAD
[Regional] as [PAJELSolPERegional],
[DepartamentoFiscal] as [PAJELSolPEDepartamentoFiscal],
[NombreEmpresa] as [PAJELSolPENombreEmpresa],
[NombrePromocion] as [PAJELSolPENombrePromocion],
[FechaSolicitud] as [PAJELSolPEFechaSolicitud],
[CadenaCiteResolucion] as [PAJELSolPECadenaCiteResolucion];

SQL
select 
	case
		when pe.OficinaID=1001 then 'DRLP'
		when pe.OficinaID=1002 then 'DRSC'
		when pe.OficinaID=1003 then 'DRCB'
	end Regional,
	dom.Descripcion DepartamentoFiscal,
	pj.NombreEmpresa NombreEmpresa,
	pe.NombrePromocion NombrePromocion,
	tf.FechaRegistro FechaSolicitud,
	pe.CadenaCiteResolucion CadenaCiteResolucion
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.PromocionesEmpresariales] pe,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] as dom,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] pj,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.Personas] p,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Tramites.TramitesFlujosRecepciones] tf
where 
	p.DepartamentoFiscalID = dom.DominioID and
	pj.PersonaID = p.PersonaID and pj.PersonaID = pe.PersonaID and
	pe.TramiteID = tf.TramiteID and
	tf.EstadoID = 1000 and
	pe.EstadoID=1000 and 
	tf.FlujoID in (select FlujoID from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Procesos.Flujos] where Nombre like '%web%' and TipoTramiteID=1126)	
	and tf.FechaRegistro>'2017-08-05';

PAJELSolicitudAmpliaciones:
LOAD
[Regional] as [PAJELSolAMPRegional],
[DepartamentoFiscal] as [PAJELSolAMPDepartamentoFiscal],
[NombreEmpresa] as [PAJELSolAMPNombreEmpresa],
[NombrePromocion] as [PAJELSolAMPNombrePromocion],
[FechaSolicitud] as [PAJELSolAMPFechaSolicitud];

SQL
select
	case
		when spe.OficinaID=1001 then 'DRLP'
		when spe.OficinaID=1002 then 'DRSC'
		when spe.OficinaID=1003 then 'DRCB'
	end Regional,
	dom.Descripcion DepartamentoFiscal,
	pj.NombreEmpresa NombreEmpresa,
	spe.NombrePromocion NombrePromocion,
amp.FechaEnvioAJ FechaSolicitud
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[GobElectronico.SolicitudesPromocionesEmpresariales] spe,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[GobElectronico.Ampliaciones] amp,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] as dom,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] pj,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.Personas] p
where 
	spe.SolicitudPromocionEmpresarialID=amp.SolicitudPromocionEmpresarialID and 
	p.DepartamentoFiscalID = dom.DominioID and
	pj.PersonaID = p.PersonaID and pj.PersonaID = spe.PersonaEmpresaID and
	amp.EstadoID=1000 and 
	amp.FechaEnvioAJ is not null;

PAJELSolicitudDesistimiento:
LOAD
[Regional] as [PAJELSolDESRegional],
[DepartamentoFiscal] as [PAJELSolDESDepartamentoFiscal],
[NombreEmpresa] as [PAJELSolDESNombreEmpresa],
[NombrePromocion] as [PAJELSolDESNombrePromocion],
[FechaSolicitud] as [PAJELSolDESFechaSolicitud];

SQL
select
	case
		when spe.OficinaID=1001 then 'DRLP'
		when spe.OficinaID=1002 then 'DRSC'
		when spe.OficinaID=1003 then 'DRCB'
	end Regional,
	dom.Descripcion DepartamentoFiscal,
	pj.NombreEmpresa NombreEmpresa,
	spe.NombrePromocion NombrePromocion,
	desis.FechaEnvioAJ FechaSolicitud
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[GobElectronico.SolicitudesPromocionesEmpresariales] spe, 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[GobElectronico.Desistimientos] desis,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] as dom,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] pj,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.Personas] p
where 
	spe.SolicitudPromocionEmpresarialID=desis.SolicitudPromocionEmpresarialID and 
	p.DepartamentoFiscalID = dom.DominioID and
	pj.PersonaID = p.PersonaID and pj.PersonaID = spe.PersonaEmpresaID and
	desis.EstadoID=1000 and desis.FechaEnvioAJ is not null;

PAJELSolicitudDocsPosteriores:
LOAD
[Regional] as [PAJELSolDPRegional],
[DepartamentoFiscal] as [PAJELSolDPDepartamentoFiscal],
[NombreEmpresa] as [PAJELSolDPNombreEmpresa],
[NombrePromocion] as [PAJELSolDPNombrePromocion],
[FechaSolicitud] as [PAJELSolDPFechaSolicitud];

SQL
select
	case
		when spe.OficinaID=1001 then 'DRLP'
		when spe.OficinaID=1002 then 'DRSC'
		when spe.OficinaID=1003 then 'DRCB'
	end Regional,
	dom.Descripcion DepartamentoFiscal,
	pj.NombreEmpresa NombreEmpresa,
	spe.NombrePromocion NombrePromocion,
	docpost.FechaRegistro FechaSolicitud
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[GobElectronico.SolicitudesPromocionesEmpresariales] spe, 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[GobElectronico.DocumentosPosteriores] docpost,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] as dom,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasJuridicas] pj,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.Personas] p
where 
	spe.SolicitudPromocionEmpresarialID=docpost.SolicitudPromocionEmpresarialID and 
	p.DepartamentoFiscalID = dom.DominioID and
	pj.PersonaID = p.PersonaID and pj.PersonaID = spe.PersonaEmpresaID and
	docpost.EstadoID=1000 and docpost.FechaRegistro is not null;
