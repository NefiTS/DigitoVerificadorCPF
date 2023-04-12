SET SERVEROUTPUT ON;

-- Declarando as variaveis
DECLARE
    vCpf1 number(10) := 0;
    vCpf2 number(10) := 0;
    vCpf3 number(10) := 0;
    vCpf4 number(10) := 0;
    vCpf5 number(10) := 0;
    vCpf6 number(10) := 0;
    vCpf7 number(10) := 0;
    vCpf8 number(10) := 0;
    vCpf9 number(10) := 0;
    
    vCpff1 number(10) := 0;
    vCpff2 number(10) := 0;
    vCpff3 number(10) := 0;
    vCpff4 number(10) := 0;
    vCpff5 number(10) := 0;
    vCpff6 number(10) := 0;
    vCpff7 number(10) := 0;
    vCpff8 number(10) := 0;
    vCpff9 number(10) := 0;
    vCpff10 number(10) := 0;
    
    
    vDig1 number(10) := 0;
    vDig2 number(10) := 0;
    vDigs number(10) := 0;
    
    CURSOR c_cadastro IS
        SELECT
            *
        FROM
            ne_cadastro
        WHERE
            CODIGO = 3;
            
        r_cadastro c_cadastro%ROWTYPE;
-- Iniciando o codigo 
BEGIN
    OPEN c_cadastro;
        LOOP
            FETCH c_cadastro INTO r_cadastro;
                EXIT WHEN c_cadastro%NOTFOUND;
            vCpf1 := substr(r_cadastro.cpf,1,1) * 10;
            vCpf2 := substr(r_cadastro.cpf,2,1) * 9;
            vCpf3 := substr(r_cadastro.cpf,3,1) * 8;
            vCpf4 := substr(r_cadastro.cpf,4,1) * 7;
            vCpf5 := substr(r_cadastro.cpf,5,1) * 6;
            vCpf6 := substr(r_cadastro.cpf,6,1) * 5;
            vCpf7 := substr(r_cadastro.cpf,7,1) * 4;
            vCpf8 := substr(r_cadastro.cpf,8,1) * 3;
            vCpf9 := substr(r_cadastro.cpf,9,1) * 2;
            
            vDig1 := (vCpf1 + vCpf2 + vCpf3 + vCpf4 + vCpf5 + vCpf6 + vCpf7 + vCpf8 + vCpf9);
            
            DBMS_OUTPUT.PUT_LINE('Resultado da soma : ' || vDig1);
            
            
            vDig1 := MOD(vDig1, 11);
            
            
            DBMS_OUTPUT.PUT_LINE('Resultado do resto : ' || vDig1);
            
            IF vDig1 < 2
                THEN vDig1 := 0;
            ELSE
                vDig1 := 11 - vDig1;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('Resultado Final do Digito 1 : ' || vDig1);
            
            UPDATE ne_cadastro
            SET  DIG = vDig1
            WHERE CODIGO = 3;
            
            vCpff1 := substr(r_cadastro.cpf,1,1) * 11;
            vCpff2 := substr(r_cadastro.cpf,2,1) * 10;
            vCpff3 := substr(r_cadastro.cpf,3,1) * 9;
            vCpff4 := substr(r_cadastro.cpf,4,1) * 8;
            vCpff5 := substr(r_cadastro.cpf,5,1) * 7;
            vCpff6 := substr(r_cadastro.cpf,6,1) * 6;
            vCpff7 := substr(r_cadastro.cpf,7,1) * 5;
            vCpff8 := substr(r_cadastro.cpf,8,1) * 4;
            vCpff9 := substr(r_cadastro.cpf,9,1) * 3;
            vCpff10 := substr(r_cadastro.cpf,10,1) * 2;
            vDig2 := (vCpff1 + vCpff2 + vCpff3 + vCpff4 + vCpff5 + vCpff6 + vCpff7 + vCpff8 + vCpff9 + vCpff10);
            
            DBMS_OUTPUT.PUT_LINE('Resultado da soma : ' || vDig2);
            
            
            vDig2 := MOD(vDig2, 11);
            
            
            DBMS_OUTPUT.PUT_LINE('Resultado do resto : ' || vDig2);
            
            IF vDig2 < 2
                THEN vDig2 := 0;
            ELSE
                vDig2 := 11 - vDig2;
            END IF;
            
            DBMS_OUTPUT.PUT_LINE('Resultado Final do Digito 2 : ' || vDig2);
            
            vDigs := vDig1 || vDig2;
            
            UPDATE ne_cadastro
            SET  DIG = vDig2
            WHERE CODIGO = 3;
            
            DBMS_OUTPUT.PUT_LINE('Resultado Final do Digito 1 : ' || vDigs);
            
            
            
        END LOOP;
    CLOSE c_cadastro;
-- Código finalizado
END;