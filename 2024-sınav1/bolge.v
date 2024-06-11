module bolge(
    input Y,
    input [1:0] G,
    input [1:0] R,
    output [1:0] B
);

wire notY;
wire notG0;
wire notG1;

not (notY,Y);
not (notG0,G[0]);
not (notG1,G[1]);

//B[0] = Y' + Y.R[0] + Y.G[1].G[0] + Y.G[1]'.G[0]'
wire wire1;
wire wire2;
wire wire3;

and (wire1,Y,R[0]);
and (wire2,Y,G[1],G[0]);
and (wire3,Y,notG1,notG0);

or (B[0],notY,wire1,wire2,wire3);

//B[1] = Y' + Y.R[1] + Y.G[1].G[0] + Y.G[1]'.G[0]'
wire wire4;
wire wire5;
wire wire6;

and (wire4,Y,R[1]);
and (wire5,Y,G[1],G[0]);
and (wire6,Y,notG1,notG0);

or (B[1],notY,wire4,wire5,wire6);

endmodule