export AMBERHOME=/usr/local/amber16/amber16/

echo "initial minimization                           " >  min1.in
echo " &cntrl                                        " >> min1.in
echo "  imin   = 1, irest = 0, ntx = 1,              " >> min1.in
echo "  maxcyc = 5000, ncyc = 2500,                  " >> min1.in
echo "  ntc    = 1, ntf = 1,                         " >> min1.in
echo "  cut    = 8.0,                                " >> min1.in
echo "  ntb    = 1,                                  " >> min1.in
echo "  iwrap  = 1,                                  " >> min1.in
echo "  ig     = -1,                                 " >> min1.in
echo "  ioutfm = 1,                                  " >> min1.in
echo "  ntpr   = 500, ntwx = 500, ntwr = 500,        " >> min1.in
echo "  ntr    = 1, restraint_wt = 500.0,            " >> min1.in
echo "  restraintmask = ':1-399',                    " >> min1.in
echo "  nmropt = 1,                                  " >> min1.in
echo " /                                             " >> min1.in
echo " &wt type='END'                                " >> min1.in
echo " /                                             " >> min1.in
echo " DISANG=restraints.RST                         " >> min1.in



echo "initial minimization                           " >  min2.in 
echo " &cntrl                                        " >> min2.in
echo "  imin   = 1, irest = 0, ntx = 1,              " >> min2.in
echo "  maxcyc = 5000, ncyc = 2500,                  " >> min2.in
echo "  ntc    = 1, ntf = 1,                         " >> min2.in
echo "  cut    = 8.0,                                " >> min2.in
echo "  ntb    = 1,                                  " >> min2.in
echo "  iwrap  = 1,                                  " >> min2.in
echo "  ig     = -1,                                 " >> min2.in
echo "  ioutfm = 1,                                  " >> min2.in
echo "  ntpr   = 500, ntwx = 500, ntwr = 500,        " >> min2.in
echo "  ntr    = 1, restraint_wt = 2.0,              " >> min2.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> min2.in
echo "  nmropt = 1,                                  " >> min1.in
echo " /                                             " >> min2.in
echo " &wt type='END'                                " >> min2.in
echo " /                                             " >> min2.in
echo " DISANG=restraints.RST                         " >> min2.in

echo "50ps heating in NVT                            " >  heat1.in
echo " &cntrl                                        " >> heat1.in
echo "  imin   = 0, irest = 0, ntx = 1,              " >> heat1.in
echo "  ntc    = 2, ntf = 2,                         " >> heat1.in
echo "  cut    = 8.0,                                " >> heat1.in
echo "  ntt    = 3, gamma_ln = 5.0,                  " >> heat1.in
echo "  tempi  = 0.0, temp0  = 50.0,                 " >> heat1.in
echo "  ntb    = 1,                                  " >> heat1.in
echo "  iwrap  = 1,                                  " >> heat1.in
echo "  ig     = -1,                                 " >> heat1.in
echo "  ioutfm = 1,                                  " >> heat1.in
echo "  nstlim = 50000, dt = 0.001,                  " >> heat1.in
echo "  ntpr   = 2500, ntwx = 2500, ntwr = 2500,     " >> heat1.in
echo "  ntr    = 1, restraint_wt = 30.0,             " >> heat1.in
echo "  nmropt = 1,                                  " >> heat1.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> heat1.in
echo " /                                             " >> heat1.in
echo " &wt TYPE='TEMP0', istep1=0, istep2=50000,     " >> heat1.in
echo " value1=0.0, value2=50.0, /                    " >> heat1.in
echo " &wt TYPE='END' /                              " >> heat1.in
echo " /                                             " >> heat1.in
echo " DISANG=restraints.RST                         " >> heat1.in

echo "50ps heating in NVT                            " >  heat2.in
echo " &cntrl                                        " >> heat2.in
echo "  imin   = 0, irest = 1, ntx = 5,              " >> heat2.in
echo "  ntc    = 2, ntf = 2,                         " >> heat2.in
echo "  cut    = 8.0,                                " >> heat2.in
echo "  ntt    = 3, gamma_ln = 5.0,                  " >> heat2.in
echo "  tempi  = 50.0, temp0  = 100.0,               " >> heat2.in
echo "  ntb    = 1,                                  " >> heat2.in
echo "  iwrap  = 1,                                  " >> heat2.in
echo "  ig     = -1,                                 " >> heat2.in
echo "  ioutfm = 1,                                  " >> heat2.in
echo "  nstlim = 50000, dt = 0.001,                  " >> heat2.in
echo "  ntpr   = 2500, ntwx = 2500, ntwr = 2500,     " >> heat2.in
echo "  ntr    = 1, restraint_wt = 30.0,             " >> heat2.in
echo "  nmropt = 1,                                  " >> heat2.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> heat2.in
echo " /                                             " >> heat2.in
echo " &wt TYPE='TEMP0', istep1=0, istep2=50000,     " >> heat2.in
echo " value1=50.0, value2=100.0, /                  " >> heat2.in
echo " &wt TYPE='END' /                              " >> heat2.in
echo " /                                             " >> heat2.in
echo " DISANG=restraints.RST                         " >> heat2.in


