a = [1, 1, 0]; //Enter first vector - 3blue
b = [1, 0, 1]; //Enter second vector - 1brown

//REMOVE "//" TO USE

//VECTORS
//vector(a[0], a[1], a[2]);
//vector(b[0], b[1], b[2]);

//ADDITION
//add(a, b);

//DOT PRODUCT
//echo(str("𝗮 ⋅ 𝗯 = ", dot(a, b)));

//PROJECTION
//projection(a, b);
//projection(b, a);

//CROSS PRODUCT
//cross(a, b);

//MATRIX MULTIPLICATION + TRANSFORMATION
/*mat(
    [
        [1, -3, 4]   ,
        [3, 0, 0]   ,
        [2, 1, 1]
    ]
    ,   [1, 1, 1]
);*/

function magnitude(v1) = sqrt(v1[0]*v1[0] + v1[1]*v1[1] + v1[2]*v1[2]);

module add(v1, v2){
    vector(v1[0] + v2[0], v1[1] + v2[1], v1[2] + v2[2]);
    color([0.47843, 0.74902, 0.88235])
    vector(v1[0], v1[1], v1[2]);
    color([0.53333, 0.38824, 0.23529])
    vector(v2[0], v2[1], v2[2]);
    points = [
      [0, 0, 0],  //0
      [v1[0], v1[1], v1[2]],  //1
      [v2[0] + v1[0], v2[1] + v1[1], v2[2] + v1[2]],  //2
      [v2[0], v2[1], v2[2]],  //3
      ];
  
    plane = [
      [0,1,2,3]
      ];
    //color([1, 1, 1]) 
    #polyhedron(points, plane);
}

function dot(v1, v2) = v1[0]*v2[0] + v1[1]*v2[1] + v1[2]*v2[2];

module vector(x, y, z){
    zenith = atan2((sqrt(x*x+y*y)), z);
    azimuth = 90 + atan2(y, x);
    //Using atan2() fixed everything!
    rotate([zenith, 0, azimuth]){
        cylinder(r = 0.03, h = sqrt(x*x+y*y+z*z), $fn = 300);
    }
    //%cube([abs(x), abs(y), abs(z)], center = true); //DEBUG
}

module cross(v1, v2){
    //v1 × v2
    color([1, 1, 1]) vector(v1[1]*v2[2] - v1[2]*v2[1], v1[2]*v2[0] - v1[0]*v2[2], v1[0]*v2[1] - v1[1]*v2[0]);
    //v1
    color([0.47843, 0.74902, 0.88235]) vector(v1[0], v1[1], v1[2]);
    //v2
    color([0.53333, 0.38824, 0.23529]) vector(v2[0], v2[1], v2[2]);
    //magnitude
    points = [
      [0, 0, 0],  //0
      [v1[0], v1[1], v1[2]],  //1
      [v2[0] + v1[0], v2[1] + v1[1], v2[2] + v1[2]],  //2
      [v2[0], v2[1], v2[2]],  //3
      ];
  
    plane = [
      [0,1,2,3]
      ];
    //color([1, 1, 1]) 
    #polyhedron(points, plane);
    echo(str("‖𝗮 × 𝗯‖ = ", magnitude([v1[1]*v2[2] - v1[2]*v2[1], v1[2]*v2[0] - v1[0]*v2[2], v1[0]*v2[1] - v1[1]*v2[0]])));
}

module projection(v1, v2){ //v1 on v2
    scale([1, 1, 1]) #vector(v2[0]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)), v2[1]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)), v2[2]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)));
    //v1
    color([0.47843, 0.74902, 0.88235]) vector(v1[0], v1[1], v1[2]);
    //v2
    color([0.53333, 0.38824, 0.23529]) vector(v2[0], v2[1], v2[2]);
    projpoints = [
      [0, 0, 0],  //0
      [v1[0], v1[1], v1[2]],  //1
      [v2[0]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)), v2[1]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)), v2[2]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2))]  //2
      ];
  
    shadow = [
      [0,1,2]
      ];
    %polyhedron(projpoints, shadow);
}

/*
Format for m1:
    m = 
    [
        [m11, m12, m13]   ,
        [m21, m22, m23]   ,
        [m31, m32, m33]
    ]
*/

module matmult(m, v1){
    color([0.53333, 0.38824, 0.23529])
    vector(m[0][0]*v1[0] + m[0][1]*v1[1] + m[0][2]*v1[2], 
           m[1][0]*v1[0] + m[1][1]*v1[1] + m[1][2]*v1[2], 
           m[2][0]*v1[0] + m[2][1]*v1[1] + m[2][2]*v1[2]);

    /*
    color([0.47843, 0.74902, 0.88235])
    vector(m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
           m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
           m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]);
    color([0.47843, 0.74902, 0.88235])
    vector(m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
           m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
           m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]);
    color([0.47843, 0.74902, 0.88235])
    vector(m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2], 
           m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2], 
           m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]);
    //DUPLICATE i
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
           m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
           m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]]){
    vector(m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
           m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
           m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]);    
    }
    lol*/
}

module mattrans(m){
    i = [1, 0, 0];
    j = [0, 1, 0];
    k = [0, 0, 1];
    //basis
    color([1, 0.4, 0.4])
    matmult(m, i);
    color([0.4, 1, 0.4])
    matmult(m, j);
    color([0.4, 0.4, 1])
    matmult(m, k);
    //DUPLICATE i
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
               m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
               m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]]){
               matmult(m, i);    
    }
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2], 
               m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2], 
               m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]]){
               matmult(m, i);    
    }
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2]
        +  m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
           m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2]
        +  m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
           m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]
        +  m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]]){
           matmult(m, i);    
    }
    //DUPLICATE j
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
               m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
               m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]]){
               matmult(m, j);    
    }
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2], 
               m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2], 
               m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]]){
               matmult(m, j);    
    }
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2]
        +  m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
           m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2]
        +  m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
           m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]
        +  m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]]){
           matmult(m, j);    
    }
    //DUPLICATE k
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
               m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
               m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]]){
               matmult(m, k);    
    }
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
               m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
               m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]]){
               matmult(m, k);
    }
    color([0.47843, 0.74902, 0.88235])
    translate([m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2]
        +  m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
           m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2]
        +  m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
           m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]
        +  m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]]){
           matmult(m, k);
    }
}

module mat(m, v1){
    matmult(m, v1);
    mattrans(m);
}