-- Oracle built-in ROUND function
SELECT
    idProduct,
    price,
    ROUND(price, 0)
FROM
    bb_product
WHERE
    idProduct < 4;

-- Oracle built-in functions can also be used in a PL/SQL statement
DECLARE
    v_amt1 NUMBER(5, 2);
    v_amt2 NUMBER(3, 0);
BEGIN
    v_amt1 := 32.50;
    v_amt2 := ROUND(v_amt1, 0);
    DBMS_OUTPUT.PUT_LINE(v_amt2);
END;

-- Creating a function
CREATE OR REPLACE FUNCTION SHIP_CALC_ST (
    P_QTY IN NUMBER
) RETURN NUMBER IS
    lv_ship_num NUMBER := 0;
BEGIN
    IF P_QTY > 10 THEN
        lv_ship_num := 11.00;
    ELSIF P_QTY > 5 THEN
        lv_ship_num := 8.00;
    ELSE
        lv_ship_num := 5.00;
    END IF;

    RETURN lv_ship_num;
END SHIP_CALC_ST;

-- Invoking a function from a PL/SQL block
DECLARE
    lv_cost_num NUMBER(5, 2);
BEGIN
    lv_cost_num := SHIP_CALC_ST(12); -- Corrected function name to match the defined function
    DBMS_OUTPUT.PUT_LINE(lv_cost_num); -- Added semicolon at the end of the line
END;

-- Invoking a function by name
-- Creating a function
CREATE OR REPLACE FUNCTION ship_calc_sf (
    P_QTY IN NUMBER
) RETURN NUMBER IS
    lv_ship_num NUMBER := 0;
BEGIN
    IF P_QTY > 10 THEN
        lv_ship_num := 11.00;
    ELSIF P_QTY > 5 THEN
        lv_ship_num := 8.00;
    ELSE
        lv_ship_num := 5.00;
    END IF;

    RETURN lv_ship_num;
END ship_calc_sf;
/

DECLARE
    lv_result NUMBER(5, 2);
BEGIN
    lv_result := ship_calc_sf(12);
 -- Now you can use lv_result as needed, for example, print it:
    DBMS_OUTPUT.PUT_LINE('Result: '
                         || lv_result);
END;
/

-- Using a function in an SQL statement
SELECT
    idBasket,
    shipping               AS actual,
    ship_calc_sf(quantity) AS calc
FROM
    bb_basket
WHERE
    orderplaced = 1;

-- Using a function in an aggregate query
SELECT
    SUM(shipping)                               AS actual,
    SUM(ship_calc_sf(quantity))                 AS calc,
    SUM(shipping) - SUM(ship_calc_sf(quantity)) AS diff
FROM
    bb_basket
WHERE
    orderplaced = 1;

-- Building and Testing a Function...
CREATE OR REPLACE FUNCTION memfmt1_sf (
    p_id IN NUMBER,
    p_first IN VARCHAR2,
    p_last IN VARCHAR2
) RETURN VARCHAR2 IS
    lv_mem_txt VARCHAR2(35);
BEGIN
    lv_mem_txt := 'Member '
                  ||p_id
                  ||' - '
                  ||p_first
                  ||'
'
                  ||p_last;
    RETURN lv_mem_txt;
END;
/

DECLARE
    v_result VARCHAR2(100);
BEGIN
    v_result := MEMFMT1_SF(123, 'John', 'Doe');
    DBMS_OUTPUT.PUT_LINE('Formatted String: '
                         || v_result);
END;
/
