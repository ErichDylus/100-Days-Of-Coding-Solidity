  
// SPDX-License-Identifier: MIT

pragma solidity 0.7.0;

contract DayOne2019 {
    
    uint256 fuelTotal;
    uint256 totalMass;
    uint256 fuelMassTotal;
    uint256[] moduleMasses = [123265, 68442, 94896, 94670, 145483, 93807, 88703, 139755, 53652, 52754, 128052, 81533, 56602, 96476, 87674, 102510, 95735, 69174, 136331, 51266, 148009, 72417, 52577, 86813, 60803, 149232, 115843, 138175, 94723, 85623, 97925, 141772, 63662, 107293, 130779, 147027, 88003, 77238, 53184, 149255, 71921, 139799, 84851, 104899, 92290, 74438, 55631, 58655, 140496, 110176, 138718, 104768, 93177, 53212, 129572, 69877, 139944, 116062, 51362, 135245, 59682, 128705, 98105, 69172, 89244, 109048, 88690, 62124, 53981, 71885, 59216, 107718, 146343, 138788, 73588, 51648, 122227, 54507, 59283, 101230, 93080, 123120, 148248, 102909, 91199, 105704, 113956, 120368, 75020, 103734, 81791, 87323, 77278, 123013, 58901, 136351, 121295, 132994, 84039, 76813];
    uint256[] massIndex;
    
    constructor() {}
    
    function calculateMass() public {
        for (uint256 i = 0; i < moduleMasses.length; i++) {
            uint256 _mass = moduleMasses[i]/3 - 2;
            fuelTotal = fuelTotal + _mass;
            massIndex.push(_mass);
        }
    }
    
    function calculateFuelMass() public {
        for (uint256 x = 0; x < moduleMasses.length; x++) {
            uint256 _fuelMass = massIndex[x] + (massIndex[x]/3 - 2);
            fuelMassTotal = fuelMassTotal + _fuelMass;
            }
    }
    
    function checkFuelTotal() public returns(uint256) {
        totalMass = fuelTotal + fuelMassTotal;
        return(totalMass);
    }
}
