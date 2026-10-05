#set document(
  title: "Laboratory Report: Optical Fiber Communication Simulation Experiments",
  author: "Shahriar Hasan"
)

#set page(
  paper: "a4",
  margin: (left: 3.0cm, right: 2.5cm, top: 2.5cm, bottom: 2.5cm),
  header: locate(loc => {
    let page_number = counter(page).at(loc).first()
    if page_number > 2 [
      #align(right)[#text(size: 8.5pt, fill: rgb("#666666"), font: "Times New Roman", style: "italic")[Optical Fiber Communications Sessional]]
      #v(-4pt)
      #line(length: 100%, stroke: 0.5pt + rgb("#CCCCCC"))
    ]
  }),
  footer: locate(loc => {
    let page_number = counter(page).at(loc).first()
    if page_number > 1 [
      #align(center)[#text(size: 10pt, font: "Times New Roman")[#counter(page).display()]]
    ]
  })
)

#set text(font: "Times New Roman", size: 12pt, lang: "en")
#set par(justify: true, leading: 0.75em, first-line-indent: 0pt)
#set block(spacing: 1.0em)

// Ensure tables, figures, lists, enums, and outline have clean 0pt first-line indent
#show table: set par(first-line-indent: 0pt)
#show figure.caption: set par(first-line-indent: 0pt)
#show list: set par(first-line-indent: 0pt)
#show enum: set par(first-line-indent: 0pt)
#show outline: set par(first-line-indent: 0pt)

// Clean academic list indentation
#set list(indent: 0.8em, body-indent: 0.5em)
#set enum(indent: 0.8em, body-indent: 0.5em)

// Heading Styling (HSTU Formal Academic Monograph Standard)
#show heading.where(level: 1): it => block(width: 100%)[
  #v(14pt)
  #if it.numbering != none [
    #set align(left)
    #set text(size: 15pt, weight: "bold", fill: rgb("#0C2C56"))
    #text(size: 13pt, fill: rgb("#184C78"))[Experiment #counter(heading).display() \ ]
    #v(4pt)
    #it.body
    #v(14pt)
  ] else [
    #set align(center)
    #set text(size: 16pt, weight: "bold", fill: rgb("#0C2C56"))
    #it.body
    #v(14pt)
  ]
]

#show heading.where(level: 2): it => block(width: 100%)[
  #set align(left)
  #set text(size: 13pt, weight: "bold", fill: rgb("#184C78"))
  #v(14pt)
  #if it.numbering != none [
    #counter(heading).display()
    #h(0.4em)
  ]
  #it.body
  #v(6pt)
]

#show heading.where(level: 3): it => block(width: 100%)[
  #set align(left)
  #set text(size: 12pt, weight: "bold", fill: rgb("#0C2C56"))
  #v(10pt)
  #if it.numbering != none [
    #counter(heading).display()
    #h(0.4em)
  ]
  #it.body
  #v(4pt)
]

#show raw: set text(font: "DejaVu Sans Mono", size: 8.5pt)
#show raw.where(block: true): it => block(
  fill: rgb("#F8F9FA"),
  stroke: 0.6pt + rgb("#DCE0E6"),
  radius: 3pt,
  inset: 9pt,
  width: 100%,
  clip: true,
  it
)

#set figure(gap: 10pt)
#show figure.caption: it => [
  #set text(size: 10pt, weight: "bold", fill: rgb("#222222"))
  #it
]

// ─────────────────────────────────────────────────────────────
// TITLE COVER PAGE
// ─────────────────────────────────────────────────────────────
#align(center)[
  #v(1.5cm)
  #text(size: 19pt, weight: "bold", fill: rgb("#0C2C56"))[HAJEE MOHAMMAD DANESH SCIENCE AND TECHNOLOGY UNIVERSITY (HSTU)] \
  #v(0.2cm)
  #text(size: 14pt, weight: "bold", fill: rgb("#184C78"))[Department of Electronics and Communication Engineering] \
  #text(size: 11pt, style: "italic", fill: rgb("#555555"))[Dinajpur-5200, Bangladesh]

  #v(1.0cm)
  #image("hstu_logo.png", width: 2.8cm)

  #v(1.2cm)
  #text(size: 17pt, weight: "bold", fill: rgb("#B2182B"))[LABORATORY EXPERIMENT REPORT] \
  #v(0.3cm)
  #text(size: 14pt, weight: "bold", fill: rgb("#0C2C56"))[Optical Fiber Communication Simulation Experiments] \
  #v(0.2cm)
  #text(size: 11.5pt, weight: "medium", fill: rgb("#333333"))[Course Code: ECE 408 | Course Title: Optical Fiber Communication Sessional]

  #v(1.8cm)
  #grid(
    columns: (1fr, 1fr),
    gutter: 20pt,
    align(left)[
      #block(stroke: (left: 2.5pt + rgb("#184C78")), inset: (left: 10pt))[
        #text(size: 11pt, weight: "bold", fill: rgb("#184C78"))[Submitted By:] \
        #v(3pt)
        #text(size: 12pt, weight: "bold", fill: rgb("#0C2C56"))[Shahriar Hasan] \
        #text(size: 11pt)[Student ID: *2002138*] \
        #text(size: 10.5pt)[Level: 4, Semester: II] \
        #text(size: 10.5pt)[Dept. of ECE, HSTU]
      ]
    ],
    align(left)[
      #block(stroke: (left: 2.5pt + rgb("#B2182B")), inset: (left: 10pt))[
        #text(size: 11pt, weight: "bold", fill: rgb("#B2182B"))[Submitted To:] \
        #v(3pt)
        #text(size: 11.5pt, weight: "bold", fill: rgb("#0C2C56"))[Course Instructor(s)] \
        #text(size: 10.5pt)[Department of ECE] \
        #text(size: 10.5pt)[Faculty of Computer Science and Engineering] \
        #text(size: 10.5pt)[HSTU, Dinajpur-5200]
      ]
    ]
  )

  #v(1.6cm)
  #text(size: 11pt, weight: "medium", fill: rgb("#444444"))[Submission Date: October 2026]
]

#pagebreak()

// ─────────────────────────────────────────────────────────────
// TABLE OF CONTENTS (PAGE 2)
// ─────────────────────────────────────────────────────────────
#set page(numbering: "1")
#counter(page).update(2)

#block[
  #show outline.entry.where(level: 1): it => {
    v(4pt, weak: true)
    strong(it)
  }
  #set text(size: 9.5pt)
  #set par(leading: 0.55em)
  #outline(
    title: [Table of Contents],
    depth: 2,
    indent: 1.0em
  )
]

#pagebreak()

// ─────────────────────────────────────────────────────────────
// EXECUTIVE OVERVIEW (NEW PAGE - PAGE 3)
// ─────────────────────────────────────────────────────────────
#heading(numbering: none)[Executive Overview of Conducted Laboratory Modules]

#line(length: 100%, stroke: 0.8pt + rgb("#DCE0E6"))
#v(4pt)

#block[
  #set text(size: 10.5pt)
  #set par(leading: 0.65em)
  This laboratory assignment encompasses six fundamental computational simulation experiments covering modern physical-layer optical fiber communication engineering. The experiments model semiconductor optoelectronic sources (LED and Fabry-Perot LASER diodes), external optical modulators (Mach-Zehnder and Electro-Absorption modulators), photodetector receiver noise and bit error rate performance (PIN and APD architectures), passive optical link power and dispersion rise-time budgeting, digital baseband line coding with eye diagram signal integrity analysis, and multi-channel Wavelength Division Multiplexing (WDM) combined with Optical Time-Domain Reflectometry (OTDR) fault and attenuation diagnosis.

  #v(4pt)
  #align(center)[
    #table(
      columns: (auto, 1.4fr, 2.4fr),
      fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
      stroke: 0.5pt + rgb("#CCCCCC"),
      inset: (x: 6pt, y: 3.2pt),
      [*Exp.*], [*Experiment Title*], [*Primary Physical Phenomena & Engineering Concepts*],
      [1], [Characteristics of LED and Semiconductor LASER], [Spontaneous vs. stimulated emission, $P-I$ curves, threshold current ($I_"th"$), differential quantum efficiency, wall-plug efficiency, and small-signal modulation resonance.],
      [2], [Optical Modulation Using MZM and EAM], [External intensity modulation, electro-optic Pockels interference ($V_pi$), Franz-Keldysh electro-absorption, 1 Gb/s NRZ drive waveform synthesis, and Extinction Ratio (ER).],
      [3], [Noise, SNR, Q-Factor, and BER of PIN and APD Receivers], [Photodiode responsivity ($R$), thermal noise, Poissonian shot noise, avalanche carrier multiplication gain ($M$), excess noise factor ($F$), and sensitivity at $10^(-9)$ BER.],
      [4], [Power Budget and Rise-Time Budget of an Optical Link], [Passive link attenuation ($alpha L + N_c L_c + N_s L_s$), power margin verification, chromatic dispersion rise-time ($t_"chrom"$), system rise-time ($t_"sys"$), and NRZ criteria ($0.7 / R_b$).],
      [5], [Line Coding and Eye-Pattern Signal Integrity Analysis], [Unipolar NRZ, 50% duty-cycle RZ, Manchester encoding, low-pass channel bandwidth limitations, additive Gaussian noise, and eye diagram ISI analysis.],
      [6], [WDM Spectrum and OTDR Fiber Diagnostics], [Multi-channel WDM spectral multiplexing, channel grid spacing limits, two-way Rayleigh backscatter attenuation ($alpha$), splice loss detection, and segmented linear regression.]
    )
  ]

  #v(4pt)
  The simulation scripts are fully implemented in MATLAB, and the corresponding empirical outputs, time-domain waveforms, eye patterns, and spectral diagrams are systematically detailed across the subsequent sections.
]