echo "50ps heating in NVT                            " >  heat3.in
echo " &cntrl                                        " >> heat3.in
echo "  imin   = 0, irest = 1, ntx = 5,              " >> heat3.in
echo "  ntc    = 2, ntf = 2,                         " >> heat3.in
echo "  cut    = 8.0,                                " >> heat3.in
echo "  ntt    = 3, gamma_ln = 5.0,                  " >> heat3.in
echo "  tempi  = 100.0, temp0  = 150.0,              " >> heat3.in
echo "  ntb    = 1,                                  " >> heat3.in
echo "  iwrap  = 1,                                  " >> heat3.in
echo "  ig     = -1,                                 " >> heat3.in
echo "  ioutfm = 1,                                  " >> heat3.in
echo "  nstlim = 50000, dt = 0.001,                  " >> heat3.in
echo "  ntpr   = 2500, ntwx = 2500, ntwr = 2500,     " >> heat3.in
echo "  ntr    = 1, restraint_wt = 30.0,             " >> heat3.in
echo "  nmropt = 1,                                  " >> heat3.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> heat3.in
echo " /                                             " >> heat3.in
echo " &wt TYPE='TEMP0', istep1=0, istep2=50000,     " >> heat3.in
echo " value1=100.0, value2=150.0, /                 " >> heat3.in
echo " &wt TYPE='END' /                              " >> heat3.in
echo " /                                             " >> heat3.in
echo " DISANG=restraints.RST                         " >> heat3.in

echo "50ps heating in NVT                            " >  heat4.in
echo " &cntrl                                        " >> heat4.in
echo "  imin   = 0, irest = 1, ntx = 5,              " >> heat4.in
echo "  ntc    = 2, ntf = 2,                         " >> heat4.in
echo "  cut    = 8.0,                                " >> heat4.in
echo "  ntt    = 3, gamma_ln = 5.0,                  " >> heat4.in
echo "  tempi  = 150.0, temp0  = 200.0,              " >> heat4.in
echo "  ntb    = 1,                                  " >> heat4.in
echo "  iwrap  = 1,                                  " >> heat4.in
echo "  ig     = -1,                                 " >> heat4.in
echo "  ioutfm = 1,                                  " >> heat4.in
echo "  nstlim = 50000, dt = 0.001,                  " >> heat4.in
echo "  ntpr   = 2500, ntwx = 2500, ntwr = 2500,     " >> heat4.in
echo "  ntr    = 1, restraint_wt = 30.0,             " >> heat4.in
echo "  nmropt = 1,                                  " >> heat4.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> heat4.in
echo " /                                             " >> heat4.in
echo " &wt TYPE='TEMP0', istep1=0, istep2=50000,     " >> heat4.in
echo " value1=150.0, value2=200.0, /                 " >> heat4.in
echo " &wt TYPE='END' /                              " >> heat4.in
echo " /                                             " >> heat4.in
echo " DISANG=restraints.RST                         " >> heat4.in

echo "50ps heating in NVT                            " >  heat5.in
echo " &cntrl                                        " >> heat5.in
echo "  imin   = 0, irest = 1, ntx = 5,              " >> heat5.in
echo "  ntc    = 2, ntf = 2,                         " >> heat5.in
echo "  cut    = 8.0,                                " >> heat5.in
echo "  ntt    = 3, gamma_ln = 5.0,                  " >> heat5.in
echo "  tempi  = 200.0, temp0  = 250.0,              " >> heat5.in
echo "  ntb    = 1,                                  " >> heat5.in
echo "  iwrap  = 1,                                  " >> heat5.in
echo "  ig     = -1,                                 " >> heat5.in
echo "  ioutfm = 1,                                  " >> heat5.in
echo "  nstlim = 50000, dt = 0.001,                  " >> heat5.in
echo "  ntpr   = 2500, ntwx = 2500, ntwr = 2500,     " >> heat5.in
echo "  ntr    = 1, restraint_wt = 30.0,             " >> heat5.in
echo "  nmropt = 1,                                  " >> heat5.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> heat5.in
echo " /                                             " >> heat5.in
echo " &wt TYPE='TEMP0', istep1=0, istep2=50000,     " >> heat5.in
echo " value1=200.0, value2=250.0, /                 " >> heat5.in
echo " &wt TYPE='END' /                              " >> heat5.in
echo " /                                             " >> heat5.in
echo " DISANG=restraints.RST                         " >> heat5.in

