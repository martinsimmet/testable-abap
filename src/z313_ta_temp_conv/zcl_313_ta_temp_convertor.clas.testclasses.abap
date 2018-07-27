*"* use this source file for your ABAP unit test classes
class ltc_boundary_value_analysis definition
  for testing
  risk level harmless "unit test execution does no harm to the system
  duration short. "unit test execution does not put load on the system

  private section.
    types:
      begin of df16_line_t,
        kelvin    type decfloat16,
        celsius   type decfloat16,
        farenheit type decfloat16,
      end of df16_line_t,
      df16_tab_t type standard table of df16_line_t with default key.

    "Data for test cases
    data m_data_valid type df16_tab_t.
    data m_data_invalid type df16_tab_t.

    " CUT: Code Under Test
    data m_cut type ref to zcl_313_ta_temp_convertor.

    " 'Infrastructure' methods called by ABAP Unit framework
    methods setup.  "called before each "for testing" method

    " Test Methods called from ABAP Unit framework
    methods kelvin for testing.
    methods celsius for testing.
    methods farenheit for testing.

    " methods that help structuring and organizing code
    methods kelvin_valid importing i_data_tab type df16_tab_t.
    methods kelvin_invalid importing i_data_tab type df16_tab_t.
    methods celsius_valid importing i_data_tab type df16_tab_t.
    methods celsius_invalid importing i_data_tab type df16_tab_t.
    methods farenheit_valid importing i_data_tab type df16_tab_t.
    methods farenheit_invalid importing i_data_tab type df16_tab_t.

endclass.

class ltc_boundary_value_analysis implementation.

  method setup.
    m_cut = new zcl_313_ta_temp_convertor( ).

    m_data_valid = value df16_tab_t(
      "Test cases 1, 5, 11
      ( kelvin = '0'
        celsius = '-273.15'
        farenheit = '-459.67' )
      "Test cases 2, 8, 14
      ( kelvin = '16000000'
        celsius = '15999726.85'
        farenheit = '28799540.33' )
      "Test case 6
      ( kelvin = '273.14'
        celsius = '-0.01'
        farenheit = '31.98' )
      "Test case 7
      ( kelvin = '273.15'
        celsius = '0'
        farenheit = '32' )
      "Test case 12
      ( kelvin = '255.37'
        celsius = '-17.78'
        farenheit = '-0.01' )
      "Test case 13
      ( kelvin = '255.37'
        celsius = '-17.78'
        farenheit = '0' )
    ).

    m_data_invalid = value df16_tab_t(
      "Test cases 3, 9, 15
      ( kelvin = '-0.01'
        celsius = '-273.16'
        farenheit = '-459.68' )
      "Test cases 4, 10, 16
      ( kelvin = '16000000.01'
        celsius = '15999726.86'
        farenheit = '28799540.34' )
    ).

  endmethod.

  method kelvin_invalid.
    loop at i_data_tab assigning field-symbol(<data>).
      "k2c
      try.
          m_cut->kelvin2celsius( <data>-kelvin ).
        catch cx_invalid_argument into data(cx_k2c).
          ##no_handler
      endtry.
      cl_abap_unit_assert=>assert_bound( cx_k2c ).
      "k2f
      try.
          m_cut->kelvin2fahrenheit( <data>-kelvin ).
        catch cx_invalid_argument into data(cx_k2f).
          ##no_handler
      endtry.
      cl_abap_unit_assert=>assert_bound( cx_k2f ).
    endloop.
  endmethod.

  method kelvin_valid.
    loop at i_data_tab assigning field-symbol(<data>).
      "k2c
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-celsius
        act = m_cut->kelvin2celsius( <data>-kelvin )
        msg = |Kelvin ({ <data>-kelvin }) Celsius ({ <data>-celsius })| ).
      "k2f
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-farenheit
        act = m_cut->kelvin2fahrenheit( <data>-kelvin ) ).
    endloop.
  endmethod.

  method celsius_invalid.
    loop at i_data_tab assigning field-symbol(<data>).
      "c2k
      try.
          m_cut->celsius2kelvin( <data>-celsius ).
        catch cx_invalid_argument into data(cx_c2k).
          ##no_handler
      endtry.
      cl_abap_unit_assert=>assert_bound( cx_c2k ).
      "c2f
      try.
          m_cut->celsius2fahrenheit( <data>-celsius ).
        catch cx_invalid_argument into data(cx_c2f).
          ##no_handler
      endtry.
      cl_abap_unit_assert=>assert_bound( cx_c2f ).
    endloop.
  endmethod.

  method celsius_valid.
    loop at i_data_tab assigning field-symbol(<data>).
      "c2k
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-kelvin
        act = m_cut->celsius2kelvin( <data>-celsius )
        msg = |Celsius ({ <data>-celsius }) Kelvin ({ <data>-kelvin })| ).
      "c2f
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-farenheit
        act = m_cut->celsius2fahrenheit( <data>-celsius )
        msg = |Celsius({ <data>-celsius }) Fahrenheit({ <data>-farenheit })| ).
    endloop.
  endmethod.

  method farenheit_invalid.
    loop at i_data_tab assigning field-symbol(<data>).
      "f2k
      try.
          m_cut->fahrenheit2kelvin( <data>-farenheit ).
        catch cx_invalid_argument into data(cx_f2k).
          ##no_handler
      endtry.
      cl_abap_unit_assert=>assert_bound( cx_f2k ).
      "f2c
      try.
          m_cut->fahrenheit2celsius( <data>-farenheit ).
        catch cx_invalid_argument into data(cx_f2c).
          ##no_handler
      endtry.
      cl_abap_unit_assert=>assert_bound( cx_f2c ).
    endloop.
  endmethod.

  method farenheit_valid.
    loop at i_data_tab assigning field-symbol(<data>).
      "f2k
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-kelvin
        act = m_cut->fahrenheit2kelvin( <data>-farenheit )
        msg = |Farenheit ({ <data>-farenheit }) Kelvin ({ <data>-kelvin })| ).
      "f2c
      cl_abap_unit_assert=>assert_equals(
        exp = <data>-celsius
        act = m_cut->fahrenheit2celsius( <data>-farenheit )
        msg = |Fahrenheit({ <data>-farenheit }) Celsius({ <data>-celsius })| ).
    endloop.
  endmethod.

  method kelvin.
    me->kelvin_valid( m_data_valid ).
    me->kelvin_invalid( m_data_invalid ).
  endmethod.

  method celsius.
    me->celsius_valid( m_data_valid ).
    me->celsius_invalid( m_data_invalid ).
  endmethod.

  method farenheit.
    me->farenheit_valid( m_data_valid ).
    me->farenheit_invalid( m_data_invalid ).
  endmethod.

endclass.