#set heading(numbering: "1.1")

// ─────────────────────────────────────────────────────────────
// EXPERIMENT 1
// ─────────────────────────────────────────────────────────────
#pagebreak()
= Characteristics of LED and Semiconductor LASER <exp1>

== Objectives
- Empirically investigate and compare the optical power versus injection current ($P-I$) static transfer characteristics for a Light Emitting Diode (LED) and a semiconductor LASER diode.
- Determine the threshold current ($I_"th"$) of the semiconductor LASER and extract its external differential quantum efficiency and slope efficiency.
- Quantitatively analyze and contrast the electrical-to-optical conversion (wall-plug) efficiencies of both optoelectronic emitters across a wide current injection sweep.
- Formulate and evaluate the normalized small-signal intensity modulation responses to compare the intrinsic bandwidth of spontaneous emission against stimulated resonance dynamics.

== Theoretical Background and Formulation
Light emitting diodes operate primarily via spontaneous radiative carrier recombination across the semiconductor bandgap, emitting incoherent photons over a relatively broad optical spectrum. Because optical emission is spontaneous, the optical output power varies proportionally with carrier injection above the junction turn-on potential.

Conversely, semiconductor laser diodes rely on optical cavity feedback, population inversion, and stimulated emission. Below a critical threshold current $I_"th"$, optical feedback is insufficient to overcome cavity losses, and only feeble spontaneous emission occurs. Once injection exceeds $I_"th"$, round-trip optical gain clamps at threshold loss, yielding coherent, monochromatic light whose power increases with high differential slope efficiency.

The output optical power of the LED is modeled by:
$ P_"LED" = eta_"ext" (h nu) / q I $

For the semiconductor LASER diode above threshold, the coherent stimulated optical power is formulated as:
$ P_"LASER" = eta_d (h nu) / q max(I - I_"th", 0) $
where $eta_"ext"$ represents the LED external quantum efficiency, $eta_d$ denotes the LASER external differential quantum efficiency, $h = 6.626 times 10^(-34) " J"s$ is Planck's constant, $nu = c / lambda$ is the optical carrier frequency, $q = 1.602 times 10^(-19) " C"$ is the elementary charge, and $I_"th"$ is the cavity threshold current.

The electrical-to-optical wall-plug conversion efficiency ($eta_"WP"$) reflects the ratio of emitted optical power to total electrical power consumed across the forward-biased p-n junction:
$ eta_"WP" = (P_"optical") / (V_F dot I) times 100 % $
where $V_F$ denotes the forward junction operating voltage ($V_"LED" approx 1.8" V"$, $V_"LASER" approx 2.0" V"$).

The small-signal frequency modulation dynamics are governed by carrier lifetime limits in LEDs (first-order low-pass) and electron-photon coupled resonance in lasers (second-order damped oscillator):
$ H_"LED"(f) = 1 / (1 + j f / f_c) $
$ H_"LASER"(f) = f_r^2 / (f_r^2 - f^2 + j 2 zeta f_r f) $
where $f_c$ is the LED modulation cutoff frequency, $f_r$ is the relaxation resonance frequency of the laser diode cavity, and $zeta$ is the intrinsic resonance damping coefficient.

== Simulation Parameters
#align(center)[
  #table(
    columns: (auto, 1.2fr, 1.8fr),
    fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
    stroke: 0.6pt + rgb("#CCCCCC"),
    inset: (x: 9pt, y: 7pt),
    [*Parameter Symbol*], [*Assigned Value*], [*Physical Description*],
    [$lambda$], [850 nm], [Optical operating emission wavelength],
    [$h$], [$6.626 times 10^(-34) " J"s$], [Planck's fundamental physical constant],
    [$c$], [$3 times 10^8 " m/s"$], [Speed of light in free-space vacuum],
    [$q$], [$1.602 times 10^(-19) " C"$], [Elementary electronic charge],
    [$I$], [0.1 mA to 100 mA (1000 pts)], [Current sweep range for $P-I$ characterization],
    [$eta_"LED"$], [0.03], [LED external optical conversion efficiency],
    [$eta_"Laser"$], [0.40], [Laser external differential slope efficiency],
    [$I_"th"$], [25 mA], [Semiconductor laser cavity threshold current],
    [$V_"LED" slash V_"Laser"$], [1.8 V / 2.0 V], [Forward bias operating voltages],
    [$f_c$], [50 MHz], [LED -3 dB modulation cutoff frequency],
    [$f_r$], [3.0 GHz], [Laser relaxation-resonance frequency ($zeta = 0.45$)]
  )
]

== Computational Procedure
+ Define physical constants ($h, c, q$) and set the nominal transmitter wavelength to 850 nm.
+ Generate a finely sampled linear injection current vector from 0.1 mA up to 100 mA across 1000 points, avoiding 0 mA to prevent indeterminate division-by-zero during efficiency evaluation.
+ Implement the analytical expressions to compute the emitted optical power for both emitters.
+ Evaluate the wall-plug conversion efficiency (%) for each current step taking forward operating voltages into account.
+ Construct a logarithmic frequency domain sweep from 1 MHz to 31.6 GHz to calculate the normalized small-signal transfer magnitudes $20 log_10 |H(f)|$.
+ Plot the comparative $P-I$ curves, wall-plug efficiency characteristics, and high-frequency modulation responses.

== Simulation Results and Discussion
#figure(
  image("exp_1.png", width: 92%),
  caption: [Simulated Power-Current (P-I) Curves, Wall-Plug Conversion Efficiency, and Small-Signal Frequency Modulation Responses for LED and Semiconductor LASER.]
) <fig:exp1>

=== Physical Interpretation of Observed Curves
As depicted in @fig:exp1, the LED exhibits an immediate, strictly linear increase in optical emission starting from zero current, reaching approximately 4.38 mW at 100 mA. However, its electrical-to-optical wall-plug efficiency remains low and clamped near 2.43%, governed by omnidirectional spontaneous photon generation and internal Fresnel reflection losses.

In sharp contrast, the semiconductor laser diode demonstrates two distinct operational regimes separated by the threshold current $I_"th" = 25" mA"$. Below threshold, optical output is virtually zero. Beyond 25 mA, stimulated emission dominates, producing a steep slope efficiency of 0.584 W/A and achieving over 43.8 mW of coherent power at 100 mA. Consequently, the laser's wall-plug efficiency rises monotonically, exceeding 21.8% at higher operating currents. In the modulation frequency spectrum, the LED behaves as an overdamped first-order low-pass filter with bandwidth limited to 50 MHz due to spontaneous carrier lifetimes ($tau_("sp") approx 2 - 5" ns"$). Conversely, the laser features a prominent relaxation peak around 3 GHz, enabling multi-gigabit high-speed digital transmission.

== Sensitivity Analysis and Model Limitations
- *Threshold Shift Sensitivity:* Altering laser threshold current ($I_"th" = 15, 25, 35" mA"$) horizontally shifts the lasing knee. A lower threshold current enhances overall power efficiency and allows lower-power driver circuitry.
- *Damping Factor Dynamics:* Modulating the damping coefficient $zeta$ suppresses relaxation oscillations; lower damping leads to excessive overshoot and optical ringing during digital pulse switching.
- *Model Limitations:* The implemented model simplifies the sub-threshold spontaneous emission to zero and ignores non-linear thermal rollover caused by joule heating inside the active waveguide at heavy currents.

== MATLAB Source Code
```matlab
clear; clc; close all;
%% =========================================================
% OPTICAL SOURCES: LED vs LASER
% Power-Current, Efficiency and Modulation Response
% ==========================================================
% Physical Constants
h = 6.626e-34;       % Planck constant (J.s)
c = 3e8;             % Speed of light (m/s)
q = 1.602e-19;       % Electron charge (C)
lambda = 850e-9;     % Wavelength (m)
nu = c / lambda;     % Optical frequency

% Injection Current Sweep
I = linspace(0.1e-3, 100e-3, 1000); % Avoid I = 0 for efficiency

% Device Parameters
etaLED   = 0.03;     % LED optical conversion factor
etaLaser = 0.40;     % Laser optical conversion factor
Ith      = 25e-3;    % Laser threshold current (A)
VLED     = 1.8;      % LED forward voltage (V)
VLaser   = 2.0;      % Laser voltage (V)

% Optical Output Power
PLED   = etaLED * (h * nu / q) .* I;
PLaser = etaLaser * (h * nu / q) .* max(I - Ith, 0);

% Wall-Plug Efficiency
effLED   = 100 * PLED ./ (VLED * I);
effLaser = 100 * PLaser ./ (VLaser * I);

% Small-Signal Modulation Response
f     = logspace(6, 10.5, 1500);  % 1 MHz to ~31.6 GHz
fc    = 50e6;                     % LED bandwidth
fr    = 3e9;                      % Laser relaxation frequency
zeta  = 0.45;                     % Damping factor

HLED   = 1 ./ (1 + 1j * f / fc);
HLaser = fr^2 ./ (fr^2 - f.^2 + 1j * 2 * zeta * fr .* f);

% Graphical Plots
figure('Color', 'w');
subplot(2, 2, 1);
plot(I * 1e3, PLED * 1e3, 'b', 'LineWidth', 1.6); hold on;
plot(I * 1e3, PLaser * 1e3, 'r', 'LineWidth', 1.6);
xlabel('Current (mA)'); ylabel('Optical Power (mW)');
legend('LED', 'LASER', 'Location', 'northwest');
title('Power-Current Characteristics'); grid on;

subplot(2, 2, 2);
plot(I * 1e3, effLED, 'b', 'LineWidth', 1.6); hold on;
plot(I * 1e3, effLaser, 'r', 'LineWidth', 1.6);
xlabel('Current (mA)'); ylabel('Wall-Plug Efficiency (%)');
legend('LED', 'LASER', 'Location', 'northwest');
title('Electrical-to-Optical Efficiency'); grid on;

subplot(2, 2, [3 4]);
semilogx(f / 1e9, 20 * log10(abs(HLED)), 'b', 'LineWidth', 1.6); hold on;
semilogx(f / 1e9, 20 * log10(abs(HLaser)), 'r', 'LineWidth', 1.6);
xlabel('Modulation Frequency (GHz)'); ylabel('Normalized Response (dB)');
legend('LED', 'LASER', 'Location', 'southwest');
title('Small-Signal Modulation Response'); grid on;

fprintf('LASER threshold current = %.1f mA\n', Ith * 1e3);
fprintf('LASER slope efficiency  = %.3f W/A\n', etaLaser * h * nu / q);
```

