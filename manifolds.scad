//a = [50, 0, 50]; //Enter first vector - 3blue
//b = [-50, 0, -50]; //Enter second vector - 1brown
//c = [0, 50, -50];
//d = [0, -50, 50];

//REMOVE "//" TO USE

//VECTORS
//$vpr = [55, 0, 135];
//vector(1, -2, 3);

//ADDITION
//add(a, b);

//DOT PRODUCT
//echo(str("𝗮 ⋅ 𝗯 = ", dot(a, b)));

//PROJECTION
//projection(b, a);

//CROSS PRODUCT
//cross(a, b);

//TRANSFORMATIONS

// mat(
//     [
//         [1 + $t*(-1), 0 + $t*(1), 0 + $t*(0)]   ,
//         [0 + $t*(0), 1 + $t*(-1), 0 + $t*(1)]   ,
//         [0 + $t*(1), 0 + $t*(0), 1 + $t*(-1)]
//     ]
//     ,   [1, 1, 1]
// );

// mat(
//     [
//         [1 + $t*(0), 0 + $t*(4), 0 + $t*(0)]   ,
//         [0 + $t*(-2), 1 + $t*(-6), 0 + $t*(0)]   ,
//         [0 + $t*(4), 0 + $t*(6), 1 + $t*(1)]
//     ]
//     ,   [-2, 3, 0]
// );


//matrixboi = [[3, 0, 2], [2, 0, -2], [0, 1, 1]];

//matrixbigboi = matTimesMat([[1, 2, 3], [4, 5, 6], [7, 8, 9]], [[1, 2, 1], [2, 4, 6], [7, 2, 5]]);

//echo(str());

u = [1, 1, 1];
v = [-1, -2, 4];
vector(u[0], u[1], u[2]);
vector(v[0], v[1], v[2]);
rishisRotationProblem(u, v);

//This is the module used for Rishi's interview problem!
module rishisRotationProblem(u, v){
    //Normalize u
    normalU = normalized(u);
    echo(magnitude(normalU));
    
    //Normalize (u × v) × u 
    normalUCrossVCrossU = normalized(crossproduct(crossproduct(u, v), u));
    echo(magnitude(normalUCrossVCrossU));

    //Normalize u × v
    normalUCrossV = normalized(crossproduct(u, v));
    echo(magnitude(normalUCrossV));

    //Checking Angles:
    echo(acos(dot(normalU, normalUCrossVCrossU)/(magnitude(normalU)*magnitude(normalUCrossVCrossU))));
    echo(acos(dot(normalU, normalUCrossV)/(magnitude(u)*magnitude(normalUCrossV))));
    echo(acos(dot(normalUCrossV, normalUCrossVCrossU)/(magnitude(normalUCrossV)*magnitude(normalUCrossVCrossU))));

    //Inverse of change of basis matrix
    cobInverse = [normalU, normalUCrossVCrossU, normalUCrossV];
    echo(matDet(cobInverse));

    //Change of basis matrix
    cob = matInverse(cobInverse);
    echo(matDet(cob));

    //Angle between u and v
    phi = -acos(dot(u, v)/(magnitude(u)*magnitude(v)));
    echo(phi);

    //Rotation matrix
    matRotation = [[cos(phi), sin(phi), 0], [-sin(phi), cos(phi), 0], [0, 0, 1]];
    echo(matDet(matRotation));

    twoMat = matTimesMat(matRotation, cobInverse);
    echo(matDet(twoMat));

    //threeMat = matTimesMat(cobInverse, twoMat);
    threeMat = matTimesMat(cob, twoMat);
    echo(matDet(threeMat));

    mat(
        [
            [1 + $t*(threeMat[0][0] - 1), 0 + $t*threeMat[0][1], 0 + $t*threeMat[0][2]]   ,
            [0 + $t*threeMat[1][0], 1 + $t*(threeMat[1][1] - 1), 0 + $t*threeMat[1][2]]   ,
            [0 + $t*threeMat[2][0], 0 + $t*threeMat[2][1], 1 + $t*(threeMat[2][2] - 1)]
        ],
        u
    );  
}

