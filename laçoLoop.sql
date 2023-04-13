SET SERVEROUTPUT ON;

DECLARE

    v_cpf number := 0;
    v_dig number := 0;
    v_indi number := 1;
    v_multi number := 10;
    v_soma number := 0;


    CURSOR c_cadastro is
        SELECT
            *
        FROM
            ne_cadastro
        WHERE
            CODIGO = 3;

    r_cadastro c_cadastro%ROWTYPE;
-- v_indi := v_indi > 9
begin
    OPEN c_cadastro;
        LOOP
            FETCH c_cadastro into r_cadastro;
                exit when c_cadastro%NOTFOUND;
            for v_indi in 1..9 loop
                v_cpf:= substr(r_cadastro.cpf, v_indi, 1) * v_multi;
                DBMS_OUTPUT.PUT_LINE(v_indi || '-' || v_multi || '-' || v_cpf);
                v_soma := v_soma + v_cpf;
                v_multi := v_multi -1;
            end loop;
            DBMS_OUTPUT.PUT_LINE('Valor total da soma : ' || v_soma); 

            v_soma := MOD(v_soma, 11);

            DBMS_OUTPUT.PUT_LINE('Valor do resto da soma : ' || v_soma);
            
            if v_soma < 2
                then
                    v_soma := 0;
                    DBMS_OUTPUT.PUT_LINE('Valor caso seja menor que 2 = ' || v_soma);
            else
                v_soma := 11 - v_soma;
                DBMS_OUTPUT.PUT_LINE('Valor caso seja maior que 2 = ' || v_soma);
            end if;

            update ne_cadastro
            SET DIG = v_soma
            WHERE CODIGO = 2;

            -- Adicionando o 2 digito do CPF
            v_cpf := 0;
            v_dig := 0;
            v_indi := 0;
            v_multi := 11;
            v_soma := 0;

            for v_indi in 1..10 loop
              v_cpf := substr(r_cadastro.cpf, v_indi, 1) * v_multi;
              DBMS_OUTPUT.PUT_LINE(v_indi || '-' || v_multi || '-' || v_cpf);
              v_soma := v_soma + v_cpf;
              v_multi := v_multi -1;
            end loop;
            DBMS_OUTPUT.PUT_LINE(' Valor total da Soma : ' || v_soma);

            v_soma := MOD(v_soma, 11);

            DBMS_OUTPUT.PUT_LINE('Valor do resto : ' || v_soma);

            if v_soma < 2
                then
                    v_soma := 0;
                    DBMS_OUTPUT.PUT_LINE('Valor caso seja menor que 2 = ' || v_soma);
            else
                v_soma := 11 - v_soma;
                DBMS_OUTPUT.PUT_LINE('Valor caso seja maior que 2 = ' || v_soma);
            end if;

            update ne_cadastro
            SET DIG = DIG || v_soma
            WHERE CODIGO = 2;

        END LOOP;
    close c_cadastro;

exception
        when OTHERS then 
            DBMS_OUTPUT.PUT_LINE('Um erro ocorreu');
end;