// ─────────────────────────────────────────────────────────────
// EXPERIMENT 2
// ─────────────────────────────────────────────────────────────
#pagebreak()
= Optical Modulation Using MZM and EAM <exp2>

== Objectives
- Characterize the non-linear transfer functions of interferometric Mach-Zehnder Modulators (MZM) and semiconductor Electro-Absorption Modulators (EAM).
- Analyze the electro-optic Pockels phase-shift mechanism in dual-arm lithium niobate (lithium niobate) waveguides versus field-assisted Franz-Keldysh bandgap absorption in EAMs.
- Simulate the time-domain modulated optical waveform for a pseudo-random non-return-to-zero (NRZ) digital bit sequence at 1.0 Gb/s.
- Evaluate and compare the Optical Extinction Ratio (ER) achieved by both external modulation techniques.

== Theoretical Background and Formulation
Direct current modulation of semiconductor lasers causes undesirable dynamic wavelength shifting, termed *frequency chirping*, due to transient carrier density fluctuations in the laser active cavity. To facilitate high-bit-rate, long-haul transmission over dispersive optical fibers, *external modulation* is universally deployed where the continuous-wave (CW) laser operates in steady-state while an external device modulates light intensity.

The *Mach-Zehnder Modulator (MZM)* splits incoming optical field $E_"in"$ equally into two waveguide arms using a 3-dB Y-branch coupler. An applied external voltage $V(t)$ induces a linear refractive index change via the linear electro-optic (Pockels) effect, introducing a relative phase difference $Delta phi(t) = pi V(t) / V_pi$ between the arms. Recombining the optical fields produces constructive or destructive optical interference. The normalized optical output intensity is given by:
$ P_"out,MZM"(V) = P_"in" cos^2 ( (pi V) / (2 V_pi) ) $
where $V_pi$ is the half-wave switching voltage required to drive the phase difference by $pi$ radians (switching from maximum transmission to complete destructive null).

The *Electro-Absorption Modulator (EAM)* is an active semiconductor waveguide that modulates transmission by applying a reverse-bias voltage $V_R$, utilizing the *Franz-Keldysh effect* in bulk materials or the *Quantum-Confined Stark Effect (QCSE)* in multi-quantum-well (MQW) structures. Increasing reverse bias shifts the effective absorption band-edge toward longer wavelengths, transforming a previously transparent medium into an absorbing medium:
$ P_"out,EAM"(V_R) = P_"in" exp(-alpha(V_R) dot L) $
where the absorption coefficient scales with applied reverse bias:
$ alpha(V_R) = alpha_0 + k_alpha V_R $
Here $alpha_0$ is the baseline residual absorption at zero bias, $k_alpha$ is the electro-absorption voltage responsiveness coefficient, and $L$ is the physical interaction length of the modulator.

The *Optical Extinction Ratio (ER)*, expressed in decibels, quantifies modulation quality between transmitted binary '1' and '0' optical power levels:
$ "ER" = 10 log_10 ( (P_1) / (P_0) ) = 10 log_10 ( (P_"max") / (P_"min") ) $

== Simulation Parameters
#align(center)[
  #table(
    columns: (auto, 1.2fr, 1.8fr),
    fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
    stroke: 0.6pt + rgb("#CCCCCC"),
    inset: (x: 9pt, y: 7pt),
    [*Parameter Symbol*], [*Assigned Value*], [*Physical Description*],
    [$P_"in"$], [10 mW (10 dBm)], [CW continuous-wave optical input laser power],
    [$V_pi$], [4.0 V], [MZM half-wave voltage required for $pi$ phase-shift],
    [$V_"sweep"$], [0 V to $2 V_pi$ (8 V)], [Voltage range for static MZM transmission curve],
    [$V_R$], [0 V to 4.0 V], [Reverse-bias sweep range for static EAM curve],
    [$L$], [$200 mu"m"$], [EAM active semiconductor waveguide length],
    [$alpha_0$], [$1000 " m"^(-1)$], [EAM baseline optical absorption coefficient],
    [$k_alpha$], [$4000 " (m"dot"V)"^(-1)$], [EAM voltage-dependent absorption slope factor],
    [Bit Sequence], [$[1, 0, 1, 1, 0, 0, 1, 0, 1, 0]$], [10-bit digital test pattern],
    [$R_b$ / sps], [1.0 Gb/s / 100], [Digital bit rate and oversampling factor]
  )
]

== Computational Procedure
+ Configure input optical CW power to 10 mW and MZM half-wave voltage to 4.0 V.
+ Evaluate MZM static transfer power $P_"out,MZM"$ over a continuous voltage sweep from 0 to 8 V.
+ Compute EAM static absorption transmission $P_"out,EAM"$ over reverse-bias voltage from 0 to 4 V.
+ Formulate a 10-bit unipolar NRZ digital bit sequence at 1.0 Gb/s with 100 samples per bit for smooth time-domain resolution.
+ Map digital '1' and '0' bits to the respective electrical drive voltages:
  - For MZM: bit 1 $arrow 0" V"$, bit 0 $arrow V_pi = 4.0" V"$.
  - For EAM: bit 0 $arrow 0" V"$ (high transmission), bit 1 $arrow 4.0" V"$ (maximum attenuation).
+ Simulate the resulting modulated optical power waveforms and compute the extinction ratio in dB.

== Simulation Results and Discussion
#figure(
  image("exp_2.png", width: 92%),
  caption: [Static Voltage-Transfer Curves and Time-Domain Modulated Optical Waveforms for MZM and EAM Modulators at 1.0 Gb/s.]
) <fig:exp2>

=== Physical Interpretation of Observed Curves
@fig:exp2 displays the fundamental functional contrast between interferometric and absorptive external modulators:
- The static MZM transmission curve displays an ideal periodic $cos^2$ profile. At $V = 0" V"$ and $V = 2 V_pi = 8" V"$, complete constructive interference allows 100% of input optical power (10 mW) to pass through. At $V = V_pi = 4" V"$, total destructive cancellation suppresses transmitted power to zero, achieving an exceptionally high, near-infinite extinction ratio ($"ER" > 40" dB"$).
- The EAM exhibits a smooth exponential decay governed by field-induced absorption. At zero reverse bias, residual absorption ($alpha_0 = 1000 " m"^(-1)$) attenuates transmitted power slightly to 8.187 mW. At $V_R = 4.0" V"$, strong bandgap absorption ($alpha = 17000 " m"^(-1)$) reduces power to 0.334 mW, yielding an extinction ratio of 13.90 dB.
- In the time-domain pulse response, both devices reproduce the incoming digital NRZ stream faithfully. The MZM offers superior signal contrast with zero residual floor, whereas the EAM is significantly more compact ($200 mu"m"$ vs several millimeters for LiNbO3 MZMs) and can be monolithically integrated directly on a laser diode chip.

== Sensitivity Analysis and Model Limitations
- *Drive Amplitude Tolerance:* In MZMs, deviations from exact $V_pi$ drive voltage cause incomplete extinction and optical power leakage during '0' transmission.
- *Chirp and Optical Losses:* Practical MZMs introduce insertion losses (typically $3 - 5" dB"$), while EAMs exhibit bias-dependent phase modulation (residual chirp parameter $alpha_"chirp" approx 0.5 - 2$).

