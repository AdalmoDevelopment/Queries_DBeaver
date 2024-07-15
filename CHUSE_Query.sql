delete from chuse

INSERT INTO chuse (
	sector,
	clave,
	centroreferenciasector,
	nombre,
	cuenta,
	nima,
	cantidad_kilos,
    cantidad_kilos_brutos,
    codigo,
    descripc,
    cantidad_contenedores,
    retirado,
    tipo_residuo,
    albaran,
    justificante,
    tipo_contenedor,
    tipo_contenedor_nombre,
    matricula ,
    FechaServicio ,
    unitatfuncionalcodi ,
    unitatfuncionaldesc ,
    serie ,
    "document" ,
    destino,
    ler_codigo,
    ler_texto,
    grupo_residuo,
    codigoqr  
)

  select  
	
  	'07' as sector,
  	'N07NB' as clave,
  	'No' as centroreferenciasector,
  	'HOSPITAL SON ESPASES-CHUSE',
  	'209041',
  	'0700006981',
  	
  	(psdl.pnt_product_economic_uom_qty - pt.weight) AS cantidad_kilos,
  	
    psdl.pnt_product_economic_uom_qty AS cantidad_kilos_brutos,
    
    '0700006981',
   
    psdl.name AS descripc,
    
    psdl.pnt_container_qty as cantidad_contenedores,
    
    psd.pnt_single_document_type,
  
    psdl.pnt_customer_name as tipo_residuo,
    
    psd.name as albaran,
    
    pwtd.pnt_legal_code as justificante,
    
    pp.default_code as tipo_contenedor,
    
    pt.name as tipo_contenedor_nombre,
    
    fv.license_plate AS matricula,
    
    psdl.pnt_effective_date AS fechaservicio,
  
    pfu.name AS unitatfuncionalcodi,
    
    pfu.description AS unitatfuncionaldesc,
    
    'ADU',
    
    psd.name as document,
    
    'ADALMO',
    
    pptwl.name,
    
    pptwl.pnt_description,
   	pc.complete_name as grupo_residuo, 
    
    
    psdl.pnt_tag_app as "CodigoQR"
    FROM pnt_single_document psd
    JOIN pnt_single_document_line psdl ON psd.id = psdl.pnt_single_document_id
    left JOIN pnt_waste_transfer_document pwtd ON pwtd.id  = psdl.pnt_waste_transfer_document_id
    JOIN (
    SELECT id, name
    FROM pnt_single_document
    WHERE pnt_du_partner_id = 12583
) subquery ON psd.id = subquery.id

left JOIN product_product pp_weight ON psdl.pnt_container_id = pp_weight.id
left JOIN product_template pt_weight ON pp_weight.product_tmpl_id = pt_weight.id

left JOIN product_product pp ON psdl.pnt_product_id = pp.id
left JOIN product_template pt ON pp.product_tmpl_id = pt.id
left JOIN pnt_product_tmpl_waste_ler pptwl ON pt.pnt_waste_ler_id = pptwl.id
left JOIN product_category pc ON pt.categ_id = pc.id 

left JOIN pnt_functional_unit pfu ON psdl.pnt_functional_unit_id = pfu.id

LEFT JOIN fleet_vehicle fv ON psd.pnt_vehicle_id = fv.id
LEFT JOIN pnt_app_tag pat ON psdl.pnt_app_tag_id = pat.id;


solo finalizados:
delete from chuse
INSERT INTO chuse (
    sector,
    clave,
    centroreferenciasector,
    nombre,
    cuenta,
    nima,
    cantidad_kilos,
    cantidad_kilos_brutos,
    codigo,
    descripc,
    cantidad_contenedores,
    retirado,
    tipo_residuo,
    albaran,
    justificante,
    tipo_contenedor,
    tipo_contenedor_nombre,
    matricula,
    FechaServicio,
    unitatfuncionalcodi,
    unitatfuncionaldesc,
    serie,
    "document",
    destino,
    ler_codigo,
    ler_texto,
    grupo_residuo,
    codigoqr  
)
SELECT  
    '07' as sector,
    'N07NB' as clave,
    'No' as centroreferenciasector,
    'HOSPITAL SON ESPASES-CHUSE',
    '209041',
    '0700006981',
    (psdl.pnt_product_economic_uom_qty - pt.weight) AS cantidad_kilos,
    psdl.pnt_product_economic_uom_qty AS cantidad_kilos_brutos,
    '0700006981',
    psdl.name AS descripc,
    psdl.pnt_container_qty as cantidad_contenedores,
    psd.pnt_single_document_type,
    psdl.pnt_customer_name as tipo_residuo,
    psd.name as albaran,
    pwtd.pnt_legal_code as justificante,
    pp.default_code as tipo_contenedor,
    pt.name as tipo_contenedor_nombre,
    fv.license_plate AS matricula,
    psdl.pnt_effective_date AS fechaservicio,
    pfu.name AS unitatfuncionalcodi,
    pfu.description AS unitatfuncionaldesc,
    'ADU',
    psd.name as document,
    'ADALMO',
    pptwl.name,
    pptwl.pnt_description,
    pc.complete_name as grupo_residuo, 
    psdl.pnt_tag_app as "CodigoQR"
FROM pnt_single_document psd
JOIN pnt_single_document_line psdl ON psd.id = psdl.pnt_single_document_id
LEFT JOIN pnt_waste_transfer_document pwtd ON pwtd.id  = psdl.pnt_waste_transfer_document_id
JOIN (
    SELECT id, name
    FROM pnt_single_document
    WHERE pnt_du_partner_id = 12583
) subquery ON psd.id = subquery.id
LEFT JOIN product_product pp_weight ON psdl.pnt_container_id = pp_weight.id
LEFT JOIN product_template pt_weight ON pp_weight.product_tmpl_id = pt_weight.id
LEFT JOIN product_product pp ON psdl.pnt_product_id = pp.id
LEFT JOIN product_template pt ON pp.product_tmpl_id = pt.id
LEFT JOIN pnt_product_tmpl_waste_ler pptwl ON pt.pnt_waste_ler_id = pptwl.id
LEFT JOIN product_category pc ON pt.categ_id = pc.id 
LEFT JOIN pnt_functional_unit pfu ON psdl.pnt_functional_unit_id = pfu.id
LEFT JOIN fleet_vehicle fv ON psd.pnt_vehicle_id = fv.id
LEFT JOIN pnt_app_tag pat ON psdl.pnt_app_tag_id = pat.id
WHERE psd.state = 'finished';
