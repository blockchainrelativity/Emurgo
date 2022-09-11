type ListInts = [Int]
type Towerstype = [ListInts]

towers :: Towerstype -> Towerstype
towers = [[1,2,3,4,5],[],[]]

left2center :: Towerstype -> Towerstype
left2center [(x:xs),ys,zs] = [xs,(x:ys),zs]

right2center :: Towerstype -> Towerstype
-- right2center [[x:xs],ys,zs]

-- center2right [[x:xs],ys,zs]

-- center2left [[x:xs],ys,zs]