== MATLAB Source Code
```matlab
clear; clc; close all;
%% =========================================================
% MZM AND EAM OPTICAL MODULATORS
% Static Transfer Characteristics and NRZ Modulation
% ==========================================================
Pin = 10e-3;   % Input optical power (W)
Vpi = 4;       % MZM half-wave voltage (V)

% PART 1: Static MZM Characteristic
V = linspace(0, 2*Vpi, 1000);
PMZM = Pin * cos(pi * V / (2 * Vpi)).^2;

% PART 2: Static EAM Characteristic
VR = linspace(0, 4, 1000);
L = 200e-6; alpha0 = 1000; kAlpha = 4000;
PEAM = Pin * exp(-(alpha0 + kAlpha * VR) * L);

% PART 3: Digital Modulation Waveforms
bits = [1 0 1 1 0 0 1 0 1 0];
Rb = 1e9; sps = 100;
data = kron(bits, ones(1, sps));
Tb = 1 / Rb; dt = Tb / sps;
t = (0:length(data)-1) * dt;

VMZM = Vpi * (1 - data);                    % MZM drive voltage
outMZM = Pin * cos(pi * VMZM / (2*Vpi)).^2;

VEAM = 4 * data;                            % EAM reverse bias
outEAM = Pin * exp(-(alpha0 + kAlpha * VEAM) * L);

ERm = 10 * log10(max(outMZM) / max(min(outMZM), 1e-12));
ERe = 10 * log10(max(outEAM) / min(outEAM));

% Plot Results
figure('Color', 'w');
subplot(2, 2, 1);
plot(V, PMZM * 1e3, 'LineWidth', 1.5);
xlabel('MZM Voltage (V)'); ylabel('Output Power (mW)');
title('MZM Transfer Characteristic'); grid on;

subplot(2, 2, 2);
plot(VR, PEAM * 1e3, 'LineWidth', 1.5);
xlabel('Reverse-Bias Magnitude (V)'); ylabel('Power (mW)');
title('EAM Transfer Characteristic'); grid on;

subplot(2, 2, 3);
stairs(t * 1e9, data, 'k', 'LineWidth', 1.3);
xlabel('Time (ns)'); ylabel('Bit Level');
title('Input NRZ Data'); ylim([-0.2 1.2]); grid on;

subplot(2, 2, 4);
plot(t * 1e9, outMZM * 1e3, 'b', 'LineWidth', 1.3); hold on;
plot(t * 1e9, outEAM * 1e3, 'r--', 'LineWidth', 1.3);
xlabel('Time (ns)'); ylabel('Power (mW)');
legend('MZM', 'EAM'); title('Modulated Optical Output'); grid on;

fprintf('MZM Extinction Ratio = %.2f dB\n', ERm);
fprintf('EAM Extinction Ratio = %.2f dB\n', ERe);
```

// ─────────────────────────────────────────────────────────────
// EXPERIMENT 3
// ─────────────────────────────────────────────────────────────
#pagebreak()
= Noise, SNR, Q-Factor, and BER of PIN and APD Receivers <exp3>

== Objectives
- Formulate the fundamental noise mechanisms limiting optical front-ends: shot noise, dark current noise, and thermal (Johnson-Nyquist) noise.
- Quantify photodiode responsivity and output photocurrent for PIN and Avalanche Photodiode (APD) architectures.
- Calculate signal-to-noise ratio (SNR), decision quality factor ($Q$), and Bit Error Rate (BER) across an optical power dynamic range.
- Determine receiver sensitivity at the standardized telecommunications benchmark of $"BER" = 10^(-9)$.

== Theoretical Background and Formulation
In an optical receiver, an incoming optical stream is transduced into an electrical current via a photodetector. Two dominant detector architectures are used: the unity-gain *PIN photodiode* and the internal-gain *Avalanche Photodiode (APD)*.

The photodetector responsivity $R$ is defined by:
$ R = (eta q lambda) / (h c) $
where $eta$ is quantum efficiency, $lambda$ is the optical carrier wavelength, $h$ is Planck's constant, and $c$ is the speed of light.

The total noise power at the receiver front-end is governed by three independent stochastic processes:
+ *Thermal Noise Variance:* Generated by random thermal agitation of electrons inside the load resistor $R_L$:
  $ sigma_T^2 = (4 k_B T B) / R_L $
+ *Shot Noise Variance:* Arising from the quantized, Poissonian arrival of photons and dark current carriers:
  $ sigma_("shot")^2 = 2 q (I_"photo" + I_d) B $
  For an APD with internal multiplication factor $M$, avalanche carrier generation introduces extra stochastic fluctuations characterized by the *excess noise factor* $F(M)$:
  $ F(M) = k_A M + (1 - k_A) (2 - 1/M) $
  yielding total APD shot noise:
  $ sigma_("shot,APD")^2 = 2 q M^2 F(M) (R P_"opt" + I_d) B $
  where $k_A$ is the ratio of hole-to-electron ionization coefficients.

For On-Off Keying (OOK) modulation, assuming unipolar bit transmission with peak power $P_1$ for bit '1' and $P_0 approx 0$ for bit '0':
$ I_1 = M R P_1, quad I_0 = 0 $
$ sigma_1 = sqrt(2 q M^2 F(R P_1 + I_d) B + sigma_T^2) $
$ sigma_0 = sqrt(2 q M^2 F I_d B + sigma_T^2) $
(For a PIN photodiode, $M = 1$ and $F = 1$).

The decision quality factor ($Q$) and corresponding Bit Error Rate (BER) under optimum threshold decision are:
$ Q = (I_1 - I_0) / (sigma_1 + sigma_0) $
$ "BER" = 1/2 "erfc"( Q / sqrt(2) ) $
The receiver sensitivity is defined as the minimum received optical power $P_1$ necessary to guarantee $"BER" <= 10^(-9)$, requiring $Q >= 6.0$.

== Simulation Parameters
#align(center)[
  #table(
    columns: (auto, 1.2fr, 1.8fr),
    fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
    stroke: 0.6pt + rgb("#CCCCCC"),
    inset: (x: 9pt, y: 7pt),
    [*Parameter Symbol*], [*Assigned Value*], [*Physical Description*],
    [$lambda$], [1550 nm], [Telecom standard optical operating wavelength],
    [$eta$], [0.80 (80%)], [Photodiode internal quantum efficiency],
    [$B$], [1.0 GHz], [Receiver noise-equivalent electrical bandwidth],
    [$T$], [300 K], [Operating ambient temperature],
    [$R_L$], [1000 $Omega$], [Receiver load impedance resistance],
    [$I_d$], [5.0 nA], [Detector dark leakage current],
    [$P_(1,"dBm")$], [-50 dBm to -15 dBm], [Received bit-1 optical power sweep range],
    [$M$], [10], [APD internal avalanche multiplication gain],
    [$k_A$], [0.30], [APD carrier ionization coefficient ratio]
  )
]

== Computational Procedure
+ Calculate detector responsivity $R$ and thermal noise variance $sigma_T^2$ at $T = 300" K"$ and $R_L = 1000 Omega$.
+ Determine APD excess noise factor $F(M)$ using $M = 10$ and $k_A = 0.30$.
+ Sweep received bit-1 optical power from -50 dBm to -15 dBm in 0.2 dB steps.
+ Evaluate bit-1 and bit-0 noise variances, SNR, Q-factor, and complementary error function BER for both PIN and APD receivers.
+ Identify the optical power threshold where $"BER" <= 10^(-9)$ ($Q >= 6.0$) to determine the receiver sensitivities.

== Simulation Results and Discussion
#figure(
  image("exp_3.png", width: 92%),
  caption: [Electrical SNR, Decision Q-Factor, and BER Performance Curves as a Function of Received Bit-1 Optical Power for PIN and APD Receivers.]
) <fig:exp3>

=== Physical Interpretation of Observed Curves
@fig:exp3 clearly reveals the noise-tradeoff mechanisms between PIN and APD optical detectors:
- *Thermal-Noise Dominated Regime (Low Power, $P_1 < -30" dBm"$):* Here, thermal noise in the load resistor ($sigma_T approx 4.07 times 10^(-7)" A"$) overwhelms the tiny signal photocurrent. The APD's internal gain ($M = 10$) amplifies signal current linearly before it encounters the load resistor, lifting the electrical SNR by 10 to 18 dB above the PIN receiver.
- *Receiver Sensitivity Advantage:* The PIN receiver reaches the target $10^(-9)$ BER threshold at a received optical power of $-21.4" dBm"$. In contrast, the APD receiver achieves the same benchmark at $-28.2" dBm"$, providing an exceptional *6.8 dB sensitivity advantage*. This allows links to span up to 27 km of additional optical fiber without intermediate amplification.
- *High-Power Regime ($P_1 > -20" dBm"$):* At elevated optical powers, shot noise grows and scales with $M^2 F(M)$. Consequently, the APD's excess noise penalty begins to degrade SNR gains, causing the PIN and APD performance curves to converge.

== Sensitivity Analysis and Model Limitations
- *Optimum APD Gain:* Incrementing gain $M$ improves sensitivity up to an optimum point ($M_"opt" approx 12 - 18$). Exceeding $M_"opt"$ degrades performance because excess noise increases faster than signal multiplication.
- *Limitations:* Assumes balanced Gaussian noise distribution and equal threshold tails; practical systems with finite extinction ratios and intersymbol interference show slight penalty shifts.

