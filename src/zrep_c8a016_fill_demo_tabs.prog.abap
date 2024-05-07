*&---------------------------------------------------------------------*
*& Report ZREP_C8A016_FILL_DEMO_TABS
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrep_c8a016_fill_demo_tabs.

INCLUDE zrep_c8a016_fill_tabs_scrn IF FOUND. " selection screen
INCLUDE zrep_c8a016_fill_tabs_cls1 IF FOUND. " lcl_fill_demo_data

INITIALIZATION.
  lo_fill_demo_sd = NEW #( ).

START-OF-SELECTION.
  lo_fill_demo_sd->start_of_sel( ).

end-of-SELECTION.
  lo_fill_demo_sd->end_of_sel( ).
