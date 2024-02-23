-- A function with multiple RETURN statements
CREATE OR REPLACE FUNCTION ship_calc2_sf (
    p_qty IN NUMBER
) RETURN NUMBER IS
BEGIN
    IF p_qty > 10 THEN
        RETURN 11.00;
    ELSIF p_qty > 5 THEN
        RETURN 8.00;
    ELSE
        RETURN 5.00;
    END IF;
END;
