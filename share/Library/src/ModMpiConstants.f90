module ModMpiConstantsOrig

  implicit none
  ! iRealPrec = 0, no modification of MPI_REAL
  integer, parameter :: iRealPrec = 0
  include 'mpif90.h'

end module ModMpiConstantsOrig

module ModMpiConstants

  implicit none
  ! iRealPrec = 1 if the code is compiled with 8 byte reals and 0 otherwise
  integer, parameter :: iRealPrec = (1.00000000011 - 1.0)*10000000000.0
  include 'mpif90.h'

end module ModMpiConstants