echo "50ps heating in NVT                            " >  heat6.in
echo " &cntrl                                        " >> heat6.in
echo "  imin   = 0, irest = 1, ntx = 5,              " >> heat6.in
echo "  ntc    = 2, ntf = 2,                         " >> heat6.in
echo "  cut    = 8.0,                                " >> heat6.in
echo "  ntt    = 3, gamma_ln = 5.0,                  " >> heat6.in
echo "  tempi  = 250.0, temp0  = 300.0,              " >> heat6.in
echo "  ntb    = 1,                                  " >> heat6.in
echo "  iwrap  = 1,                                  " >> heat6.in
echo "  ig     = -1,                                 " >> heat6.in
echo "  ioutfm = 1,                                  " >> heat6.in
echo "  nstlim = 50000, dt = 0.001,                  " >> heat6.in
echo "  ntpr   = 2500, ntwx = 2500, ntwr = 2500,     " >> heat6.in
echo "  ntr    = 1, restraint_wt = 30.0,             " >> heat6.in
echo "  nmropt = 1,                                  " >> heat6.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> heat6.in
echo " /                                             " >> heat6.in
echo " &wt TYPE='TEMP0', istep1=0, istep2=50000,     " >> heat6.in
echo " value1=250.0, value2=300.0, /                 " >> heat6.in
echo " &wt TYPE='END' /                              " >> heat6.in
echo " /                                             " >> heat6.in
echo " DISANG=restraints.RST                         " >> heat6.in

echo "2ns equilibration in NPT at high restraint     " >  eq1.in
echo " &cntrl                                        " >> eq1.in
echo "  imin   = 0, irest = 1, ntx = 5,              " >> eq1.in
echo "  ntc    = 2, ntf = 2,                         " >> eq1.in
echo "  cut    = 8.0,                                " >> eq1.in
echo "  ntt    = 3, gamma_ln = 5.0,                  " >> eq1.in
echo "  tempi  = 300.0, temp0  = 300.0,              " >> eq1.in
echo "  ntb    = 2, ntp = 1, barostat = 2, taup=5.0, " >> eq1.in
echo "  pres0  = 1.0,                                " >> eq1.in
echo "  iwrap  = 1,                                  " >> eq1.in
echo "  ig     = -1,                                 " >> eq1.in
echo "  ioutfm = 1,                                  " >> eq1.in
echo "  nstlim = 1000000, dt = 0.002,                " >> eq1.in
echo "  ntpr   = 25000, ntwx = 25000, ntwr = 25000,  " >> eq1.in
echo "  ntr    = 1, restraint_wt = 30.0,             " >> eq1.in
echo "  nmropt = 1,                                  " >> eq1.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> eq1.in
echo " /                                             " >> eq1.in
echo " &wt type='END'                                " >> eq1.in
echo " /                                             " >> eq1.in
echo " DISANG=restraints.RST                         " >> eq1.in

echo "2ns equilibration in NPT at low restraint      " >  eq2.in
echo " &cntrl                                        " >> eq2.in
echo "  imin   = 0, irest = 1, ntx = 5,              " >> eq2.in
echo "  ntc    = 2, ntf = 2,                         " >> eq2.in
echo "  cut    = 8.0,                                " >> eq2.in
echo "  ntt    = 3, gamma_ln = 5.0,                  " >> eq2.in
echo "  tempi  = 300.0, temp0  = 300.0,              " >> eq2.in
echo "  ntb    = 2, ntp = 1, barostat = 2, taup=5.0, " >> eq2.in
echo "  pres0  = 1.0,                                " >> eq2.in
echo "  iwrap  = 1,                                  " >> eq2.in
echo "  ig     = -1,                                 " >> eq2.in
echo "  ioutfm = 1,                                  " >> eq2.in
echo "  nstlim = 1000000, dt = 0.002,                " >> eq2.in
echo "  ntpr   = 25000, ntwx = 25000, ntwr = 25000,  " >> eq2.in
echo "  ntr    = 1, restraint_wt = 0.5,              " >> eq2.in
echo "  nmropt = 1,                                  " >> eq1.in
echo "  restraintmask = ':1-399@C,CA,N',             " >> eq2.in
echo " /                                             " >> eq2.in
echo " &wt type='END'                                " >> eq2.in
echo " /                                             " >> eq2.in
echo " DISANG=restraints.RST                         " >> eq2.in

