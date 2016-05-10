//
//  Tension.swift
//  PrincipalStress
//
//  Created by Luiz Herkenhoff Coelho on 10/05/16.
//  Copyright © 2016 Luiz Herkenhoff Coelho. All rights reserved.
//

struct Tension {
    var x: Double
    var y: Double
    var z: Double
    var xy: Double
    var xz: Double
    var yz: Double
    
    init(x: Double, y: Double, z: Double, xy: Double, xz: Double, yz: Double) {
        self.x = x
        self.y = y
        self.z = z
        self.xy = xy
        self.xz = xz
        self.yz = yz
    }
}