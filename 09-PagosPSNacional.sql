DetalleConsolidadoPagos:
load 
	[Oficina] as [Pagos_Oficina],
	[CiteRS] as [Pagos_CiteRS],
	[FechaRS] as [Pagos_FechaRS],
	[Cite] as [Pagos_Cite],
	[TipoDocumento] as [Pagos_TipoDocumento],
	[NumeroBoletaPago] as [Pagos_NumeroBoletaPago],
	[PersonaRealizoPago] as [Pagos_PersonaRealizoPago],
	[TipoPago] as [Pagos_TipoPago],
	[Motivo] as [Pagos_Motivo],
	[AclaracionMotivo] as [Pagos_AclaracionMotivo],
	[FechaPago] as [Pagos_FechaPago],
	[FechaPresentacionBoleta] as [Pagos_FechaPresentacionBoleta],
	[MontoPagadoUFV] as [Pagos_MontoPagadoUFV],
	[ValorCotizacionUFV] as [Pagos_ValorCotizacionUFV],
	[MontoPagadoBS] as [Pagos_MontoPagadoBS],
	[NombreUsuarioRegistro] as [Pagos_NombreUsuarioRegistro],
	[FechaRegistroPago] as [Pagos_FechaRegistroPago],
	[CiteVerificacionPago] as [Pagos_CiteVerificacionPago],
	[EstadoVerificacionPago] as [Pagos_EstadoVerificacionPago],
	[EstadoCertificacionPagoDNAF] as [Pagos_EstadoCertificacionPagoDNAF],
	[EstadoVerificacionCertificacion] as [Pagos_EstadoVerificacionCertificacion],
	[EstadoControl] as [Pagos_EstadoControl];
SQL
select 
	case
		when  recBol.OficinaID=1000
		then 'DNAL'
		when  recBol.OficinaID=1001
		then 'DRLP'
		when recBol.OficinaID=1002
		then 'DRSC'
		when recBol.OficinaID=1003
		then 'DRCB'
	end 'Oficina',
	case
		when recbol.TipoDocumentoProcesoID = 1078
		then recBol.CadenaCite
		else ''
	end 'CiteRS',
	case
		when recbol.TipoDocumentoProcesoID = 1078
		then recBol.FechaCite
		else ''
	end 'FechaRS',
	recbol.CadenaCite 'Cite',
	tipodoc.Abreviatura 'TipoDocumento',
	detBol.NumeroBoletaPago 'NumeroBoletaPago',
	detBol.PersonaRealizoPago 'PersonaRealizoPago',
	tipopago.Descripcion 'TipoPago',
	detBol.Motivo 'Motivo',
	detBol.AclaracionMotivo 'AclaracionMotivo',
	detBol.FechaPago 'FechaPago',
	detBol.FechaPresentacionBoleta 'FechaPresentacionBoleta',
	detBol.MontoPagadoUFV 'MontoPagadoUFV',
	detBol.CotizacionUFV 'ValorCotizacionUFV',
	detBol.MontoPagadoBS 'MontoPagadoBS',
	perNat.Nombres + ' ' + perNat.ApellidoPaterno + ' ' + perNat.ApellidoMaterno 'NombreUsuarioRegistro',
	detBol.FechaRegistro 'FechaRegistroPago',
	certif.CadenaCiteCertificacion 'CiteVerificacionPago',
	estadoVerif.Descripcion 'EstadoVerificacionPago',
	estadoVerif.Descripcion 'EstadoCertificacionPagoDNAF',
	estadoVerif.Descripcion 'EstadoVerificacionCertificacion',
	estadoVerif.Descripcion 'EstadoControl'
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.RecepcionesBoletasPagos] recBol,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.DetallesBoletasPagos] detBol,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.CertificadosPagos] certif,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.VerificacionesPagos] verif,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] tipodoc,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] tipopago,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] estadoVerif,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] usu,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasNaturales] perNat
where
	recBol.RecepcionBoletaPagoID = detbol.RecepcionBoletaPagoID
	and recBol.EstadoID=1000
	and detBol.EstadoID=1000
	and certif.DetalleBoletaPagoID = detbol.DetalleBoletaPagoID
	and verif.VerificacionPagoID = certif.VerificacionPagoID
	and tipodoc.DominioID=recBol.TipoDocumentoProcesoID
	and tipopago.DominioID=detBol.TipoPagoID
	and estadoVerif.DominioID = verif.EstadoVerificacionPagoID
	and usu.UsuarioID = detBol.UsuarioID
	and usu.PersonaID = perNat.PersonaID;


