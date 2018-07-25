class zcl_313_ta_temp_convertor definition
  public
  create public .

  public section.
    interfaces: zif_313_ta_temp_convertor.
  protected section.
  private section.

endclass.



class zcl_313_ta_temp_convertor implementation.

  method zif_313_ta_temp_convertor~celsius2fahrenheit.

  endmethod.

  method zif_313_ta_temp_convertor~celsius2kelvin.

  endmethod.

  method zif_313_ta_temp_convertor~fahrenheit2celsius.

  endmethod.

  method zif_313_ta_temp_convertor~fahrenheit2kelvin.

  endmethod.

  method zif_313_ta_temp_convertor~kelvin2celsius.

  endmethod.

  method zif_313_ta_temp_convertor~kelvin2fahrenheit.

  endmethod.

endclass.
