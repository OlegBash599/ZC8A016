*&---------------------------------------------------------------------*
*& Include          ZREP_C8A016_USING_GTT_CLS2
*&---------------------------------------------------------------------*

CLASS lcl_using_union DEFINITION.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_trg_date TYPE sydatum.

    METHODS sh
      EXPORTING et_matnr_list TYPE tt_matnr_list.

  PROTECTED SECTION.

  PRIVATE SECTION.


    DATA mv_trg_date TYPE sydatum.


ENDCLASS.

CLASS lcl_using_union IMPLEMENTATION.
  METHOD constructor.
    mv_trg_date = iv_trg_date.
  ENDMETHOD.

  METHOD sh.

    CLEAR et_matnr_list.

    SELECT DISTINCT ordi~matnr
        FROM ztc8a016_ordi AS ordi
        JOIN ztc8a016_ordh AS ordh ON ordi~vbeln EQ ordh~vbeln

      WHERE ordh~order_date EQ @mv_trg_date

    UNION

      SELECT DISTINCT invi~matnr
        FROM ztc8a016_invi AS invi
        JOIN ztc8a016_invh AS invh ON invi~inv_num EQ invh~inv_num

      WHERE invh~invoice_date EQ @mv_trg_date

      INTO TABLE @et_matnr_list
      .

  ENDMETHOD.

ENDCLASS.
