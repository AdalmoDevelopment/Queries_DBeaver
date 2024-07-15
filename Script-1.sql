SELECT  
    '07' AS sector,
    'N07NB' AS clave,
    'No' AS centroreferenciasector,
    'HOSPITAL SON ESPASES-CHUSE' AS nombre,
    '209041' AS cuenta,
    '0700006981' AS nima,
    (psdl.pnt_product_economic_uom_qty - COALESCE(pt.weight, 0)) AS cantidad_kilos,
    psdl.pnt_product_economic_uom_qty AS cantidad_kilos_brutos,
    '0700006981' AS codigo,
    psdl.name AS descripc,
    psdl.pnt_container_qty AS cantidad_contenedores,
    psd.pnt_single_document_type AS retirado,
    psdl.pnt_customer_name AS tipo_residuo,
    psd.name AS albaran,
    pwtd.pnt_legal_code AS justificante,
    pp.default_code AS tipo_contenedor,
    pt.name AS tipo_contenedor_nombre,
    fv.license_plate AS matricula,
    pptwl.name AS ler,
    pptwl.pnt_description AS ler_texto,
    psdl.pnt_effective_date AS fechaservicio,
    pfu.name AS unitatfuncionalcodi,
    pfu.description AS unitatfuncionaldesc,
    'ADU' AS serie,
    psd.name AS document,
    'ADALMO' AS destino,
    psdl.pnt_tag_app AS "CodigoQR"
FROM pnt_single_document_line psdl
JOIN pnt_single_document psd ON psdl.pnt_single_document_id = psd.id
LEFT JOIN pnt_waste_transfer_document pwtd ON pwtd.id = psdl.pnt_waste_transfer_document_id
JOIN (
    SELECT id, name
    FROM pnt_single_document
    WHERE pnt_du_partner_id = 12583
) subquery ON psd.id = subquery.id
LEFT JOIN product_product pp ON psdl.pnt_product_id = pp.id
LEFT JOIN product_template pt ON pp.product_tmpl_id = pt.id
LEFT JOIN pnt_product_tmpl_waste_ler pptwl ON pt.pnt_waste_ler_id = pptwl.id
LEFT JOIN pnt_functional_unit pfu ON psdl.pnt_functional_unit_id = pfu.id
LEFT JOIN fleet_vehicle fv ON psd.pnt_vehicle_id = fv.id
LEFT JOIN pnt_app_tag pat ON psdl.pnt_app_tag_id = pat.id;