//$vpt = [0, 0, 0];
//$vpr = [ 39.00, 0.00, 151.80 ]; //[67, 0, 149 + $t*(30)];
//$vpd = 43.17; //8 + $t*(25);

function magnitude(v1) = sqrt(v1[0]*v1[0] + v1[1]*v1[1] + v1[2]*v1[2]);
function normalized(v) = [(v[0]/magnitude(v)), (v[1]/magnitude(v)), (v[2]/magnitude(v))];

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

function crossproduct(v1, v2) = [v1[1]*v2[2] - v1[2]*v2[1], v1[2]*v2[0] - v1[0]*v2[2], v1[0]*v2[1] - v1[1]*v2[0]];

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
    echo(str("𝗮 × 𝗯 = ", "(", v1[1]*v2[2] - v1[2]*v2[1], ", ", v1[2]*v2[0] - v1[0]*v2[2], ", ", v1[0]*v2[1] - v1[1]*v2[0], ")ᵀ"));
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
    echo(str(m[0][0]*v1[0] + m[0][1]*v1[1] + m[0][2]*v1[2], 
           m[1][0]*v1[0] + m[1][1]*v1[1] + m[1][2]*v1[2], 
           m[2][0]*v1[0] + m[2][1]*v1[1] + m[2][2]*v1[2]));
*/
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
    for(i = [[1, 0, 0], [-1, 0, 0]]){
        for(j = [[0, 1, 0], [0, -1, 0]]){
            for(k = [[0, 0, 1], [0, 0, -1]]){
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
        }
    }
}

module mat(m, v1){
    matmult(m, v1);
    mattrans(m);
}

function matDet(a) = a[0][0]*a[1][1]*a[2][2]
                   + a[0][1]*a[1][2]*a[2][0]
                   + a[0][2]*a[1][0]*a[2][1]
                   - a[0][2]*a[1][1]*a[2][0]
                   - a[0][1]*a[1][0]*a[2][2]
                   - a[0][0]*a[1][2]*a[2][1];

function matInverse(a) = [[(a[1][1]*a[2][2] - a[1][2]*a[2][1])/matDet(a),
                           (a[0][2]*a[2][1] - a[0][1]*a[2][2])/matDet(a),
                           (a[0][1]*a[1][2] - a[0][2]*a[1][1])/matDet(a)], 
                          [(a[1][2]*a[2][0] - a[1][0]*a[2][2])/matDet(a),
                           (a[0][0]*a[2][2] - a[0][2]*a[2][0])/matDet(a),
                           (a[0][2]*a[1][0] - a[0][0]*a[1][2])/matDet(a)], 
                          [(a[1][0]*a[2][1] - a[1][1]*a[2][0])/matDet(a),
                           (a[0][1]*a[2][0] - a[0][0]*a[2][1])/matDet(a),
                           (a[0][0]*a[1][1] - a[0][1]*a[1][0])/matDet(a)]];

function matTimesVec(a, v) = [(v[0]*a[0][0] + v[1]*a[0][1] + v[2]*a[0][2]), 
                              (v[0]*a[1][0] + v[1]*a[1][1] + v[2]*a[1][2]),
                              (v[0]*a[2][0] + v[1]*a[2][1] + v[2]*a[2][2])];

function matTimesMat(a, b) = [[matTimesVec(a, [b[0][0], b[1][0], b[2][0]])[0], matTimesVec(a, [b[0][1], b[1][1], b[2][1]])[0], matTimesVec(a, [b[0][2], b[1][2], b[2][2]])[0]], 
                              [matTimesVec(a, [b[0][0], b[1][0], b[2][0]])[1], matTimesVec(a, [b[0][1], b[1][1], b[2][1]])[1], matTimesVec(a, [b[0][2], b[1][2], b[2][2]])[1]], 
                              [matTimesVec(a, [b[0][0], b[1][0], b[2][0]])[2], matTimesVec(a, [b[0][1], b[1][1], b[2][1]])[2], matTimesVec(a, [b[0][2], b[1][2], b[2][2]])[2]]];

// LEGACY CODE

// a = [50, 0, 50]; //Enter first vector - 3blue
// b = [-50, 0, -50]; //Enter second vector - 1brown
// c = [0, 50, -50];
// d = [0, -50, 50];

