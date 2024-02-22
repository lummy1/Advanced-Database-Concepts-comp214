CREATE OR REPLACE PROCEDURE phone_fmt_sp
   (p_phone IN OUT VARCHAR2)
  IS
BEGIN
  p_phone := '(' || SUBSTR(p_phone,1,3) || ')' ||
                    SUBSTR(p_phone,4,3) || '-' ||
                    SUBSTR(p_phone,7,4);
END;
/

DECLARE
  v_phone_number VARCHAR2(20);
BEGIN
  v_phone_number := '1234567890'; -- Input phone number without formatting
  phone_fmt_sp(v_phone_number);   -- Call the procedure to format the phone number
  DBMS_OUTPUT.PUT_LINE('Formatted phone number: ' || v_phone_number);
END;
/
