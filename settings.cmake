set (CMAKE_BUILD_TYPE Release CACHE STRING "" FORCE)
set (CMAKE_CXX_FLAGS "-D_GLIBCXX_USE_CXX11_ABI=0 -pipe -fstack-protector-strong -O2 -march=native" CACHE STRING "" FORCE)
set (CMAKE_C_FLAGS "-pipe -fstack-protector-strong -O2 -march=native -mtune=native" CACHE STRING "" FORCE)
set (CMAKE_INSTALL_PREFIX /usr CACHE PATH "" FORCE)
set (BUILD_SHARED_LIBS OFF CACHE BOOL "" FORCE)
set (builtin_afterimage ON CACHE BOOL "" FORCE)
set (builtin_ftgl OFF CACHE BOOL "" FORCE)
set (builtin_freetype OFF CACHE BOOL "" FORCE)
set (builtin_glew OFF CACHE BOOL "" FORCE)
set (builtin_pcre OFF CACHE BOOL "" FORCE)
set (builtin_zlib OFF CACHE BOOL "" FORCE)
set (builtin_lzma OFF CACHE BOOL "" FORCE)
set (builtin_llvm ON CACHE BOOL "" FORCE)
set (builtin_tbb OFF CACHE BOOL "" FORCE)
set (castor OFF CACHE BOOL "" FORCE)
set (cling ON CACHE BOOL "" FORCE)
set (cxx11 ON CACHE BOOL "" FORCE)
set (davix OFF CACHE BOOL "" FORCE)
set (dcache OFF CACHE BOOL "" FORCE)
set (fail-on-missing ON CACHE BOOL "" FORCE)
set (fortran OFF CACHE BOOL "" FORCE)
set (gfal OFF CACHE BOOL "" FORCE)
set (glite OFF CACHE BOOL "" FORCE)
set (gnuinstall ON CACHE BOOL "" FORCE)
set (gsl_shared ON CACHE BOOL "" FORCE)
set (hdfs OFF CACHE BOOL "" FORCE)
set (mathmore ON CACHE BOOL "" FORCE)
set (minuit2 ON CACHE BOOL "" FORCE)
set (monalisa OFF CACHE BOOL "" FORCE)
set (mt ON CACHE BOOL "" FORCE)
set (opengl ON CACHE BOOL "" FORCE)
set (oracle OFF CACHE BOOL "" FORCE)
set (pythia8 ON CACHE BOOL "" FORCE)
set (qt OFF CACHE BOOL "" FORCE)
set (qtgsi OFF CACHE BOOL "" FORCE)
set (rfio OFF CACHE BOOL "" FORCE)
set (roofit ON CACHE BOOL "" FORCE)
set (shared ON CACHE BOOL "" FORCE)
set (tbb ON CACHE BOOL "" FORCE)
set (testing OFF CACHE BOOL "" FORCE)
set (tmva ON CACHE BOOL "" FORCE)
set (xft ON CACHE BOOL "" FORCE)
set (x11 ON CACHE BOOL "" FORCE)
