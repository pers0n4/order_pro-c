CREATE OR REPLACE PROCEDURE drop_sequence_if_exists(
    table_name IN VARCHAR2
) IS
BEGIN
    EXECUTE IMMEDIATE 'DROP TABLE ' || table_name || ' CASCADE CONSTRAINTS PURGE';
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -942 THEN
            RAISE;
        END IF;
END;

CREATE OR REPLACE PROCEDURE drop_table_if_exists(
    sequence_name IN VARCHAR2
) IS
BEGIN
    EXECUTE IMMEDIATE 'DROP SEQUENCE ' || sequence_name;
EXCEPTION
    WHEN OTHERS THEN
        IF SQLCODE != -2289 THEN
            RAISE;
        END IF;
END;
