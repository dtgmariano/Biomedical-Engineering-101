function [ vlr, idx ] = getP2(fsignals, lmin, lmax, Ts )

    p1_vlr = max(fsignals(1,(lmin:lmax)));
    p1_idx = (find(fsignals(1,(lmin:lmax)) == p1_vlr) + lmin - 1) * Ts * 1000;
    p2_vlr = max(fsignals(2,(lmin:lmax)));
    p2_idx = (find(fsignals(2,(lmin:lmax)) == p2_vlr) + lmin - 1) * Ts * 1000;
    p3_vlr = max(fsignals(3,(lmin:lmax)));
    p3_idx = (find(fsignals(3,(lmin:lmax)) == p3_vlr) + lmin - 1) * Ts * 1000;
    p4_vlr = max(fsignals(4,(lmin:lmax)));
    p4_idx = (find(fsignals(4,(lmin:lmax)) == p4_vlr) + lmin - 1) * Ts * 1000;
    p5_vlr = max(fsignals(5,(lmin:lmax)));
    p5_idx = (find(fsignals(5,(lmin:lmax)) == p5_vlr) + lmin - 1) * Ts * 1000;
    p6_vlr = max(fsignals(6,(lmin:lmax)));
    p6_idx = (find(fsignals(6,(lmin:lmax)) == p6_vlr) + lmin - 1) * Ts * 1000;
    
    vlr = [p1_vlr; p2_vlr; p3_vlr; p4_vlr; p5_vlr; p6_vlr];
    idx = [p1_idx; p2_idx; p3_idx; p4_idx; p5_idx; p6_idx];

end

