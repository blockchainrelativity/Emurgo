type ListInts = [Int]
type Towerstype = [ListInts]

towers :: Towerstype
towers = [[1,2,3,4,5],[],[]]

move2center :: Towerstype -> Towerstype
move2center n [xs,ys,zs] = [xs,n:ys,zs]

move2right :: Towerstype -> Towerstype
move2right n [xs,ys,zs] = [xs,ys,n:zs]

move2left :: Towerstype -> Towerstype
move2left n [xs,ys,zs] = [n:xs,ys,zs]

choosePath :: Towerstype -> Towerstype
choosePath [x:xs,y:ys,z:zs]
 | x > y && x > z     = if y < z then move2center x [xs,ys,zs] else move2right x [xs,ys,zs]
 | y > x && y > z     = if x < z then move2left y [xs,ys,zs] else move2right y [xs,ys,zs]
 | z > x && z > y     = if x < y then move2left z [xs,ys,zs] else move2center z [xs,ys,zs]
choosePath [[],y:ys,z:zs]
 | y > z              = move2left y [[],ys,z:zs]
 | otherwise          = move2left z [[],y:ys,zs]
choosePath [x:xs,[],z:zs]
 | x > z              = move2center x [xs,[],z:zs]
 | otherwise          = move2center z [xs,[],z:zs]
choosePath [x:xs,y:ys,[]]
 | x > y              = move2right x [xs,y:ys,[]]
 | otherwise          = move2right y [x:xs,ys,[]]
choosePath [x:xs,[],[]] = move2center x [xs,[],[]]
choosePath [[],[],z:zs] = [[],[],z:zs]
-- choosePath [[],y:ys,[]]
--  | move2right y [y:[],y:ys,[]]] =
--  | otherwise          = move2right y [y:[],ys,y:[]]




-- left2center :: Towerstype -> Towerstype
-- left2center [(x:xs),ys,zs] = [xs,(x:ys),zs]

-- right2center :: Towerstype -> Towerstype
-- right2center [xs,ys,(z:zs)] = [xs,(z:ys),zs]

-- left2right :: Towerstype -> Towerstype
-- left2right [(x:xs),ys,zs] = [xs,ys,(x:zs)]

-- right2left :: Towerstype -> Towerstype
-- right2left [xs,ys,(z:zs)] = [(z:xs),ys,zs]

-- center2right :: Towerstype -> Towerstype
-- center2right [xs,(y:ys),zs] = [xs,ys,(y:zs)]

-- center2left :: Towerstype -> Towerstype
-- center2left [xs,(y:ys),zs] = [(y:xs),ys,zs]

-- loop :: Towerstype -> Towerstype
-- loop = right2center (right2left (left2center (center2right (center2right (left2right (right2center (left2right (left2center towers))))))))

