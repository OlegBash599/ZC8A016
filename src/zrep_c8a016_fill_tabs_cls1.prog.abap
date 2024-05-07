*&---------------------------------------------------------------------*
*& Include          ZREP_C8A016_FILL_TABS_CLS1
*&---------------------------------------------------------------------*

CLASS lcl_fill_demo_data DEFINITION.

  PUBLIC SECTION.
    METHODS constructor.
    METHODS start_of_sel.
    METHODS end_of_sel.

  PRIVATE SECTION.
    METHODS _fill_orders.
    METHODS _fill_invoices.

    METHODS _empty_tables.

ENDCLASS.


CLASS lcl_fill_demo_data IMPLEMENTATION.

  METHOD constructor.

  ENDMETHOD.

  METHOD start_of_sel.

    IF p_mode EQ 'F'.
      _empty_tables( ).
    ENDIF.

    _fill_orders( ).
    _fill_invoices( ).

    COMMIT WORK AND WAIT.

    MESSAGE s000(cl) WITH 'Data filled..'.

  ENDMETHOD.

  METHOD end_of_sel.

  ENDMETHOD.

  METHOD _fill_orders.

    DATA lt_ordh TYPE STANDARD TABLE OF ztc8a016_ordh WITH DEFAULT KEY.
    DATA ls_ordh TYPE ztc8a016_ordh.

    DATA lt_ordi TYPE STANDARD TABLE OF ztc8a016_ordi WITH DEFAULT KEY.
    DATA ls_ordi TYPE ztc8a016_ordi.


    DO 10000 TIMES.

      ls_ordh-mandt = sy-mandt.
      ls_ordh-vbeln = 1020304000 + sy-index.

      ls_ordh-customer = |CUST{ 2500 + sy-index MOD 17 }|.
      CONDENSE ls_ordh-customer NO-GAPS.

      ls_ordh-order_date = sy-datum - ( sy-index MOD 59 ).
      ls_ordh-crdt = sy-datum.

      DO 4 TIMES.
        ls_ordi-mandt = ls_ordh-mandt.
        ls_ordi-vbeln = ls_ordh-vbeln.
        ls_ordi-posnr = sy-index.
        ls_ordi-matnr = |DEMO_MATNR_{ sy-index }|.
        APPEND ls_ordi TO lt_ordi.
      ENDDO.

      APPEND ls_ordh TO lt_ordh.

    ENDDO.

    MODIFY ztc8a016_ordh FROM TABLE lt_ordh.
    MODIFY ztc8a016_ordi FROM TABLE lt_ordi.

  ENDMETHOD.

  METHOD _fill_invoices.

    DATA lt_invh TYPE STANDARD TABLE OF ztc8a016_invh WITH DEFAULT KEY.
    DATA ls_invh TYPE ztc8a016_invh.

    DATA lt_invi TYPE STANDARD TABLE OF ztc8a016_invi WITH DEFAULT KEY.
    DATA ls_invi TYPE ztc8a016_invi.


    DO 9000 TIMES.

      ls_invh-mandt = sy-mandt.
      ls_invh-inv_num = 5550607000 + sy-index.

      ls_invh-payer = |PAYER{ 2500 + sy-index MOD 17 }|.
      CONDENSE ls_invh-payer NO-GAPS.

      ls_invh-invoice_date = sy-datum - ( sy-index MOD 91 ).
      ls_invh-crdt = sy-datum.

      DO 4 TIMES.
        ls_invi-mandt     = ls_invh-mandt.
        ls_invi-inv_num   = ls_invh-inv_num.
        ls_invi-inv_posnr = sy-index.
        ls_invi-matnr     = |DEMO_MATNR_{ sy-index + 2 }|.
        APPEND ls_invi TO lt_invi.
      ENDDO.

      APPEND ls_invh TO lt_invh.

    ENDDO.

    MODIFY ztc8a016_invh FROM TABLE lt_invh.
    MODIFY ztc8a016_invi FROM TABLE lt_invi.

  ENDMETHOD.

  METHOD _empty_tables.
    DELETE FROM ztc8a016_ordh.
    DELETE FROM ztc8a016_ordi .

    DELETE FROM ztc8a016_invh .
    DELETE FROM ztc8a016_invi .

    COMMIT WORK AND WAIT.

  ENDMETHOD.

ENDCLASS.

DATA lo_fill_demo_sd TYPE REF TO lcl_fill_demo_data.
