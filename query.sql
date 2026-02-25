SELECT 
    p.id,
    p.name_product,
    pv.variant_name,
    ps.size_name,
    (p.base_price + pv.add_price + ps.add_price) AS final_price
FROM products p

-- ambil 1 variant random per product
JOIN LATERAL (
    SELECT variant_name, add_price
    FROM product_variants
    WHERE product_id = p.id
    ORDER BY RANDOM()
    LIMIT 1
) pv ON true

-- ambil 1 size random per product
JOIN LATERAL (
    SELECT size_name, add_price
    FROM product_sizes
    WHERE product_id = p.id
    ORDER BY RANDOM()
    LIMIT 1
) ps ON true

ORDER BY RANDOM()
LIMIT 1;