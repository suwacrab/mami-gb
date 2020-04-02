SECTION "main_ram",WRAM0[$C000]
vbl_flag: DS $01
time: DS $02
; suwa shot:
; $08 : pos & vel
; $02 : dead,id
suwa_ram: DS $80 * ($0A)	