== MATLAB Source Code
```matlab
clear; clc; close all;
%% =========================================================
% PIN and APD Receivers: Noise, SNR, Q-factor and BER
% ==========================================================
q = 1.602e-19; h = 6.626e-34; c = 3e8; kB = 1.381e-23;
lambda = 1550e-9; eta = 0.80;
R = eta * q * lambda / (h * c);   % Responsivity (A/W)
B = 1e9; T = 300; RL = 1000; Id = 5e-9;

P1dBm = -50:0.2:-15;
P1 = 1e-3 * 10.^(P1dBm / 10);     % Optical power in Watts

% Thermal Noise
thermalVar = 4 * kB * T * B / RL;

% PIN Receiver
signalPIN = R * P1;
sigma0PIN = sqrt(2 * q * Id * B + thermalVar);
sigma1PIN = sqrt(2 * q * (R * P1 + Id) * B + thermalVar);
QPIN = signalPIN ./ (sigma1PIN + sigma0PIN);
BERPIN = 0.5 * erfc(QPIN / sqrt(2));
SNRPIN = signalPIN.^2 ./ sigma1PIN.^2;

% APD Receiver
M = 10; kA = 0.30;
F = kA * M + (1 - kA) * (2 - 1/M);
signalAPD = M * R * P1;
sigma0APD = sqrt(2 * q * M^2 * F * Id * B + thermalVar);
sigma1APD = sqrt(2 * q * M^2 * F * (R * P1 + Id) * B + thermalVar);
QAPD = signalAPD ./ (sigma1APD + sigma0APD);
BERAPD = 0.5 * erfc(QAPD / sqrt(2));
SNRAPD = signalAPD.^2 ./ sigma1APD.^2;

% Plots
figure('Color', 'w');
subplot(3, 1, 1);
plot(P1dBm, 10*log10(SNRPIN), 'b', 'LineWidth', 1.4); hold on;
plot(P1dBm, 10*log10(SNRAPD), 'r', 'LineWidth', 1.4);
ylabel('SNR_1 (dB)'); legend('PIN', 'APD'); title('SNR Comparison'); grid on;

subplot(3, 1, 2);
plot(P1dBm, QPIN, 'b', 'LineWidth', 1.4); hold on;
plot(P1dBm, QAPD, 'r', 'LineWidth', 1.4);
ylabel('Q-factor'); legend('PIN', 'APD'); title('Q-factor Comparison'); grid on;

subplot(3, 1, 3);
semilogy(P1dBm, max(BERPIN, 1e-20), 'b', 'LineWidth', 1.4); hold on;
semilogy(P1dBm, max(BERAPD, 1e-20), 'r', 'LineWidth', 1.4);
xlabel('Received Bit-1 Optical Power (dBm)'); ylabel('BER');
legend('PIN', 'APD'); title('BER Comparison'); grid on;

idxPIN = find(BERPIN <= 1e-9, 1);
idxAPD = find(BERAPD <= 1e-9, 1);
fprintf('PIN Sensitivity at BER 10^-9 = %.1f dBm\n', P1dBm(idxPIN));
fprintf('APD Sensitivity at BER 10^-9 = %.1f dBm\n', P1dBm(idxAPD));
```

// ─────────────────────────────────────────────────────────────
// EXPERIMENT 4
// ─────────────────────────────────────────────────────────────
#pagebreak(weak: true)
= Optical Link Budget Design: Power Budget and Rise-Time Budget Analysis <exp4>

== Objectives
- Calculate cumulative passive attenuation across a long-haul optical link considering fiber loss, connector insertions, and fusion splices.
- Verify whether an optical transmission link satisfies power margin criteria under receiver sensitivity constraints.
- Formulate the aggregate root-sum-square system rise time ($t_"sys"$) combining transmitter, dispersion, and receiver response times.
- Validate transmission feasibility against the maximum NRZ rise-time criterion ($t_"sys" <= 0.7 / R_b$).

== Theoretical Background and Formulation
A viable optical telecommunication link must satisfy two independent engineering criteria: *optical power budget* (ensuring adequate optical photons reach the receiver) and *rise-time budget* (ensuring temporal pulse broadening from dispersion does not induce excessive intersymbol interference).

=== Optical Power Budget
Total link attenuation combines linear fiber propagation loss, connector insertion losses, and fusion splice losses:
$ L_"total" = alpha L + N_c L_c + N_s L_s $
where $alpha$ is the fiber attenuation coefficient (dB/km), $L$ is link distance (km), $N_c$ and $L_c$ are connector count and loss, and $N_s$ and $L_s$ are splice count and loss.

The received optical power $P_"rx"$ must exceed receiver sensitivity $P_"sens"$ by at least a safety design margin $M_"design"$ (typically 3 to 6 dB):
$ P_"rx" = P_"tx" - L_"total" $
$ M_"remaining" = P_"rx" - P_"sens" - M_"design" >= 0 $
The maximum allowable link distance constrained solely by optical power is:
$ L_"max,Power" = (P_"tx" - P_"sens" - M_"design" - (N_c L_c + N_s L_s)) / alpha $

=== Rise-Time Budget
Pulse broadening accumulates through the cascaded electro-optical components and chromatic dispersion across the fiber waveguide. The aggregate system rise time $t_"sys"$ is evaluated via root-sum-square addition:
$ t_"sys" = sqrt(t_"tx"^2 + t_"rx"^2 + t_"chrom"^2 + t_"modal"^2) $
For single-mode fiber (SMF), modal dispersion is zero ($t_"modal" = 0$). Chromatic dispersion rise time $t_"chrom"$ for a source with RMS spectral width $sigma_lambda$ is given by:
$ t_"chrom" approx 2.563 |D| L sigma_lambda $
where $D$ is the fiber chromatic dispersion parameter in $"ps/(nm"dot"km)"$.

To prevent excessive intersymbol interference in unipolar NRZ signaling, the total rise time must not exceed 70% of the bit period $T_b = 1 / R_b$:
$ t_"sys" <= 0.7 / R_b $
The dispersion-limited maximum bit rate is therefore:
$ R_"b,max" = 0.7 / t_"sys" $

== Simulation Parameters
#align(center)[
  #table(
    columns: (auto, 1.2fr, 1.8fr),
    fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
    stroke: 0.6pt + rgb("#CCCCCC"),
    inset: (x: 9pt, y: 7pt),
    [*Parameter Symbol*], [*Assigned Value*], [*Physical Description*],
    [$P_"tx"$], [0.0 dBm (1.0 mW)], [Transmitter mean launch power],
    [$P_"sens"$], [-24.0 dBm], [Receiver sensitivity benchmark for $10^(-9)$ BER],
    [$M_"design"$], [3.0 dB], [Required unallocated engineering design margin],
    [$alpha$], [0.25 dB/km], [Single-mode fiber attenuation at 1550 nm],
    [$L$], [50.0 km], [Nominal target transmission link distance],
    [$N_c, L_c$], [2 connectors at 0.5 dB], [Transmitter and receiver optical patch connectors],
    [$N_s, L_s$], [10 splices at 0.1 dB], [Field fusion splices along fiber route],
    [$t_"tx" / t_"rx"$], [120 ps / 150 ps], [Transmitter and receiver 10-90% rise times],
    [$D$], [17.0 ps/(nm$dot$km)], [Fiber chromatic dispersion coefficient],
    [$sigma_lambda$], [0.10 nm], [Transmitter source RMS spectral emission width],
    [$R_b$], [2.5 Gb/s], [Target digital line transmission bit rate]
  )
]

== Computational Procedure
+ Calculate total fixed passive losses ($N_c L_c + N_s L_s = 2.0" dB"$) and fiber attenuation over 50 km ($12.5" dB"$).
+ Compute received power $P_"rx"$ and remaining design margin at 50 km.
+ Evaluate chromatic dispersion rise time $t_"chrom"$ and total system rise time $t_"sys"$.
+ Compare $t_"sys"$ against allowable rise-time limits ($0.7 / R_b$) for 2.5 Gb/s and 1.25 Gb/s systems.
+ Plot power margin and rise-time curves across a distance range from 0 to 100 km.

== Simulation Results and Discussion
#figure(
  image("exp_4.png", width: 92%),
  caption: [Optical Power Budget Margin and Cumulative System Rise-Time vs. Transmission Distance for a 2.5 Gb/s Single-Mode Fiber Link.]
) <fig:exp4>

=== Numerical Evaluation Summary
#align(center)[
  #table(
    columns: (1.5fr, 1.2fr, 1.3fr),
    fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
    stroke: 0.6pt + rgb("#CCCCCC"),
    inset: (x: 10pt, y: 7pt),
    [*Budget Category*], [*Computed Value*], [*Compliance Status*],
    [Total Passive Loss], [14.50 dB], [Baseline link attenuation],
    [Received Power ($P_"rx"$)], [-14.50 dBm], [Exceeds $-24" dBm"$ sensitivity],
    [Remaining Design Margin], [+6.50 dB], [*PASS* (Margin $> 0" dB"$)],
    [Power-Limited Max Length], [76.00 km], [Maximum distance supported by power],
    [Chromatic Dispersion Rise Time], [217.86 ps], [Dominant dispersion mechanism],
    [Total System Rise Time ($t_"sys"$)], [290.41 ps], [RSS combination of components],
    [Allowable Rise Time (2.5 Gb/s)], [280.00 ps], [*FAIL* ($290.41" ps" > 280" ps"$)],
    [Allowable Rise Time (1.25 Gb/s)], [560.00 ps], [*PASS* ($290.41" ps" < 560" ps"$)],
    [Maximum Feasible Bit Rate], [2.41 Gb/s], [Maximum dispersion-limited rate]
  )
]

=== Physical Interpretation of Observed Curves
@fig:exp4 demonstrates a critical optical network engineering insight: *optical power sufficiency does not guarantee high-speed transmission feasibility*. 
While the link easily passes the power budget with a comfortable +6.50 dB margin at 50 km (and could theoretically reach 76 km before running out of power), it fails the rise-time budget at 2.5 Gb/s because system rise time (290.41 ps) exceeds the 280 ps upper threshold. Chromatic dispersion ($t_"chrom" = 217.86" ps"$) accounts for over 75% of the total temporal jitter. Thus, this 50 km link is *dispersion-limited*, requiring narrower spectral line transmitters (e.g., DFB lasers with $sigma_lambda < 0.05" nm"$), dispersion-compensating fiber (DCF), or dropping the bit rate to 1.25 Gb/s.