// //REMOVE "//" TO USE

// //VECTORS
// %vector(a[0], a[1], a[2]);
// %vector(b[0], b[1], b[2]);
// #vector(c[0], c[1], c[2]);
// #vector(d[0], d[1], d[2]);

// //ADDITION
// //add(a, b);

// //DOT PRODUCT
// //echo(str("𝗮 ⋅ 𝗯 = ", dot(a, b)));

// //PROJECTION
// //
// //projection(b, a);

// //CROSS PRODUCT
// //cross(a, b);

// //TRANSFORMATIONS

// mat(
//     [
//         [1 + $t*(0), 0 + $t*(-1), 0 + $t*(-1)]   ,
//         [0 + $t*(0), 1 + $t*(1), 0 + $t*(0)]   ,
//         [0 + $t*(-1), 0 + $t*(-1), 1 + $t*(0)]
//     ]
//     ,   [0, 5, -5]
// );


// //200

// //$vpt = [0, 0, 0];
// //$vpr = [ 39.00, 0.00, 151.80 ]; //[67, 0, 149 + $t*(30)];
// //$vpd = 43.17; //8 + $t*(25);

// function magnitude(v1) = sqrt(v1[0]*v1[0] + v1[1]*v1[1] + v1[2]*v1[2]);

// module add(v1, v2){
//     vector(v1[0] + v2[0], v1[1] + v2[1], v1[2] + v2[2]);
//     color([0.47843, 0.74902, 0.88235])
//     vector(v1[0], v1[1], v1[2]);
//     color([0.53333, 0.38824, 0.23529])
//     vector(v2[0], v2[1], v2[2]);
//     points = [
//       [0, 0, 0],  //0
//       [v1[0], v1[1], v1[2]],  //1
//       [v2[0] + v1[0], v2[1] + v1[1], v2[2] + v1[2]],  //2
//       [v2[0], v2[1], v2[2]],  //3
//       ];
  
//     plane = [
//       [0,1,2,3]
//       ];
//     //color([1, 1, 1]) 
//     #polyhedron(points, plane);
// }

// function dot(v1, v2) = v1[0]*v2[0] + v1[1]*v2[1] + v1[2]*v2[2];

// module vector(x, y, z){
//     zenith = atan2((sqrt(x*x+y*y)), z);
//     azimuth = 90 + atan2(y, x);
//     //Using atan2() fixed everything!
//     rotate([zenith, 0, azimuth]){
//         cylinder(r = 0.03, h = sqrt(x*x+y*y+z*z), $fn = 300);
//     }
//     //%cube([abs(x), abs(y), abs(z)], center = true); //DEBUG
// }

// module cross(v1, v2){
//     //v1 × v2
//     color([1, 1, 1]) vector(v1[1]*v2[2] - v1[2]*v2[1], v1[2]*v2[0] - v1[0]*v2[2], v1[0]*v2[1] - v1[1]*v2[0]);
//     //v1
//     color([0.47843, 0.74902, 0.88235]) vector(v1[0], v1[1], v1[2]);
//     //v2
//     color([0.53333, 0.38824, 0.23529]) vector(v2[0], v2[1], v2[2]);
//     //magnitude
//     points = [
//       [0, 0, 0],  //0
//       [v1[0], v1[1], v1[2]],  //1
//       [v2[0] + v1[0], v2[1] + v1[1], v2[2] + v1[2]],  //2
//       [v2[0], v2[1], v2[2]],  //3
//       ];
  
//     plane = [
//       [0,1,2,3]
//       ];
//     //color([1, 1, 1]) 
//     #polyhedron(points, plane);
//     echo(str("‖𝗮 × 𝗯‖ = ", magnitude([v1[1]*v2[2] - v1[2]*v2[1], v1[2]*v2[0] - v1[0]*v2[2], v1[0]*v2[1] - v1[1]*v2[0]])));
// }

