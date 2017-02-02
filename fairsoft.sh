package: FairSoft
version: "feb17dev"
requires:
 - googletest
 - boost
 - geant4
 - root
 - gsl
 - pythia6
 - pythia
 - hepmc
 - AlfaXRootD
 - geant3
 - geant4_vmc
 - vgm
 - zeromq
 - protobuf
 - nanomsg
 - flatbuffers
 - Millepede
prepend_path:
  PATH: "$FAIRSOFT_ROOT/bin"
---
#!/bin/sh

cat > fairsoft-config << EOF
#!/bin/bash

_version=$PKGVERSION
_cc=$(which $CC)
_cxx=$(which $CXX)
_f77=$(which $FC)
_cxxflags="$CXXFLAGS"
_root_version=5

usage="\
Usage: fairsoft-config [--version] [--cc] [--cxx] [--f77] \
 [--cxxflags] [--root-version] [--help]"

if [ \$# -eq 0 -o \$# -gt 1 ]; then
   echo "\${usage}" 1>&2
   exit 1
fi

out=""


case \$1 in
    --version)
      ### Output the fairsoft version
      out="$out \${_version}"
      ;;
    --cc)
      ### Output the full path of used c compiler
      out="$out \${_cc}"
      ;;
    --cxx)
      ### Output the full path of used cxx compiler
      out="$out \${_cxx}"
      ;;
    --cxxflags)
      ### Output the used special cxx compiler flags
      out="$out \${_cxxflags}"
      ;;
    --f77)
      ### Output the full path of used fortran compiler
      out="$out \${_f77}"
      ;;
    --root-version)
      ### Output the major version of root
      out="$out \${_root_version}"
      ;;
    --help)
      ### Print a help message
      echo "Usage: `basename \$0` [options]"
      echo ""
      echo "  --version            Print the fairsoft version"
      echo "  --cc                 Print the full path of the used c compiler"
      echo "  --cxx                Print the full path of the used cxx compiler"
      echo "  --f77                Print the full path of the used fortran compiler"
      echo "  --cxxflags           Print the used special cxx compiler flags"
      echo "  --root-version       Print the major version of ROOT (5 or 6)"
      exit 0
      ;;
    *)
      ### Give an error
      echo "Unknown argument \"$1\"!" 1>&2
      echo "\${usage}" 1>&2
      exit 1
      ;;
esac

### Output the stuff
echo \$out
EOF

mkdir -p $INSTALLROOT/bin
cp fairsoft-config $INSTALLROOT/bin
chmod u+x $INSTALLROOT/bin/fairsoft-config