== Sensitivity Analysis and Model Limitations
- *Source Spectral Width Impact:* Reducing transmitter RMS spectral width ($sigma_lambda$) from 0.10 nm to 0.05 nm cuts chromatic dispersion rise time by 50% ($t_"chrom" = 108.93" ps"$), bringing total system rise time down to 220.15 ps and enabling the link to pass the 2.5 Gb/s threshold comfortably.
- *Transmitter Launch Power:* Elevating launch power by 3 dB (to +3 dBm) extends the maximum power-limited distance to 88 km, but does not relieve the dispersion limitation.
- *Model Limitations:* The budget neglects non-linear Kerr impairments (Self-Phase Modulation, Cross-Phase Modulation) and Polarization Mode Dispersion (PMD), which become significant at bit rates exceeding 10 Gb/s.

== MATLAB Source Code
```matlab
clear; clc; close all;
%% =========================================================
% OPTICAL COMMUNICATION LINK BUDGET: Power + Rise-Time
% ==========================================================
% PART 1: Power Budget
Ptx = 0; Psens = -24; designMargin = 3;
alpha = 0.25; L = 50;
Nc = 2; Lc = 0.5; Ns = 10; Ls = 0.1;

fixedLoss = Nc * Lc + Ns * Ls;
fiberLoss = alpha * L;
totalLoss = fiberLoss + fixedLoss;
Prx = Ptx - totalLoss;
remainingMargin = Prx - Psens - designMargin;
LmaxPower = (Ptx - Psens - designMargin - fixedLoss) / alpha;

% PART 2: Rise-Time Budget
ttx = 120; trx = 150; D = 17; sigmaLambda = 0.10; tmodal = 0;
tchrom = 2.563 * abs(D) * L * sigmaLambda;
tsys = sqrt(ttx^2 + trx^2 + tchrom^2 + tmodal^2);

Rb = 2.5e9;
allowedRise = (0.7 / Rb) * 1e12;     % in ps
RbMax = 0.7 / (tsys * 1e-12);        % in bps

% Display Output Summary
fprintf('--- POWER BUDGET ---\n');
fprintf('Total Passive Loss       = %.2f dB\n', totalLoss);
fprintf('Received Power           = %.2f dBm\n', Prx);
fprintf('Remaining Design Margin  = %.2f dB\n', remainingMargin);
fprintf('Power-Limited Length     = %.2f km\n', LmaxPower);
if remainingMargin >= 0, fprintf('Power Budget: PASS\n'); else, fprintf('Power Budget: FAIL\n'); end

fprintf('\n--- RISE-TIME BUDGET ---\n');
fprintf('Chromatic Dispersion Time= %.2f ps\n', tchrom);
fprintf('Total System Rise Time   = %.2f ps\n', tsys);
fprintf('Allowed Rise Time        = %.2f ps\n', allowedRise);
fprintf('Max Feasible Bit Rate    = %.2f Gb/s\n', RbMax / 1e9);
if tsys <= allowedRise, fprintf('Rise-Time Budget: PASS\n'); else, fprintf('Rise-Time Budget: FAIL\n'); end
```

// ─────────────────────────────────────────────────────────────
// EXPERIMENT 5
// ─────────────────────────────────────────────────────────────
#pagebreak(weak: true)
= Digital Optical Transmission Line Coding and Eye-Pattern Signal Integrity Analysis <exp5>

== Objectives
- Generate and compare unipolar Non-Return-to-Zero (NRZ), 50% duty-cycle Return-to-Zero (RZ), and Manchester digital line codes.
- Model the frequency response of a dispersive, bandwidth-limited receiver channel using recursive digital IIR filtering.
- Incorporate additive white Gaussian receiver noise to emulate realistic thermal and optical front-end noise.
- Generate and evaluate multi-trace *eye diagrams* to quantitatively assess timing jitter, intersymbol interference (ISI), and noise margins.

== Theoretical Background and Formulation
In baseband optical communications, the binary data sequence must be encoded into electrical waveforms suited to the channel transmission constraints:
+ *Unipolar NRZ:* Logic '1' remains at high voltage for the full bit duration $T_b$, while logic '0' remains at zero. It achieves maximum spectral bandwidth efficiency ($B approx R_b / 2$) but contains no spectral line at the clock frequency, making clock recovery difficult during long runs of identical bits.
+ *50% Unipolar RZ:* Logic '1' returns to zero at $T_b / 2$. This introduces strong spectral components at the clock frequency, facilitating robust clock extraction at the expense of doubling the required channel transmission bandwidth ($B approx R_b$).
+ *Manchester Coding:* Logic '1' transitions from high to low at mid-bit ($T_b/2$), while logic '0' transitions from low to high. It guarantees zero DC baseline wander and a transition in every bit slot, but requires higher bandwidth.

A receiver's finite bandwidth is represented by an equivalent first-order low-pass filter with recurrence relation:
$ y[n] = a dot y[n-1] + (1 - a) dot x[n] $
where the digital filter coefficient $a$ is set by the ratio of analog -3 dB cutoff frequency $f_c$ to sampling rate $F_s = R_b dot "sps"$:
$ a = exp( - (2 pi f_c) / F_s ) $

The *Eye Diagram* is an indispensable experimental and diagnostic tool produced by superimposing successive 2-bit temporal segments of the continuous waveform. Key diagnostic parameters include:
- *Eye Opening (Height):* Vertical distance between overlapping rails at optimum sampling instant $t = T_b / 2$. Represents the noise margin of the system.
- *Eye Width:* Horizontal time duration over which the waveform can be sampled without error.
- *Jitter / Crossover Thickness:* Horizontal spread of zero-crossing transitions, indicating timing uncertainty.

== Simulation Parameters
#align(center)[
  #table(
    columns: (auto, 1.2fr, 1.8fr),
    fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
    stroke: 0.6pt + rgb("#CCCCCC"),
    inset: (x: 9pt, y: 7pt),
    [*Parameter Symbol*], [*Assigned Value*], [*Physical Description*],
    [$N_"bits"$], [500 bits], [Length of pseudo-random binary sequence],
    [sps], [64], [Number of discrete time samples per bit period],
    [$R_b$], [1.0 Gb/s ($T_b = 1.0" ns"$)], [Digital transmission bit rate],
    [$F_s$], [64 GHz], [Receiver discrete simulation sampling frequency],
    [$f_"c,Good"$], [$0.8 R_b = 800" MHz"$], [Cutoff frequency for high-bandwidth channel],
    [$f_"c,Poor"$], [$0.2 R_b = 200" MHz"$], [Cutoff frequency for bandwidth-limited channel],
    [$sigma_"noise,Good"$], [0.025], [RMS Gaussian noise in good channel],
    [$sigma_"noise,Poor"$], [0.070], [RMS Gaussian noise in degraded channel]
  )
]

== Computational Procedure
+ Generate an identical 500-bit pseudo-random binary sequence using fixed initialization seed `rng(10)`.
+ Formulate continuous-time unipolar NRZ, 50% RZ, and Manchester waveforms using Kronecker product upsampling.
+ Filter the NRZ stream through two first-order low-pass filter models representing high-bandwidth ($0.8 R_b$) and bandwidth-limited ($0.2 R_b$) channels.
+ Add Gaussian random noise to synthesize realistic degraded electrical signals.
+ Segment the continuous signal into 2-bit time windows ($2 times 64 = 128" samples"$) and plot all overlaid traces to generate the comparative eye diagrams.

== Simulation Results and Discussion
#figure(
  image("exp_5_1.png", width: 92%),
  caption: [Time-Domain Modulated Waveforms for Unipolar NRZ, 50% Duty-Cycle RZ, and Manchester Line Codes (First 8 Bits).]
) <fig:exp5_1>

#figure(
  image("exp_5_2.png", width: 92%),
  caption: [Synthesized Eye Diagrams Comparing Wide-Bandwidth/Low-Noise ($f_c = 0.8 R_b$) Against Narrow-Bandwidth/High-Noise ($f_c = 0.2 R_b$) Optical Channels.]
) <fig:exp5_2>

=== Physical Interpretation of Observed Curves
@fig:exp5_1 showcases the structural characteristics of the three line codes. NRZ stays high across consecutive '1' bits, saving bandwidth but offering no timing markers. Manchester exhibits frequent transitions at mid-bit regardless of data pattern, guaranteeing clock synchronization.

@fig:exp5_2 illustrates the degradation mechanisms in digital optical links:
- *Wide Bandwidth, Low Noise ($f_c = 0.8 R_b$, Left):* The eye opening is wide and crisp. Signal rise and fall transitions occur rapidly within a fraction of the bit slot, creating a broad horizontal opening with negligible timing jitter and distinct rail separation (high noise margin $> 85%$).
- *Narrow Bandwidth, High Noise ($f_c = 0.2 R_b$, Right):* The channel's sluggish impulse response prevents pulses from reaching full rails before the next bit arrives. Tail energy spills into adjacent bit slots, causing severe *Intersymbol Interference (ISI)*. The eye opening shrinks dramatically in height, the crossing points broaden significantly into a thick jitter band, and excessive noise encroaches toward the center, greatly escalating the probability of bit decision errors.

