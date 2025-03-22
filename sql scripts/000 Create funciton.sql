-- Tell the program which database to use to ensure to correct one is being worked on
USE Payroll;

DELIMITER //

DROP FUNCTION IF EXISTS caesar_encrypt//
DROP FUNCTION IF EXISTS caesar_decrypt//

CREATE FUNCTION caesar_encrypt(
    input_text VARCHAR(255),
    shift_amount INT
)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result VARCHAR(255) DEFAULT '';
    DECLARE current_char CHAR;
    DECLARE ascii_val INT;
    
    -- Convert shift to be within 0-25 range
    SET shift_amount = MOD(shift_amount + 26, 26);
    
    WHILE i <= LENGTH(input_text) DO
        SET current_char = UPPER(SUBSTRING(input_text, i, 1));
        SET ascii_val = ASCII(current_char);
        
        -- Only shift alphabetic characters
        IF ascii_val >= 65 AND ascii_val <= 90 THEN
            -- Apply shift and wrap around if necessary
            SET ascii_val = ascii_val + shift_amount;
            IF ascii_val > 90 THEN
                SET ascii_val = ascii_val - 26;
            END IF;
            SET result = CONCAT(result, CHAR(ascii_val));
        ELSE
            -- Keep non-alphabetic characters as is
            SET result = CONCAT(result, current_char);
        END IF;
        
        SET i = i + 1;
    END WHILE;
    
    RETURN result;
END//

CREATE FUNCTION caesar_decrypt(
    input_text VARCHAR(255),
    shift_amount INT
)
RETURNS VARCHAR(255)
DETERMINISTIC
BEGIN
    DECLARE i INT DEFAULT 1;
    DECLARE result VARCHAR(255) DEFAULT '';
    DECLARE current_char CHAR;
    DECLARE ascii_val INT;
    
    -- Convert shift to be within 0-25 range and negate it for decryption
    SET shift_amount = MOD((-shift_amount + 26), 26);
    
    WHILE i <= LENGTH(input_text) DO
        SET current_char = UPPER(SUBSTRING(input_text, i, 1));
        SET ascii_val = ASCII(current_char);
        
        -- Only shift alphabetic characters
        IF ascii_val >= 65 AND ascii_val <= 90 THEN
            -- Apply shift and wrap around if necessary
            SET ascii_val = ascii_val + shift_amount;
            IF ascii_val > 90 THEN
                SET ascii_val = ascii_val - 26;
            END IF;
            SET result = CONCAT(result, CHAR(ascii_val));
        ELSE
            -- Keep non-alphabetic characters as is
            SET result = CONCAT(result, current_char);
        END IF;
        
        SET i = i + 1;
    END WHILE;
    
    RETURN result;
END//

DELIMITER ;
