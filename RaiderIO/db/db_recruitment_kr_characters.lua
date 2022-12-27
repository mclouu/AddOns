--
-- Copyright (c) 2022 by Ludicrous Speed, LLC
-- All rights reserved.
--
local provider={name=...,data=3,region="kr",date="2022-12-27T07:07:53Z",numCharacters=22651,db={}}
local F

F = function() provider.db["아즈샤라"]={0,"민트초코떡볶이","민트초코불고기"} end F()

F = nil
RaiderIO.AddProvider(provider)