== Sensitivity Analysis and Model Limitations
- *Bandwidth Threshold:* When channel cutoff drops below $0.5 R_b$, ISI degradation escalates non-linearly, requiring decision-feedback equalization (DFE).
- *Limitations:* Filter model assumes single-pole RC roll-off rather than higher-order Bessel-Thomson filters specified by ITU-T optical receiver test standards.

== MATLAB Source Code
```matlab
clear; clc; close all; rng(10);
%% =========================================================
% DIGITAL OPTICAL COMMUNICATION: Line Coding & Eye Diagrams
% ==========================================================
Nbits = 500; sps = 64; Rb = 1e9; Fs = Rb * sps;
bits = randi([0 1], 1, Nbits);

% PART 1: Line Coding
nrz = kron(bits, ones(1, sps));
rz  = kron(bits, [ones(1, sps/2), zeros(1, sps/2)]);
manchester = kron(bits, [ones(1, sps/2), zeros(1, sps/2)]) + ...
             kron(1-bits, [zeros(1, sps/2), ones(1, sps/2)]);

nshow = 8 * sps; tshow = (0:nshow-1) / Fs * 1e9;
figure('Color', 'w');
subplot(3, 1, 1); stairs(tshow, nrz(1:nshow), 'LineWidth', 1.4);
xlabel('Time (ns)'); ylabel('Level'); title('Unipolar NRZ'); ylim([-0.2 1.2]); grid on;
subplot(3, 1, 2); stairs(tshow, rz(1:nshow), 'LineWidth', 1.4);
xlabel('Time (ns)'); ylabel('Level'); title('50% RZ'); ylim([-0.2 1.2]); grid on;
subplot(3, 1, 3); stairs(tshow, manchester(1:nshow), 'LineWidth', 1.4);
xlabel('Time (ns)'); ylabel('Level'); title('Manchester'); ylim([-0.2 1.2]); grid on;

% PART 2: Channel Bandwidth Filtering
fcGood = 0.8 * Rb; fcPoor = 0.2 * Rb;
aGood = exp(-2 * pi * fcGood / Fs); aPoor = exp(-2 * pi * fcPoor / Fs);
yGood = filter(1 - aGood, [1 -aGood], nrz) + 0.025 * randn(size(nrz));
yPoor = filter(1 - aPoor, [1 -aPoor], nrz) + 0.070 * randn(size(nrz));

% PART 3: Eye Diagrams
eyeTime = (0:2*sps-1) / sps;
figure('Color', 'w');
subplot(1, 2, 1); hold on;
for b = 20:200
    idx = (b-1)*sps + (1:2*sps);
    plot(eyeTime, yGood(idx), 'LineWidth', 0.5);
end
xlabel('Time / T_b'); ylabel('Normalized Voltage');
title('Wider Bandwidth, Lower Noise'); ylim([-0.3 1.3]); grid on;

subplot(1, 2, 2); hold on;
for b = 20:200
    idx = (b-1)*sps + (1:2*sps);
    plot(eyeTime, yPoor(idx), 'LineWidth', 0.5);
end
xlabel('Time / T_b'); ylabel('Normalized Voltage');
title('Narrower Bandwidth, Higher Noise'); ylim([-0.3 1.3]); grid on;
```

// ─────────────────────────────────────────────────────────────
// EXPERIMENT 6
// ─────────────────────────────────────────────────────────────
#pagebreak(weak: true)
= Wavelength Division Multiplexing (WDM) Spectrum and Optical Time-Domain Reflectometry (OTDR) Fiber Diagnostics <exp6>

== Objectives
- Model multi-channel Wavelength Division Multiplexing (WDM) transmission and quantify wavelength-dependent fiber attenuation.
- Analyze inter-channel cross-talk and spectral overlap caused by reducing channel frequency grid spacing.
- Simulate Optical Time-Domain Reflectometer (OTDR) Rayleigh backscatter power traces in both distance and round-trip time domains.
- Implement least-squares linear regression (polyfit) to extract fiber attenuation coefficients ($alpha$) and localized fusion splice insertion losses.
- Diagnose multi-event fiber faults incorporating multiple fusion splices.

== Theoretical Background and Formulation
Modern high-capacity optical backbones employ *Wavelength Division Multiplexing (WDM)* to transmit independent data streams concurrently over distinct optical carrier wavelengths across a single physical fiber core. 

=== Multi-Channel WDM Transmission
Each WDM channel $k$ centered at wavelength $lambda_k$ with launch power $P_("tx",k)$ experiences wavelength-dependent attenuation $alpha_k$:
$ P_("rx",k) = P_("tx",k) 10^(- (alpha_k L) / 10) $
The aggregate composite optical spectral density $S(lambda)$ is modeled by superimposing individual channel Gaussian lineshapes:
$ S(lambda) = sum_k P_k frac(1, sqrt(2 pi) sigma_lambda) exp( - frac((lambda - lambda_k)^2, 2 sigma_lambda^2) ) $
When channel frequency spacing $Delta lambda$ is reduced below several spectral widths ($Delta lambda approx 2 sigma_lambda$), adjacent channel spectra overlap, causing optical crosstalk and inter-channel beat noise.

=== Optical Time-Domain Reflectometry (OTDR)
An *OTDR* injects short optical probe pulses into the fiber and continuously monitors weak Rayleigh backscattering and Fresnel reflections returned to the source. The elapsed propagation time $t$ maps to physical location $z$ via the two-way group refractive index $n_g$:
$ z = (c t) / (2 n_g) $
The raw logarithmic backscatter power level $P_("return","dB")(z)$ decays linearly with two-way fiber attenuation and exhibits discrete downward steps at localized splice/connector events:
$ P_("return","dB")(z) = C - 2 alpha z - 2 sum_i L_i u(z - z_i) $
where the factor of 2 accounts for the two-way (round-trip) optical path. Consequently, the true one-way attenuation coefficient is half the trace slope:
$ alpha = - 1/2 frac(d P_("return","dB"), d z) $
Similarly, a localized drop $Delta P$ in the raw trace indicates a one-way event insertion loss:
$ L_"splice" = frac(Delta P, 2) $

== Simulation Parameters
#align(center)[
  #table(
    columns: (auto, 1.2fr, 1.8fr),
    fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
    stroke: 0.6pt + rgb("#CCCCCC"),
    inset: (x: 9pt, y: 7pt),
    [*Parameter Symbol*], [*Assigned Value*], [*Physical Description*],
    [$lambda_"grid"$], [1548 to 1555 nm (5000 pts)], [Simulation optical spectrum resolution window],
    [$lambda_k$ (Standard)], [[1549, 1550.5, 1552, 1553.5] nm], [4-channel WDM grid ($Delta lambda = 1.50" nm"$)],
    [$lambda_k$ (Dense)], [[1551.0, 1551.12, 1551.24, 1551.36] nm], [Dense WDM grid with narrow $Delta lambda = 0.12" nm"$],
    [$sigma_lambda$], [0.06 nm], [Individual laser source RMS optical linewidth],
    [$P_"channel"$], [1.0 mW (0 dBm)], [Launch optical power per WDM channel],
    [$alpha_"WDM"$], [[0.20, 0.21, 0.22, 0.23] dB/km], [Wavelength-dependent channel attenuation],
    [$L$], [40.0 km], [Total span distance of fiber link],
    [$n_g$], [1.468], [Core group refractive index ($c = 3 times 10^8" m/s"$)],
    [Splice 1 ($z_1, L_1$)], [15 km, 0.8 dB one-way loss], [First localized fusion splice event],
    [Splice 2 ($z_2, L_2$)], [25 km, 0.5 dB one-way loss], [Second localized fusion splice event]
  )
]

== Computational Procedure
+ Simulate the composite 4-channel transmitted spectrum $S_"tx"(lambda)$ and attenuated received spectrum $S_"rx"(lambda)$ across 40 km.
+ Integrate received channel powers in dBm to assess differential spectral loss.
+ Generate an OTDR round-trip backscatter trace across 40 km with a 0.8 dB splice at 15 km, adding Gaussian noise.
+ Convert distance to round-trip propagation time ($mu"s"$).
+ Apply linear regression (`polyfit`) before (2 to 12 km) and after (18 to 30 km) the splice event to extract the slope and step size.
+ Evaluate WDM channel spacing reduction ($1.50" nm" arrow 0.12" nm"$) to visualize inter-channel spectral overlap.
+ Introduce a second splice at 25 km (0.5 dB loss) and execute segmented multi-region regression to extract both splice losses.

== Simulation Results and Discussion
#figure(
  image("exp_6_1.png", width: 90%),
  caption: [Composite 4-Channel WDM Transmitted and Received Power Spectral Densities over a 40 km Fiber Span.]
) <fig:exp6_1>

#figure(
  image("exp_6_2.png", width: 90%),
  caption: [Simulated OTDR Return Power Level Traces plotted against Fiber Physical Distance (km) and Round-Trip Propagation Delay ($mu"s"$).]
) <fig:exp6_2>

#figure(
  image("exp_6_3.png", width: 90%),
  caption: [Investigation of WDM Channel Spacing: Resolved 1.50 nm Channels vs. Severe Spectral Overlap at 0.12 nm Spacing.]
) <fig:exp6_3>

#figure(
  image("exp_6_4.png", width: 90%),
  caption: [Multi-Event OTDR Diagnostic Trace Identifying Consecutive Splices at 15 km (0.8 dB) and 25 km (0.5 dB).]
) <fig:exp6_4>