// module projection(v1, v2){ //v1 on v2
//     scale([1, 1, 1]) #vector(v2[0]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)), v2[1]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)), v2[2]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)));
//     //v1
//     color([0.47843, 0.74902, 0.88235]) vector(v1[0], v1[1], v1[2]);
//     //v2
//     color([0.53333, 0.38824, 0.23529]) vector(v2[0], v2[1], v2[2]);
//     projpoints = [
//       [0, 0, 0],  //0
//       [v1[0], v1[1], v1[2]],  //1
//       [v2[0]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)), v2[1]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2)), v2[2]*(dot(v1, v2))/(magnitude(v2)*magnitude(v2))]  //2
//       ];
  
//     shadow = [
//       [0,1,2]
//       ];
//     %polyhedron(projpoints, shadow);
// }

// /*
// Format for m1:
//     m = 
//     [
//         [m11, m12, m13]   ,
//         [m21, m22, m23]   ,
//         [m31, m32, m33]
//     ]
// */

// module matmult(m, v1){
//     color([0.53333, 0.38824, 0.23529])
//     vector(m[0][0]*v1[0] + m[0][1]*v1[1] + m[0][2]*v1[2], 
//            m[1][0]*v1[0] + m[1][1]*v1[1] + m[1][2]*v1[2], 
//            m[2][0]*v1[0] + m[2][1]*v1[1] + m[2][2]*v1[2]);

//     /*
//     color([0.47843, 0.74902, 0.88235])
//     vector(m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
//            m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
//            m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]);
//     color([0.47843, 0.74902, 0.88235])
//     vector(m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
//            m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
//            m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]);
//     color([0.47843, 0.74902, 0.88235])
//     vector(m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2], 
//            m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2], 
//            m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]);
//     //DUPLICATE i
//     color([0.47843, 0.74902, 0.88235])
//     translate([m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
//            m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
//            m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]]){
//     vector(m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
//            m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
//            m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]);    
//     }
//     lol*/
// }

// module mattrans(m){
//     for(i = [[1, 0, 0], [-1, 0, 0]]){
//         for(j = [[0, 1, 0], [0, -1, 0]]){
//             for(k = [[0, 0, 1], [0, 0, -1]]){
//                 //basis
//                 color([1, 0.4, 0.4])
//                 matmult(m, i);
//                 color([0.4, 1, 0.4])
//                 matmult(m, j);
//                 color([0.4, 0.4, 1])
//                 matmult(m, k);
//                 //DUPLICATE i
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
//                         m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
//                         m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]]){
//                         matmult(m, i);    
//                 }
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2], 
//                         m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2], 
//                         m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]]){
//                         matmult(m, i);    
//                 }
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2]
//                     +  m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
//                     m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2]
//                     +  m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
//                     m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]
//                     +  m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]]){
//                     matmult(m, i);    
//                 }
//                 //DUPLICATE j
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
//                         m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
//                         m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]]){
//                         matmult(m, j);    
//                 }
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2], 
//                         m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2], 
//                         m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]]){
//                         matmult(m, j);    
//                 }
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*k[0] + m[0][1]*k[1] + m[0][2]*k[2]
//                     +  m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
//                     m[1][0]*k[0] + m[1][1]*k[1] + m[1][2]*k[2]
//                     +  m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
//                     m[2][0]*k[0] + m[2][1]*k[1] + m[2][2]*k[2]
//                     +  m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]]){
//                     matmult(m, j);    
//                 }
//                 //DUPLICATE k
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
//                         m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
//                         m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]]){
//                         matmult(m, k);    
//                 }
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2], 
//                         m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2], 
//                         m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]]){
//                         matmult(m, k);
//                 }
//                 color([0.47843, 0.74902, 0.88235])
//                 translate([m[0][0]*j[0] + m[0][1]*j[1] + m[0][2]*j[2]
//                     +  m[0][0]*i[0] + m[0][1]*i[1] + m[0][2]*i[2], 
//                     m[1][0]*j[0] + m[1][1]*j[1] + m[1][2]*j[2]
//                     +  m[1][0]*i[0] + m[1][1]*i[1] + m[1][2]*i[2], 
//                     m[2][0]*j[0] + m[2][1]*j[1] + m[2][2]*j[2]
//                     +  m[2][0]*i[0] + m[2][1]*i[1] + m[2][2]*i[2]]){
//                     matmult(m, k);
//                 }
//             }
//         }
//     }
// }

// module mat(m, v1){
//     matmult(m, v1);
//     mattrans(m);
// }