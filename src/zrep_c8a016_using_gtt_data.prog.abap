*&---------------------------------------------------------------------*
*& Include          ZREP_C8A016_USING_GTT_DATA
*&---------------------------------------------------------------------*

    TYPES: tv_matnr TYPE char40.

    TYPES: BEGIN OF ts_matnr_list
            , matnr TYPE tv_matnr
          , END OF ts_matnr_list
          , tt_matnr_list TYPE STANDARD TABLE OF ts_matnr_list WITH DEFAULT KEY
          .
