*&---------------------------------------------------------------------*
*& Report ZREP_C8A016_USING_GTT
*&---------------------------------------------------------------------*
*&
*&---------------------------------------------------------------------*
REPORT zrep_c8a016_using_gtt.


INCLUDE zrep_c8a016_using_gtt_data IF FOUND.
INCLUDE zrep_c8a016_using_gtt_srcn IF FOUND.
INCLUDE zrep_c8a016_using_gtt_cls1 IF FOUND. " using gtt
INCLUDE zrep_c8a016_using_gtt_cls2 IF FOUND. " using union
INCLUDE zrep_c8a016_using_gtt_cls9 IF FOUND. " app overall

INITIALIZATION.
  lo_app = NEW #( ).

START-OF-SELECTION.
  lo_app->start_of_sel( ).

end-of-SELECTION.
  lo_app->end_of_sel( ).
