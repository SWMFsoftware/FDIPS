rm -rf FDIPS_v1.0 FDIPS_v1.0.tgz FDIPS_all.tar
tar cf FDIPS_all.tar .
mkdir FDIPS_v1.0
cd FDIPS_v1.0
tar xf ../FDIPS_all.tar
rm -rf doc/Tex .cvsignore CVS */CVS */*/CVS */*/*/CVS *~ */*~ */*/*~ */*/*/*~
cd ..
tar czf FDIPS_v1.0.tgz FDIPS_v1.0
rm -f FDIPS_all.tar