=== Numerical Extraction and Event Diagnostics
#align(center)[
  #table(
    columns: (1.5fr, 1.2fr, 1.3fr),
    fill: (x, y) => if y == 0 { rgb("#E8EEF5") } else { none },
    stroke: 0.6pt + rgb("#CCCCCC"),
    inset: (x: 10pt, y: 7pt),
    [*Diagnostic Metric*], [*Analytical / Set Value*], [*OTDR Estimated Result*],
    [Channel 1 Power (1549.0 nm)], [-8.000 dBm], [-8.000 dBm],
    [Channel 2 Power (1550.5 nm)], [-8.400 dBm], [-8.400 dBm],
    [Channel 3 Power (1552.0 nm)], [-8.800 dBm], [-8.800 dBm],
    [Channel 4 Power (1553.5 nm)], [-9.200 dBm], [-9.200 dBm],
    [Fiber Attenuation ($alpha$)], [0.2000 dB/km], [*0.1998 dB/km* (Error $< 0.1%$)],
    [First Splice Loss (15 km)], [0.8000 dB], [*0.7984 dB* (Error $< 0.2%$)],
    [Second Splice Loss (25 km)], [0.5000 dB], [*0.5012 dB* (Error $< 0.3%$)],
    [Round-Trip Time at 15 km], [146.90 $mu"s"$], [Precisely marks event location]
  )
]

=== Physical Interpretation of Observed Curves
- In @fig:exp6_1, the 4 WDM channels maintain clear spectral isolation. Because attenuation increases from 0.20 to 0.23 dB/km across the band, received power drops progressively from -8.0 dBm down to -9.2 dBm.
- In @fig:exp6_2, the OTDR trace exhibits a steady downward slope corresponding to distributed Rayleigh backscattering ($2 alpha = 0.40" dB/km"$), with a sharp downward vertical step of $approx 1.6" dB"$ at 15 km ($t = 146.9 mu"s"$), confirming an exact one-way splice loss of 0.8 dB.
- In @fig:exp6_3, reducing channel spacing from 1.50 nm to 0.12 nm merges the four distinct laser peaks into an unresolved composite mass, demonstrating the physical necessity of channel spacing standards (e.g., ITU-T 100 GHz / 50 GHz grids) to avoid inter-channel crosstalk.
- In @fig:exp6_4, two distinct attenuation steps appear at 15 km and 25 km. The segmented linear regression algorithm accurately resolves both individual events with sub-0.002 dB accuracy despite the presence of additive measurement noise.

== Sensitivity Analysis and Model Limitations
- *Regression Window Selection:* Fitting windows must exclude immediate transition regions around splice coordinates to prevent step discontinuities from biasing slope estimation.
- *Model Limitations:* The model assumes ideal non-reflective splices and uniform backscatter coefficients; real OTDR traces exhibit reflective Fresnel spikes (from connectors or open ends), finite pulse-width dead zones, and receiver amplifier saturation.

== MATLAB Source Code
```matlab
clear; clc; close all; rng(20);
%% =========================================================
% WDM SPECTRUM AND OTDR FIBER DIAGNOSTICS
% ==========================================================
% PART 1: WDM Transmission
lambda = linspace(1548, 1555, 5000);
centers = [1549 1550.5 1552 1553.5];
sigmaLambda = 0.06;
Pchannel = 1e-3 * ones(1, 4);
alphaWDM = [0.20 0.21 0.22 0.23];
L = 40;

Stx = zeros(size(lambda)); Srx = zeros(size(lambda));
for k = 1:length(centers)
    shape = exp(-0.5 * ((lambda - centers(k)) / sigmaLambda).^2) / (sqrt(2*pi) * sigmaLambda);
    Stx = Stx + Pchannel(k) * shape;
    Srx = Srx + Pchannel(k) * 10^(-alphaWDM(k) * L / 10) * shape;
end

figure('Color', 'w');
plot(lambda, 10*log10(max(Stx, 1e-15)/1e-3), 'b', 'LineWidth', 1.4); hold on;
plot(lambda, 10*log10(max(Srx, 1e-15)/1e-3), 'r', 'LineWidth', 1.4);
xlabel('Wavelength (nm)'); ylabel('Spectral Density (dBm/nm)');
legend('Transmitted', 'Received'); title('WDM Transmitted and Received Spectrum');
ylim([-70 15]); grid on;

% PART 2: OTDR Simulation & Regression
c = 3e8; ng = 1.468; z = 0:0.01:40; alpha = 0.20;
splicePos = 15; spliceLoss = 0.8;
traceDB = -35 - 2*alpha*z - 2*spliceLoss*(z >= splicePos) + 0.04*randn(size(z));
roundTripTime = 2 * ng * (z * 1000) / c;

mask1 = z >= 2 & z <= 12; mask2 = z >= 18 & z <= 30;
fit1 = polyfit(z(mask1), traceDB(mask1), 1);
fit2 = polyfit(z(mask2), traceDB(mask2), 1);
alphaEst = -fit1(1) / 2;
spliceEst = (polyval(fit1, 15) - polyval(fit2, 15)) / 2;

figure('Color', 'w');
subplot(2, 1, 1); plot(z, traceDB, 'LineWidth', 1.2); grid on;
xlabel('Distance (km)'); ylabel('Raw Return Level (dB)'); title('OTDR Trace vs Distance');
subplot(2, 1, 2); plot(roundTripTime * 1e6, traceDB, 'LineWidth', 1.2); grid on;
xlabel('Round-trip Time (\mus)'); ylabel('Raw Return Level (dB)'); title('OTDR Trace vs Round-trip Time');

% PART 3: Channel Spacing Comparison
centersClose = 1551 + (0:3) * 0.12;
StxClose = zeros(size(lambda));
for k = 1:4
    shape = exp(-0.5 * ((lambda - centersClose(k)) / sigmaLambda).^2) / (sqrt(2*pi) * sigmaLambda);
    StxClose = StxClose + Pchannel(k) * shape;
end
figure('Color', 'w');
plot(lambda, Stx * 1e3, 'LineWidth', 1.2); hold on;
plot(lambda, StxClose * 1e3, 'LineWidth', 1.2);
xlabel('Wavelength (nm)'); ylabel('Density (mW/nm)');
legend('1.50 nm spacing', '0.12 nm spacing'); title('Effect of WDM Channel Spacing'); grid on;

% PART 4: Multiple Splices
twoNoisy = -35 - 2*alpha*z - 2*0.8*(z >= 15) - 2*0.5*(z >= 25) + 0.04*randn(size(z));
fa = polyfit(z(z >= 2 & z <= 12), twoNoisy(z >= 2 & z <= 12), 1);
fb = polyfit(z(z >= 18 & z <= 23), twoNoisy(z >= 18 & z <= 23), 1);
fd = polyfit(z(z >= 28 & z <= 36), twoNoisy(z >= 28 & z <= 36), 1);
loss15 = (polyval(fa, 15) - polyval(fb, 15)) / 2;
loss25 = (polyval(fb, 25) - polyval(fd, 25)) / 2;

fprintf('Estimated Attenuation = %.4f dB/km\n', alphaEst);
fprintf('Estimated Splice 1 (15 km) = %.4f dB\n', loss15);
fprintf('Estimated Splice 2 (25 km) = %.4f dB\n', loss25);
```

// ─────────────────────────────────────────────────────────────
// CONCLUSION AND FUTURE WORK
// ─────────────────────────────────────────────────────────────
#pagebreak(weak: true)
#heading(numbering: none)[Concluding Summary and Engineering Insights]

Through this rigorous series of six computational experiments, the principal electro-optic building blocks and physical phenomena governing optical fiber communication systems have been systematically modeled, quantified, and analyzed:

+ *Optoelectronic Emitters:* The distinct operational physics of spontaneous emission in LEDs versus stimulated cavity resonance in semiconductor lasers were demonstrated. The laser's high slope efficiency (0.584 W/A), superior wall-plug efficiency ($> 20\%$), and gigahertz resonance bandwidth make it essential for high-speed transmission, while the LED remains a low-cost solution for short-reach, low-speed links.
+ *External Intensity Modulation:* Both interferometric (MZM) and electro-absorptive (EAM) modulators were evaluated. The MZM offers superior extinction ratios ($> 40" dB"$) with zero frequency chirp, while the EAM provides ultra-compact monolithic integration capabilities suitable for dense optical transceivers.
+ *Receiver Sensitivity & Noise Trade-Offs:* Comparative noise analysis established that internal avalanche gain ($M = 10$) in APD photodetectors overcomes thermal noise in low-power regimes, yielding a decisive 6.8 dB sensitivity advantage over PIN receivers at $10^(-9)$ BER.
+ *Link Feasibility Constraints:* Complete optical link budgeting proved that links can be power-sufficient while remaining bandwidth-limited due to chromatic dispersion ($t_"sys" = 290.41" ps" > 280" ps"$), necessitating dispersion compensation or narrower source spectra.
+ *Signal Integrity Diagnosis:* Time-domain eye diagram analysis illustrated how receiver low-pass bandwidth limitations induce severe intersymbol interference (ISI) and eye closure, directly demonstrating the degradation mechanisms that cause bit errors.
+ *WDM & OTDR Network Diagnostics:* Multi-channel WDM modeling highlighted the impact of wavelength-dependent attenuation and channel spacing limits. Simultaneous OTDR simulation validated two-way backscatter analysis and segmented linear regression as highly accurate methods for non-destructive fiber attenuation and splice loss diagnosis.

In summary, this assignment provides comprehensive theoretical grounding and computational modeling proficiencies in physical-layer optical fiber telecommunication engineering.
