pro fits_to_ascii, silent=silent

; Purpose:
;  Read FITS format input file
;    fitsfile.fits 
; and write three ASCII output files:
;    fitsfile.dat     - data file used by FDIPS, 
;    fitsfile.H       - header file with lots of information
;    fitsfile_idl.out - file for plotting the magnetogram
;                       with longitude, latitude and radial field.
;
; Usage:
;   fits_to_ascii [,/silent]

UseCosTheta=''

read, UseCosTheta, prompt='Is the magnetogram uniform in cos Theta (T/F): '

FileFits     = 'fitsfile.fits'
FileHeader   = 'fitsfile.H'
FileDat      = 'fitsfile.dat'
FileIdl      = 'fitsfile_idl.out' 
VariableName = 'Br [G]'  

Data = readfits(FileFits, ImHeader, silent=silent)

if not keyword_set(silent) then begin
    print,''
    print,'Writing header file ',FileHeader
    print,''
endif

openw,lun,FileHeader,/get_lun
printf,lun,ImHeader
free_lun, lun

; Get image dimensions
s=size(Data)
Nx=s(1)
Ny=s(2)

; Removing missing data by multiply B by sin(lat)^8
;for i=0L,Ny-1 do begin
;    theta=!PI*float(i)/float(Ny)
;    for j=0L,Nx-1 do begin
;        if(abs(Data(i*Nx+j)) ge 5000.0) then $
;          Data(i*Nx+j)=Data(i*Nx+j)*sin(theta)^8
;    endfor
;endfor

openw,lun,FileDat,/get_lun
printf,lun,'#ARRAYSIZE'
printf,lun,strtrim(Nx,2)
printf,lun,strtrim(Ny,2)
printf,lun,' '
printf,lun,'#START'
for i=0L,Ny-1 do begin
   for j=0L,Nx-1 do begin
      printf,lun, format = '(1e14.6)', Data(j,i)
   endfor
endfor

free_lun, lun

if not keyword_set(silent) then begin
    print,''
    print,'Writing IDL file',FileIdl
    print,''
endif

openw,lun,FileIdl,/get_lun
printf,lun,' Longitude [Deg], Latitude [Deg],',VariableName
printf,lun, 0, 0.0,  2, 1, 1
printf,lun, Nx,' ',Ny
printf,lun, (UseCosTheta eq 'T')
printf,lun,'Longitude Latitude Br UseCosTheta'

dY = 2.0/Ny
dX = 360.0/Nx

for i = 0L, Ny-1 do begin
   if (UseCosTheta eq 'T' ) then $
      Latitude = acos(1 - (i + 0.5)*dY)*180.0/!pi - 90 $
   else $
      Latitude = (i+0.5)*180.0/Ny - 90

   for j = 0L, Nx-1 do begin
      printf,lun,format ='(2f10.3, e14.6)', j*dX, Latitude, Data(j,i)
   endfor
endfor

free_lun,lun

if not keyword_set(silent) then print,'Conversion done'

end

