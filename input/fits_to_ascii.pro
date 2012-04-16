pro fits_to_ascii, FileIn, DataName, silent=silent

; Purpose:
;  Read fits file and write header to a file with .H extension
;  and the data into a ASCII file.
;
; Usage:
;   fits_to_tec [,FileName] [,DataName] [,/silent]
;
; DataName is a string which contains the type of data of the image
; it is used as the data type header of the Tecplot file
; for example: DataName='Br[G]' or 'U[km/s]'
; Add /silent to suppress verbose information.

;if n_elements(FileIn) eq 0 then begin 
;    FileIn = 'fitsfile.fits'
;endif

nMax=180
CR=0

; read,nMax,prompt='enter order of harmonics (nMax:)' 
; nMax=strtrim(nMax,2)
; read,CR,prompt='enter Carrington Rotation number:' 
; CR=strtrim(CR,2)

UseCosTheta=''

read,UseCosTheta,prompt='enter T/F for UseCosTheta: '

FileFits  = 'fitsfile.fits'
FileHeader='fitsfile.H'
FileDat='fitsfile.dat'
FileIdl='fitsfile_idl.out' 
DataName='Br [G]'  

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
      ;if(abs(Data(i*Nx+j)) gt 1900.0)then $
      ;   Data(i*Nx+j)=abs(Data(i*Nx+j))*Data(i*Nx+j)/abs(Data(i*Nx+j)+1e-3)
      printf,lun, format = '(1e14.6)',Data(i*Nx+j)
   endfor
endfor

free_lun, lun

if not keyword_set(silent) then begin
    print,''
    print,'Writing IDL file',FileIdl
    print,''
endif

openw,lun,FileIdl,/get_lun
printf,lun,' Longitude [Deg], Latitude [Deg],',DataName
printf,lun, 0, 0.0,  2, 1, 1
printf,lun, Nx,' ',Ny
printf,lun, '0.0'
printf,lun,'Longitude Latitude Br SomeParameter'


dY = 2.0/Ny
dX = 360.0/Nx

for i=0L,Ny-1 do begin
    for j=0L,Nx-1 do begin
       if (UseCosTheta eq 'T' ) then begin
        printf,lun,format ='(2f10.3, e14.6)', j*dX, $
                                       acos(1 - (i + 0.5)*dY)*180.0/!pi - 90,$
                                       Data(j,i)
     endif else begin
        printf,lun,format ='(2f10.3, e14.6)', j*dX, (i+0.5)*180.0/Ny - 90, Data(j,i)
     endelse
       
    endfor
endfor

free_lun,lun

if not keyword_set(silent) then print,'Conversion done'

end

