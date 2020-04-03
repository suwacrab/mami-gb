SECTION "main_ram",WRAM0[$C000]
time: DS $02
joyA: DS $01
joyB: DS $01
; suwa shot:
; $08 : pos & vel
; $02 : dead,id
suwa_ram: DS $80 * ($0A)	
