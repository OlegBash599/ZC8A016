*&---------------------------------------------------------------------*
*& Include          ZREP_C8A016_USING_GTT_CLS1
*&---------------------------------------------------------------------*

CLASS lcl_using_gtt DEFINITION.

  PUBLIC SECTION.
    METHODS constructor
      IMPORTING iv_trg_date TYPE sydatum
                iv_mode     TYPE char1.
    METHODS sh
      EXPORTING et_matnr_list TYPE tt_matnr_list.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA mv_trg_date TYPE sydatum.
    DATA mv_mode TYPE char1.

    METHODS _fill_gtt_from_order.
    METHODS _fill_gtt_from_invoice.

ENDCLASS.

CLASS lcl_using_gtt IMPLEMENTATION.
  METHOD constructor.
    mv_trg_date = iv_trg_date.
    mv_mode = iv_mode.
  ENDMETHOD.

  METHOD sh.

    _fill_gtt_from_order( ).

    _fill_gtt_from_invoice( ).

    """"""""" read
    " допускается "почти" любой AbapSQL
    SELECT DISTINCT matnr
        FROM ztc8a016_mat_tmp
      ORDER BY matnr DESCENDING
      INTO TABLE @et_matnr_list
      UP TO 3 ROWS.

    IF mv_mode EQ '3'.
      " из-за неудаленных данных - будетм RunTime Error (aka красный Dump)
      " неявный коммит
      MESSAGE i000(cl) WITH 'Runtime Error goes here'.
    ENDIF.

    """"""""" delete - MUST EXIST
    DELETE FROM ztc8a016_mat_tmp.

    MESSAGE i000(cl) WITH 'Почистили GTT в сессии'.

  ENDMETHOD.

  METHOD _fill_gtt_from_order.
    INSERT ztc8a016_mat_tmp FROM
     (
     SELECT DISTINCT
      'O' AS src_type,
       ordi~matnr AS matnr
        FROM ztc8a016_ordi AS ordi
        JOIN ztc8a016_ordh AS ordh ON ordi~vbeln EQ ordh~vbeln
      WHERE ordh~order_date EQ @mv_trg_date
     ).
  ENDMETHOD.

  METHOD _fill_gtt_from_invoice.
    INSERT ztc8a016_mat_tmp FROM
     (
        SELECT DISTINCT
          'I' AS src_type,
          invi~matnr AS matnr
        FROM ztc8a016_invi AS invi
        JOIN ztc8a016_invh AS invh ON invi~inv_num EQ invh~inv_num
      WHERE invh~invoice_date EQ @mv_trg_date
     ).
  ENDMETHOD.

ENDCLASS.