DetalleDevolucionPagos:
load 
	[Oficina] as [Devolucion_Oficina],
	[NumeroBoletaPago] as [Devolucion_NumeroBoletaPago],
	[PersonaRealizoPago] as [Devolucion_PersonaRealizoPago],
	[Motivo] as [Devolucion_Motivo],
	[FechaPago] as [Devolucion_FechaPago],
	[FechaPresentacionBoleta] as [Devolucion_FechaPresentacionBoleta],
	[MontoBS] as [Devolucion_MontoPagadoBS],
	[NombreUsuarioRegistro] as [Devolucion_NombreUsuarioRegistro],
	[FechaRegistro] as [Devolucion_FechaRegistroPago];
SQL

select
	case
		when  recBol.OficinaID=1000
		then 'DNAL'
		when  recBol.OficinaID=1001
		then 'DRLP'
		when recBol.OficinaID=1002
		then 'DRSC'
		when recBol.OficinaID=1003
		then 'DRCB'
	end 'Oficina',
	detBol.NumeroBoletaPago 'NumeroBoletaPago',
	detBol.PersonaRealizoPago 'PersonaRealizoPago',
	detBol.Motivo 'Motivo',
	detBol.FechaPago 'FechaPago',
	detBol.FechaPresentacionBoleta 'FechaPresentacionBoleta',
	detBol.MontoPagadoBS 'MontoBS',
	perNat.Nombres + ' ' + perNat.ApellidoPaterno + ' ' + perNat.ApellidoMaterno 'NombreUsuarioRegistro',
	detBol.FechaRegistro 'FechaRegistro'
from 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.DevolucionPagos] recBol,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.DetallesBoletasPagos] detBol,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Usuarios.Usuarios] usu,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Personas.PersonasNaturales] perNat
where
	recBol.DetalleBoletaPagoID = detbol.DetalleBoletaPagoID
	and recBol.EstadoID=1000
	and detBol.EstadoID=1000
	and usu.UsuarioID = detBol.UsuarioID
	and usu.PersonaID = perNat.PersonaID;
	
/**********DETALLE PAGOS SIAJ desde 31/10/2018 adelante***************/
RegistroPagosSIAJ:
load
	[Oficina] as [PagosSIAJ_Oficina],
	[TramiteSancionador] as [PagosSIAJ_TramiteSancionador],
	[TramiteBoletaPago] as [PagosSIAJ_TramiteBoletaPago],
	[CadenaCite] as [PagosSIAJ_CadenaCite],
	[TipoProceso] as [PagosSIAJ_TipoProceso],
	[FechaPresentacionBoleta] as [PagosSIAJ_FechaPresentacionBoleta],
	[FechaPago] as [PagosSIAJ_FechaPago],
	[NumeroBoletaPago] as [PagosSIAJ_NumeroBoletaPago],
	[MontoPagadoBS] as [PagosSIAJ_MontoPagadoBS],
	[MontoPagadoUFV] as [PagosSIAJ_MontoPagadoUFV], 
	[TipoOrigenPago] as [PagosSIAJ_TipoOrigenPago],
	[FechaRegistro] as [PagosSIAJ_FechaRegistro];
SQL

select
	case
         when rbp.OficinaID =1000  then 'DNAL'
         when rbp.OficinaID =1003  then 'DRCB'
	     when rbp.OficinaID =1002  then 'DRSC'
    	 when rbp.OficinaID =1001  then 'DRLP'
	end 'Oficina', 
	c.TramiteID as TramiteSancionador,
	rbp.TramiteID as TramiteBoletaPago,
	rbp.CadenaCite,
	case
		when EXISTS(select TramiteID from [192.168.3.44].[SIAJPRODUCCION].[dbo].[PromocionesEmpresariales.ProcesosSanciones] where TramiteID = c.TramiteID) then 'SANCION FISCALIZACION'
		when EXISTS(select TramiteID from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Sanciones.ProcesosSancionesEmpresas] where TramiteID = c.TramiteID) then 'SANCION DETECCION'
	end 'TipoProceso',
	dbp.FechaPresentacionBoleta,
	dbp.FechaPago,
	dbp.NumeroBoletaPago,
	dbp.MontoPagadoBS,
	dbp.MontoPagadoUFV, 
	dop.Descripcion as TipoOrigenPago,
	dbp.FechaRegistro 
from [192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.RecepcionesBoletasPagos] rbp, 
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.VerificacionesPagos] vbp,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Pagos.DetallesBoletasPagos] dbp,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] dtp,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] dop,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Transversales.Dominios] ddp,
	[192.168.3.44].[SIAJPRODUCCION].[dbo].[Cites.Cites] c
where rbp.EstadoID = 1000
	and dbp.EstadoID = 1000
	and c.EstadoID = 1000
	and rbp.TramiteID = vbp.TramiteID
	and rbp.RecepcionBoletaPagoID = dbp.RecepcionBoletaPagoID
	and dbp.TipoPagoID = dtp.DominioID
	and dbp.TipoOrigenPagoID = dop.DominioID
	and dbp.TipoDocumentoProcesoID = ddp.DominioID
	and c.CiteID = dbp.CiteID
order by dbp.TipoOrigenPagoID asc;