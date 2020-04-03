-- lua 5.3

local function u16str(n)
	local a = n&0xFF
	local b = n>>8
	return string.char(a,b)
end

local function rgb15(r,g,b)
	return r | (g<<5) | (b<<10)
end

local function palwrite(pal,fname)
	local f = io.open(fname,'wb')
	for i,v in pairs(pal) do
		f:write(u16str(v))
	end
	f:close()
end

-- palettes
emptypal = {}
for i = 0,0x20-1 do emptypal[i] = 0 end

mamipalN = {
	[0]=rgb15(0,0,0);
	[1]=rgb15(18,7,8);
	[2]=rgb15(14,3,8);
	[3]=rgb15(30,13,10);
}

mamipalN2 = {
	[0]=0;
	[1]=rgb15(14,3,8);
	[2]=rgb15(18,7,8);
	[3]=rgb15(30,13,10);
}
-- main
palwrite(emptypal,"pals/emptypal.bin")
palwrite(mamipalN,"pals/mamipalN.bin")
