//
//  YieldModel.swift
//  CornYieldEstimator
//
//  Created by WILLIAM CHAPMAN on 7/25/17.
//  Copyright © 2017 WILLIAM CHAPMAN. All rights reserved.
//

import Foundation

public class YieldModel {
    var rowsPerField = 30.0 {
        
        //  if rowsPerField is ever set, go ahead and update
        //  the sampleLengthInches
        didSet {
            self.sampleLengthInches = 6272640.0 / rowsPerField / 1000.0
            print("updated sampleLengthInches to \(self.sampleLengthInches)")
        }
    }
    
    var sampleLengthInches = 6272640.0 / 30.0 / 1000.0
    var numberOfPlantsInSample = 15.0
    var totalEarsInAcre = 15000.0
    var numberOfEarsInSample = 15.0 {
        didSet {
            totalEarsInAcre = numberOfEarsInSample * 1000.0
        }
    }
    
    var yieldPerAcre = 165.0

    var kernalsInRow = [30.0, 30.0, 30.0] {
        didSet {
            aveKernalsInRows = 0.0
            for x in kernalsInRow {
                aveKernalsInRows += x / Double(kernalsInRow.count)
            }
        }
    }
    var kernalsInColumn = [16.0, 16.0, 16.0] {
        didSet {
            aveKernalsInColumn = 0.0
            for x in kernalsInColumn {
                aveKernalsInColumn += x / Double(kernalsInColumn.count)
            }
        }
    }
    
    var aveKernalsInRows = 43.0 {
        didSet {
            yieldPerAcre = (aveKernalsInRows * aveKernalsInColumn * totalEarsInAcre)/kernalsInBushel
        }
    }
    
    var aveKernalsInColumn = 20.0 {
        didSet {
            yieldPerAcre = (aveKernalsInRows * aveKernalsInColumn * totalEarsInAcre)/kernalsInBushel
        }
    }
    
    var kernalsInBushel = 90000.0 {
        didSet {
            yieldPerAcre = (aveKernalsInRows * aveKernalsInColumn * totalEarsInAcre)/kernalsInBushel
        }
    }
}
