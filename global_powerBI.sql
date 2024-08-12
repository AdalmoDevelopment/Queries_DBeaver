select
	ptc.name as Contenedor,
    psd.name,
    pptwt_t2.name AS tratamiento,
    pptwt_t5.name AS peligrosidad,
    psd.pnt_single_document_type,
    psd.pnt_order_reference,
    psd.pnt_effective_date,
    psd.state,
    rp_holder.display_name,
    rp_pickup.display_name,
    rp_delivery.display_name,
    pt.name AS product_name,
    pptwl.name AS waste_ler_name,
    psdl.pnt_product_uom_qty,
    fv.license_plate,
    pwtd.pnt_legal_code AS waste_transfer_document_name,
    rc.name AS empresa  -- Añadir esta línea
FROM
    pnt_single_document psd
LEFT JOIN
    res_partner rp_holder ON psd.pnt_holder_id = rp_holder.id
LEFT JOIN
    res_partner rp_pickup ON psd.pnt_partner_pickup_id = rp_pickup.id
LEFT JOIN
    res_partner rp_delivery ON psd.pnt_partner_delivery_id = rp_delivery.id
LEFT JOIN
    pnt_single_document_line psdl ON psdl.pnt_single_document_id = psd.id
LEFT JOIN
    pnt_waste_transfer_document pwtd ON pwtd.id = psdl.pnt_waste_transfer_document_id
LEFT JOIN
    product_product pp ON psdl.pnt_product_id = pp.id
    
LEFT JOIN
    product_product ppc ON psdl.pnt_container_id = ppc.id
LEFT JOIN
    product_template ptc ON ppc.product_tmpl_id = ptc.id
    
LEFT JOIN
    product_template pt ON pp.product_tmpl_id = pt.id
LEFT JOIN 
    (
        SELECT 
            pptwtr.product_id,
            STRING_AGG(pptwt.name, ', ') AS name
        FROM 
            pnt_product_tmpl_waste_table_rel pptwtr
        LEFT JOIN 
            pnt_product_tmpl_waste_table pptwt ON pptwtr.pnt_waste_table_id = pptwt.id
        WHERE 
            pptwt.pnt_table_type = 'table2'
        GROUP BY 
            pptwtr.product_id
    ) AS pptwt_t2 ON pt.id = pptwt_t2.product_id
LEFT JOIN 
    (
        SELECT 
            pptwtr.product_id,
            STRING_AGG(pptwt.name, ', ') AS name
        FROM 
            pnt_product_tmpl_waste_table_rel pptwtr
        LEFT JOIN 
            pnt_product_tmpl_waste_table pptwt ON pptwtr.pnt_waste_table_id = pptwt.id
        WHERE 
            pptwt.pnt_table_type = 'table5'
        GROUP BY 
            pptwtr.product_id
    ) AS pptwt_t5 ON pt.id = pptwt_t5.product_id
LEFT JOIN
    pnt_product_tmpl_waste_ler pptwl ON pt.pnt_waste_ler_id = pptwl.id
LEFT JOIN
    pnt_functional_unit pfu ON psdl.pnt_functional_unit_id = pfu.id
LEFT JOIN
    fleet_vehicle fv ON psd.pnt_vehicle_id = fv.id
LEFT JOIN
    pnt_app_tag pat ON psdl.pnt_app_tag_id = pat.id
LEFT JOIN
    pnt_waste_transfer_document pwtd2 ON psdl.pnt_product_waste_id = pwtd2.id
LEFT JOIN
    res_company rc ON psd.company_id = rc.id;



****************************************************
ULTIMA VERSION


SELECT
    ptc.name AS Contenedor,
    psd.name,
    pptwt_t2.name AS tratamiento,
    pptwt_t5.name AS peligrosidad,
    psd.pnt_single_document_type,
    psd.pnt_order_reference,
    psd.pnt_effective_date,
    psd.state,
    rp_holder.display_name,
    rp_pickup.display_name,
    rp_delivery.display_name,
    pt.name AS product_name,
    pptwl.name AS waste_ler_name,
    psdl.pnt_product_uom_qty,
    fv.license_plate,
    pwtd.pnt_legal_code AS waste_transfer_document_name,
    rc.name AS empresa,  -- Campo añadido
    pc.name AS product_category_name  -- Nuevo campo añadido
FROM
    pnt_single_document psd
LEFT JOIN
    res_partner rp_holder ON psd.pnt_holder_id = rp_holder.id
LEFT JOIN
    res_partner rp_pickup ON psd.pnt_partner_pickup_id = rp_pickup.id
LEFT JOIN
    res_partner rp_delivery ON psd.pnt_partner_delivery_id = rp_delivery.id
LEFT JOIN
    pnt_single_document_line psdl ON psdl.pnt_single_document_id = psd.id
LEFT JOIN
    pnt_waste_transfer_document pwtd ON pwtd.id = psdl.pnt_waste_transfer_document_id
LEFT JOIN
    product_product pp ON psdl.pnt_product_id = pp.id
    
LEFT JOIN
    product_product ppc ON psdl.pnt_container_id = ppc.id
LEFT JOIN
    product_template ptc ON ppc.product_tmpl_id = ptc.id
    
LEFT JOIN
    product_template pt ON pp.product_tmpl_id = pt.id
LEFT JOIN
    product_category pc ON pt.categ_id = pc.id  -- Nueva relación añadida
LEFT JOIN 
    (
        SELECT 
            pptwtr.product_id,
            STRING_AGG(pptwt.name, ', ') AS name
        FROM 
            pnt_product_tmpl_waste_table_rel pptwtr
        LEFT JOIN 
            pnt_product_tmpl_waste_table pptwt ON pptwtr.pnt_waste_table_id = pptwt.id
        WHERE 
            pptwt.pnt_table_type = 'table2'
        GROUP BY 
            pptwtr.product_id
    ) AS pptwt_t2 ON pt.id = pptwt_t2.product_id
LEFT JOIN 
    (
        SELECT 
            pptwtr.product_id,
            STRING_AGG(pptwt.name, ', ') AS name
        FROM 
            pnt_product_tmpl_waste_table_rel pptwtr
        LEFT JOIN 
            pnt_product_tmpl_waste_table pptwt ON pptwtr.pnt_waste_table_id = pptwt.id
        WHERE 
            pptwt.pnt_table_type = 'table5'
        GROUP BY 
            pptwtr.product_id
    ) AS pptwt_t5 ON pt.id = pptwt_t5.product_id
LEFT JOIN
    pnt_product_tmpl_waste_ler pptwl ON pt.pnt_waste_ler_id = pptwl.id
LEFT JOIN
    pnt_functional_unit pfu ON psdl.pnt_functional_unit_id = pfu.id
LEFT JOIN
    fleet_vehicle fv ON psd.pnt_vehicle_id = fv.id
LEFT JOIN
    pnt_app_tag pat ON psdl.pnt_app_tag_id = pat.id
LEFT JOIN
    pnt_waste_transfer_document pwtd2 ON psdl.pnt_product_waste_id = pwtd2.id
LEFT JOIN
    res_company rc ON psd.company_id = rc.id;