*&---------------------------------------------------------------------*
*& Include          ZREP_C8A016_USING_GTT_CLS9
*&---------------------------------------------------------------------*

CLASS lcl_app DEFINITION.

  PUBLIC SECTION.
    METHODS constructor.
    METHODS start_of_sel.
    METHODS end_of_sel.

  PROTECTED SECTION.

  PRIVATE SECTION.
    DATA mo_salv_tab  TYPE REF TO cl_salv_table.
    DATA mt_tab_target TYPE tt_matnr_list.

    METHODS _show_simple.
ENDCLASS.

CLASS lcl_app IMPLEMENTATION.
  METHOD constructor.

  ENDMETHOD.

  METHOD start_of_sel.

    CASE p_mode.
      WHEN '1'. " using_gtt
        NEW lcl_using_gtt( iv_trg_date = p_dt_sel
                           iv_mode = p_mode )->sh( IMPORTING et_matnr_list = mt_tab_target ).
      WHEN '2'. " using union
        NEW lcl_using_union( p_dt_sel )->sh( IMPORTING et_matnr_list = mt_tab_target ).
      WHEN OTHERS.
    ENDCASE.

    _show_simple( ).

  ENDMETHOD.

  METHOD end_of_sel.

  ENDMETHOD.

  METHOD _show_simple.
    TRY.
        cl_salv_table=>factory(
          IMPORTING
            r_salv_table = mo_salv_tab
          CHANGING
            t_table      = mt_tab_target ).
      CATCH cx_salv_msg.                                "#EC NO_HANDLER
    ENDTRY.


    mo_salv_tab->display( ).
  ENDMETHOD.

ENDCLASS.

DATA lo_app TYPE REF TO lcl_app.
