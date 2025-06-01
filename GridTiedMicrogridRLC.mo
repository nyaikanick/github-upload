model GridTiedMicrogridRLC
  parameter Real fo = 50 "Grid frequency (Hz)";
  parameter Real Vg_nom = 240 * sqrt(2) "Nominal Grid Voltage (peak)";
  parameter Real Pref = 2000 "Reference Power (W)";
  parameter Real Rline = 0.2 "Line Resistance (Ohm)";
  parameter Real Lline = 0.0005 "Line Inductance (H)";
  parameter Real Lfilter = 0.002 "Filter Inductance (H)";
  parameter Real Cfilter = 10e-6 "Filter Capacitance (F)";

  Modelica.Electrical.Analog.Sources.SineVoltage gridVoltage(V=Vg_nom, freqHz=fo);
  Modelica.Electrical.Analog.Sources.SignalVoltage inverterOutput;
  Modelica.Electrical.Analog.Basic.Ground ground;

  Modelica.Electrical.Analog.Basic.Resistor R1(R=Rline);
  Modelica.Electrical.Analog.Basic.Inductor L1(L=Lline);
  Modelica.Electrical.Analog.Basic.Inductor Lf(L=Lfilter);
  Modelica.Electrical.Analog.Basic.Capacitor Cf(C=Cfilter);

  input Real Vinv;
  output Real Vload = Cf.v;
  output Real IL = Lf.i;

equation
  connect(gridVoltage.p, R1.p);
  connect(R1.n, L1.p);
  connect(L1.n, Cf.p);
  connect(Cf.n, ground.p);
  connect(gridVoltage.n, ground.p);

  connect(inverterOutput.p, Lf.p);
  connect(Lf.n, Cf.p);
  connect(inverterOutput.n, ground.p);

  inverterOutput.v = Vinv;
end GridTiedMicrogridRLC;
